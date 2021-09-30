//
//  PlayingViewController.m
//  lat
//
//  Created by Techsviewer on 7/23/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "PlayingViewController.h"
#import "GamePlayView.h"
#import "GameRule.h"
#import "LAChipsPlayItem.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface PlayingViewController ()<GamePlayViewDelegate, AVAudioPlayerDelegate>
{
    NSMutableArray * subLevelArray;
    NSMutableDictionary * questionAnswerArray;
    
    int currentSubLevel;
    
    int totalScore;
    int subMissionScore;
    
    ///
    NSMutableArray * remainQuestionArray;
    NSMutableArray * remainAnswerArray;
    int qaIndex;
    int correctType;
    
    /// token   coin
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_part;
@property (weak, nonatomic) IBOutlet UIButton *btn_checker;

@property (weak, nonatomic) IBOutlet UIView *view_question;
@property (weak, nonatomic) IBOutlet UILabel *lbl_question;
@property (weak, nonatomic) IBOutlet GamePlayView *gameView;

@property (nonatomic, retain) AVAudioPlayer  * avPlayer;
@property (nonatomic, retain) AVAudioPlayer  * bgPlayer;
@end

@implementation PlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    totalScore = 0;
    // Do any additional setup after loading the view.
    AudioSessionInitialize (NULL, NULL, NULL, NULL);
    AudioSessionSetActive(true);
    
    // Allow playback even if Ring/Silent switch is on mute
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty (kAudioSessionProperty_AudioCategory,
                             sizeof(sessionCategory),&sessionCategory);
    
    self.gameView.player_delegate = self;
    [self.lbl_title setText:self.levelName];
    [self.lbl_part setText:@""];
    
    NSError * error;
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if(error)
        NSLog(@"%@", error.localizedDescription);
    
    NSUserDefaults * userDfault = [NSUserDefaults standardUserDefaults];
    BOOL isMusicOn = [userDfault boolForKey:@"setting_music"];
    if(isMusicOn)
        [self playBGSound:@"background"];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchData];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.gameView releaseMemory];
    for (UIView * subView in self.gameView.subviews) {
        [subView removeFromSuperview];
    }
    
    if(self.avPlayer && self.avPlayer.isPlaying){
        [self.avPlayer stop];
    }
    if(self.bgPlayer && self.bgPlayer.isPlaying){
        [self.bgPlayer stop];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) fetchData
{
    subLevelArray = [GameRule getScenarioForLevel:self.levelNum];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    PFQuery * query = [PFQuery queryWithClassName:PARSE_TABLE_GAMESET];
    [query whereKey:PARSE_GAMESET_OWNER equalTo:[PFUser currentUser]];
    [query whereKey:PARSE_GAMESET_USER equalTo:self.family];
    [query whereKey:PARSE_GAMESET_LEVELNUM equalTo:[NSNumber numberWithInt:self.levelNum]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * object, NSError * error){
        if(object){
            questionAnswerArray = object[PARSE_GAMESET_GAMEDATA];
            currentSubLevel = [object[PARSE_GAMESET_SUBLEVEL] intValue];
            if(currentSubLevel == subLevelArray.count)
                currentSubLevel = 0;
        }else{
            currentSubLevel = 0;
            questionAnswerArray = [GameRule getDefaultScenarioForLevel:self.levelNum];
        }
        [SVProgressHUD dismiss];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!questionAnswerArray){
                [Util showAlertTitle:self title:@"Error" message:[NSString stringWithFormat:@"Game level %d for %@ was not designed yet.", self.levelNum, self.family[PARSE_FAMILY_NAME]] finish:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                [self startMission];
            }
        });
    }];
}
/*
 #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *) suffleArray:(NSMutableArray*)array
{
    NSUInteger count = [array count];
    if(count <= 1) return array;
    for(NSUInteger i=0;i<count-1;++i){
        NSInteger remainCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remainCount);
        [array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return array;
}
- (NSMutableArray*) removeFirstItem:(NSMutableArray*)array
{
    NSMutableArray * items = [NSMutableArray new];
    for(int i=1;i<array.count;i++){
        [items addObject:[array objectAtIndex:i]];
    }
    return items;
}
#pragma mark - select problem
- (void) startMission
{
    if(currentSubLevel > subLevelArray.count -1){
        int score = [self.family[PARSE_FAMILY_POINTS] intValue];
        score += totalScore;
        self.family[PARSE_FAMILY_POINTS] = [NSNumber numberWithInt:score];
        int level = [self.family[PARSE_FAMILY_LEVEL] intValue];
        if(level < self.levelNum){
            level = self.levelNum;
            self.family[PARSE_FAMILY_LEVEL] = [NSNumber numberWithInt:level];
        }
        int coin = [self.family[PARSE_FAMILY_COINS] intValue];
        coin = coin + 1;
        self.family[PARSE_FAMILY_COINS] = [NSNumber numberWithInt:coin];
        
        [Util showAlertTitle:self title:@"Congratulation" message:@"Great job! You passed the level!" finish:^{
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [self.family saveInBackgroundWithBlock:^(BOOL success, NSError*error){
                [SVProgressHUD dismiss];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }];
        }];
        return;
    }
    int currentCharactorId = [[subLevelArray objectAtIndex:currentSubLevel] intValue];
    [self.gameView initScenarioIndex:currentCharactorId];
    remainQuestionArray = [NSMutableArray new];
    remainAnswerArray = [NSMutableArray new];
    for(NSString* key in questionAnswerArray.allKeys){
        NSMutableArray * answerArray = [questionAnswerArray objectForKey:key];
        for(NSNumber * number in answerArray){
            [remainAnswerArray addObject:number];
            [remainQuestionArray addObject:key];
        }
    }
    remainQuestionArray = [self suffleArray:remainQuestionArray];
    qaIndex = 0;
    subMissionScore = 0;
    [self.lbl_part setText:[NSString stringWithFormat:@"%d/%d", qaIndex + 1 , (int)remainQuestionArray.count]];
    [self.gameView initialScenario:questionAnswerArray];
    [self gotoQAPlay];
}
- (void) gotoQAPlay
{
    [self.btn_checker setImage:[UIImage imageNamed:@"ico_check_gray"] forState:UIControlStateNormal];
    [self.btn_checker setSelected:NO];
    
    for (UIView * subView in self.gameView.subviews) {
        [subView setUserInteractionEnabled:YES];
    }
    if(qaIndex > [self totalMissionCount] -1){
        if(![self isPassSubMission]){
            [Util showAlertTitle:self title:@"Mission fail" message:@"You can't pass this charactor. Please try again." finish:^{
                [self startMission];
            }];
            return;
        }
        /////   currentSubLevel ++
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        PFQuery * query = [PFQuery queryWithClassName:PARSE_TABLE_GAMESET];
        [query whereKey:PARSE_GAMESET_OWNER equalTo:[PFUser currentUser]];
        [query whereKey:PARSE_GAMESET_USER equalTo:self.family];
        [query whereKey:PARSE_GAMESET_LEVELNUM equalTo:[NSNumber numberWithInt:self.levelNum]];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject * object, NSError * error){
            if(object){
                object[PARSE_GAMESET_SUBLEVEL] = [NSNumber numberWithInt:currentSubLevel+1];
                [object saveInBackgroundWithBlock:^(BOOL success, NSError * error){
                    [SVProgressHUD dismiss];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self gotoNextCharactor];
                    });
                }];
            }else{
                PFObject * gameData = [PFObject objectWithClassName:PARSE_TABLE_GAMESET];
                gameData[PARSE_GAMESET_OWNER] = [PFUser currentUser];
                gameData[PARSE_GAMESET_USER] = self.family;
                gameData[PARSE_GAMESET_LEVELNUM] = [NSNumber numberWithInt:self.levelNum];
                gameData[PARSE_GAMESET_GAMEDATA] = questionAnswerArray;
                gameData[PARSE_GAMESET_SUBLEVEL] = [NSNumber numberWithInt:currentSubLevel+1];
                [gameData saveInBackgroundWithBlock:^(BOOL success, NSError * error){
                    [SVProgressHUD dismiss];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self gotoNextCharactor];
                    });
                }];
            }
        }];
    }else{
        [self.lbl_part setText:[NSString stringWithFormat:@"%d/%d", qaIndex + 1 , [self totalMissionCount]]];
        NSNumber * questionNumber = [remainQuestionArray firstObject];
        correctType = [questionNumber intValue];
        if([questionNumber intValue] == GAMERULE_GREEN){
            [self.lbl_question setText:@"Which body region is appropriate to touch?"];
            [self.view_question setBackgroundColor:[UIColor colorWithRed:0 green:156/255.f blue:120/255.f alpha:1]];
        }else if([questionNumber intValue] == GAMERULE_RED){
            [self.lbl_question setText:@"Which body region is inappropriate to touch?"];
            [self.view_question setBackgroundColor:[UIColor colorWithRed:255/255.f green:102/255.f blue:102/255.f alpha:1]];
        }else if([questionNumber intValue] == GAMERULE_YELLOW){
            [self.lbl_question setText:@"Which body region is circumstancial to touch?"];
            [self.view_question setBackgroundColor:[UIColor colorWithRed:255/255.f green:248/255.f blue:57/255.f alpha:1]];
        }
    }
}
- (int) totalMissionCount
{
    int subMissionCount = 0;
    for(NSString* key in questionAnswerArray.allKeys){
        NSMutableArray * answerArray = [questionAnswerArray objectForKey:key];
        for(NSNumber * number in answerArray){
            subMissionCount ++;
        }
    }
    return subMissionCount;
}
- (BOOL) isPassSubMission
{
    int subMissionCount = 0;
    for(NSString* key in questionAnswerArray.allKeys){
        NSMutableArray * answerArray = [questionAnswerArray objectForKey:key];
        for(NSNumber * number in answerArray){
            subMissionCount ++;
        }
    }
    if(((subMissionScore * 100.f) /  subMissionCount) > 80){
        if(subMissionScore == subMissionCount){
            int token = [self.family[PARSE_FAMILY_TOKENS] intValue];
            token = token + 1;
            self.family[PARSE_FAMILY_TOKENS] = [NSNumber numberWithInt:token];
            [self.family saveInBackground];
        }
        return YES;
    }
    return NO;
}
- (void) gotoNextCharactor
{
    currentSubLevel ++;
    [self startMission];
}
- (NSMutableArray *) removeItem:(id)object inArray:(NSMutableArray*)array
{
    NSMutableArray * newArray = [NSMutableArray new];
    for(id subItem in array){
        if( subItem != object)
            [newArray addObject:subItem];
    }
    return newArray;
}
#pragma mark - imageview touched
- (void) GamePlayViewDelegate_ChipSelected:(LAChipsPlayItem*)sender
{
    int chipIndex = sender.chipIndex;
    int itemType = -1;
    for(NSString* key in questionAnswerArray.allKeys){
        NSMutableArray * answerArray = [questionAnswerArray objectForKey:key];
        for(NSNumber * number in answerArray){
            if([number intValue] == chipIndex){
                itemType = [key intValue];
            }
        }
    }
    BOOL isSuccess = NO;
    if(itemType == correctType){
        for(NSNumber * chipId in remainAnswerArray){
            if([chipId intValue] == chipIndex){
                isSuccess = YES;
            }
        }
    }
    /// remove question
    remainQuestionArray = [self removeFirstItem:remainQuestionArray];
    
    NSUserDefaults * userDfault = [NSUserDefaults standardUserDefaults];
    BOOL isSoundOn = [userDfault boolForKey:@"setting_sound"];
    if(isSuccess){// success
        [self.btn_checker setImage:[UIImage imageNamed:@"btn_check_blue"] forState:UIControlStateSelected];
        [self.btn_checker setSelected:YES];
        if(isSoundOn)
            [self playSound:@"success"];
        subMissionScore += 1;
        totalScore += 1;
        
        /// remove answer
//        for(NSNumber* number in remainAnswerArray){
//            if([number intValue] == chipIndex)
//                remainAnswerArray = [self removeItem:number inArray:remainAnswerArray];
//        }
    }else{
        [self.btn_checker setImage:[UIImage imageNamed:@"btn_check_red"] forState:UIControlStateSelected];
        [self.btn_checker setSelected:YES];
        
        if(isSoundOn)
            [self playSound:@"error"];
    }
    for (UIView * subView in self.gameView.subviews) {
        [subView setUserInteractionEnabled:NO];
    }
    qaIndex ++;
    [self performSelector:@selector(gotoQAPlay) withObject:nil afterDelay:1];
}
#pragma mark - Sound play
- (void) playBGSound:(NSString *) audioFile
{
    NSURL * url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:audioFile ofType:@"mp3"]];
    self.bgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    self.bgPlayer.volume = 1.0;
    self.bgPlayer.delegate = self;
    [self.bgPlayer prepareToPlay];
    [self.bgPlayer play];
    
}
- (void) playSound:(NSString *) audioFile
{
    NSURL * url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:audioFile ofType:@"mp3"]];
    self.avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    self.avPlayer.volume = 1.0;
    self.avPlayer.delegate = self;
    [self.avPlayer prepareToPlay];
    [self.avPlayer play];
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if(player == self.bgPlayer){
        [self playBGSound:@"background"];
    }
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    NSLog(@"%@", error.localizedDescription);
}
@end
