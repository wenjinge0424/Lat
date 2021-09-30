//
//  GameViewController.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "GameViewController.h"
#import "GamePlayView.h"
#import "GameRule.h"
#import "LAChipsPlayItem.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface GameViewController ()<GamePlayViewDelegate, AVAudioPlayerDelegate>
{
    NSMutableArray * levelCharactors;
    
    int totalPartCount;
    int currentCharactorIndex;
    
    NSMutableDictionary * questionAnswerArray;
    NSMutableArray * gameDataArray;
    
    
    int current_item_index;
    int current_state_index;
    int current_step_index;
    NSMutableArray * currentAnserArray;
    
    int correctCount;
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_part;
@property (weak, nonatomic) IBOutlet UIButton *btn_checker;

@property (weak, nonatomic) IBOutlet UIView *view_question;
@property (weak, nonatomic) IBOutlet UILabel *lbl_question;
@property (weak, nonatomic) IBOutlet GamePlayView *gameView;

@property (nonatomic, retain) AVAudioPlayer  * avPlayer;
//@property (nonatomic, strong) AVAudioPlayer * failPlayer;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    AudioSessionInitialize (NULL, NULL, NULL, NULL);
    AudioSessionSetActive(true);
    
    // Allow playback even if Ring/Silent switch is on mute
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty (kAudioSessionProperty_AudioCategory,
                             sizeof(sessionCategory),&sessionCategory);
    
    
    self.gameView.player_delegate = self;
    levelCharactors = [GameRule getScenarioForLevel:self.levelNum];
    currentCharactorIndex = 0;
    correctCount = 0;
    [self.lbl_title setText:self.levelName];
    [self.lbl_part setText:@""];
    
    NSError * error;
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if(error)
        NSLog(@"%@", error.localizedDescription);
    
//    NSBundle * mainBundle = [NSBundle mainBundle];
//    NSString * successPath = [mainBundle pathForResource:@"success" ofType:@"mp3"];
//    NSData * successMp3Data = [NSData dataWithContentsOfFile:successPath];
//    NSString * failPath = [mainBundle pathForResource:@"error" ofType:@"mp3"];
//    NSData * failMp3Data = [NSData dataWithContentsOfFile:failPath];
//    NSError * error = nil;
//
//    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:successPath] options:nil];
//    AVPlayerItem *anItem = [AVPlayerItem playerItemWithAsset:asset];
//    self.avPlayer = [AVPlayer playerWithPlayerItem:anItem];
//    self.avPlayer.vol
//    [self.avPlayer play];
    
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
    
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    NSLog(@"%@", error.localizedDescription);
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.gameView releaseMemory];
    for (UIView * subView in self.gameView.subviews) {
        [subView removeFromSuperview];
    }
}
- (void) UIRefreshCompleted
{
}

- (void) fetchData
{
    gameDataArray = [GameRule getScenarioForLevel:self.levelNum];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    PFQuery * query = [PFQuery queryWithClassName:PARSE_TABLE_GAMESET];
    [query whereKey:PARSE_GAMESET_OWNER equalTo:[PFUser currentUser]];
    [query whereKey:PARSE_GAMESET_USER equalTo:self.family];
    [query whereKey:PARSE_GAMESET_LEVELNUM equalTo:[NSNumber numberWithInt:self.levelNum]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * object, NSError * error){
        [SVProgressHUD dismiss];
        if(object){
            questionAnswerArray = object[PARSE_GAMESET_GAMEDATA];
        }else{
           questionAnswerArray = [GameRule getDefaultScenarioForLevel:self.levelNum];
        }
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

- (void) startMission
{
    totalPartCount = 0;
    for(NSString * key in questionAnswerArray.allKeys){
        NSMutableArray * dataArray = questionAnswerArray[key];
        totalPartCount += dataArray.count;
    }
    totalPartCount *= gameDataArray.count;
    [self.lbl_part setText:[NSString stringWithFormat:@"%d/%d", currentCharactorIndex + 1 , totalPartCount]];
    current_item_index = 0;
    current_state_index = 0;
    current_step_index = 0;
    [self gotoItemIndex:current_item_index];
}

- (void) gotoItemIndex:(int)index
{
    if(gameDataArray.count < index+1){/// complete
        for (UIView * subView in self.gameView.subviews) {
            [subView setUserInteractionEnabled:NO];
        }
        
        int totalCorrectCount = correctCount;
        int totalProblemCount = totalPartCount;
        int percent = ((totalCorrectCount * 1.f) / totalProblemCount) * 100;
        int score = [self.family[PARSE_FAMILY_POINTS] intValue];
        score += totalCorrectCount;
        self.family[PARSE_FAMILY_POINTS] = [NSNumber numberWithInt:score];
        NSString * title = @"";
        NSString * msg = @"";
        if(percent < 80){
            msg = [NSString stringWithFormat:@"You can't pass level %d.\n Your score %d%% (%d / %d)", self.levelNum, percent, totalCorrectCount, totalProblemCount];
            title = @"Sorry";
        }else{
            title = @"Congratulation";
            msg = [NSString stringWithFormat:@"You are passed level %d.\n Your score %d%% (%d / %d)", self.levelNum, percent, totalCorrectCount, totalProblemCount];
            int level = [self.family[PARSE_FAMILY_LEVEL] intValue];
            if(level < self.levelNum){
                level = self.levelNum;
                self.family[PARSE_FAMILY_LEVEL] = [NSNumber numberWithInt:level];
            }
        }
        [Util showAlertTitle:self title:title message:msg finish:^{
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
    NSString * itemIndexNumber = [gameDataArray objectAtIndex:index];
    [self refreshCharactor:[itemIndexNumber intValue]];
    
    [self.gameView initialScenario:questionAnswerArray];
    
    current_state_index = 0;
    [self gotoStateIndex:current_state_index];
}
- (void) gotoStateIndex:(int)index
{
    if(current_state_index > GAMERULE_GREEN){
        current_item_index ++;
        [self gotoItemIndex:current_item_index];
        return;
    }
    NSMutableArray * containerChips = [questionAnswerArray objectForKey:[NSString stringWithFormat:@"%d", index]];
    if(containerChips.count == 0){
        current_state_index ++;
        [self gotoStateIndex:current_state_index];
        return;
    }
    if(index == GAMERULE_GREEN){
        [self.lbl_question setText:@"Which body region is appropriate to touch?"];
        [self.view_question setBackgroundColor:[UIColor colorWithRed:0 green:156/255.f blue:120/255.f alpha:1]];
    }else if(index == GAMERULE_RED){
        [self.lbl_question setText:@"Which body region is inappropriate to touch?"];
        [self.view_question setBackgroundColor:[UIColor colorWithRed:255/255.f green:102/255.f blue:102/255.f alpha:1]];
    }else if(index == GAMERULE_YELLOW){
        [self.lbl_question setText:@"Which body region is circumstancial to touch?"];
        [self.view_question setBackgroundColor:[UIColor colorWithRed:255/255.f green:248/255.f blue:57/255.f alpha:1]];
    }
    current_step_index = 0;
    currentAnserArray = [[NSMutableArray alloc] init];
    for(NSNumber * subDict in containerChips){
        [currentAnserArray addObject:subDict];
    }
//    [self gotoStepIndex:current_step_index];
}
- (void) gotoStepIndex
{
    [self.btn_checker setImage:[UIImage imageNamed:@"ico_check_gray"] forState:UIControlStateNormal];
    [self.btn_checker setSelected:NO];
    
    currentCharactorIndex ++;
    if(currentCharactorIndex < totalPartCount){
        [self.lbl_part setText:[NSString stringWithFormat:@"%d/%d", currentCharactorIndex + 1 , totalPartCount]];
    }
    [self.btn_checker setSelected:NO];
    for (UIView * subView in self.gameView.subviews) {
        [subView setUserInteractionEnabled:YES];
    }
    NSMutableArray * containerChips = [questionAnswerArray objectForKey:[NSString stringWithFormat:@"%d", current_state_index]];
    if(containerChips.count <  current_step_index + 1){
        current_state_index ++;
        [self gotoStateIndex:current_state_index];
        return;
    }
    
}
#pragma mark - imageview touched
- (void) GamePlayViewDelegate_ChipSelected:(LAChipsPlayItem*)sender
{
    BOOL isTrue = NO;
    int chipIndex = sender.chipIndex;
    NSMutableArray * remianAnswer = [NSMutableArray new];
    for(NSNumber * correctValue in currentAnserArray){
        if(chipIndex == [correctValue intValue]){
            isTrue = YES;
        }else{
            [remianAnswer addObject:correctValue];
        }
    }
    currentAnserArray = [[NSMutableArray alloc] initWithArray:remianAnswer];
    
    NSUserDefaults * userDfault = [NSUserDefaults standardUserDefaults];
    BOOL isSoundOn = [userDfault boolForKey:@"setting_sound"];
    
    if(isTrue){
        [self.btn_checker setImage:[UIImage imageNamed:@"btn_check_blue"] forState:UIControlStateSelected];
        [self.btn_checker setSelected:YES];
        correctCount ++;
        
        [self playSound:@"success"];
        
    }else{
        [self.btn_checker setImage:[UIImage imageNamed:@"btn_check_red"] forState:UIControlStateSelected];
        [self.btn_checker setSelected:YES];
        
        [self playSound:@"error"];
    }
    
    current_step_index ++;
    for (UIView * subView in self.gameView.subviews) {
        [subView setUserInteractionEnabled:NO];
    }
    [self performSelector:@selector(gotoStepIndex) withObject:nil afterDelay:1];
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

- (void) refreshCharactor:(int) charactNum
{
    [self.gameView initScenarioIndex:charactNum];
}


@end
