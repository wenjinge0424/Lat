//
//  AdminGameSetViewController.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "AdminGameSetViewController.h"
#import "GameSetView.h"
#import "GameRule.h"

@interface AdminGameSetViewController ()<GameSetViewDelegate>
{
    int selectedType;
    
    NSMutableArray * levelCharactors;
    int currentCharactorIndex;
    
    NSMutableDictionary * questionAnswerArray;
    
    PFObject * gameScenarioDict;
}
@property (weak, nonatomic) IBOutlet UIView *view_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_level;
@property (weak, nonatomic) IBOutlet UILabel *lbl_type;

@property (weak, nonatomic) IBOutlet GameSetView *actionContainer;
@end

@implementation AdminGameSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_level.text = [NSString stringWithFormat:@"Level %d", self.levelNum];
    self.actionContainer.delegate = self;
    selectedType = 2;
    
    
    levelCharactors = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:[GameRule getSettingScenarioForLevel:self.levelNum]], nil];
    currentCharactorIndex = 0;
    
    questionAnswerArray = [NSMutableDictionary new];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchData];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.actionContainer releaseMemory];
    for (UIView * subView in self.actionContainer.subviews) {
        [subView removeFromSuperview];
    }
}
- (void) UIRefreshCompleted
{
    NSMutableArray * levelNames = [[NSMutableArray alloc] initWithObjects:@"Touching Family Member", @"Being Touched by Family Member", @"Touching Friend", @"Being Touched by Friend",
                  @"Touching Stranger", @"Being Touched by Stranger", @"Touching Teacher", @"Being Touched by Teacher", @"Being Touched by Doctor", @"Intermixed 1",
                  @"Intermixed 2", @"Intermixed All", nil];
    NSString * levelName = [levelNames objectAtIndex:self.levelNum - 1];
    [Util showAlertTitle:self title:@"Game Information" message:[NSString stringWithFormat:@"Level %d \n %@", self.levelNum, levelName] finish:^{
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) fetchData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    PFQuery * query = [PFQuery queryWithClassName:PARSE_TABLE_GAMESET];
    [query whereKey:PARSE_GAMESET_OWNER equalTo:[PFUser currentUser]];
    [query whereKey:PARSE_GAMESET_USER equalTo:self.family];
    [query whereKey:PARSE_GAMESET_LEVELNUM equalTo:[NSNumber numberWithInt:self.levelNum]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * object, NSError * error){
        [SVProgressHUD dismiss];
        if(object){
            gameScenarioDict = object;
            questionAnswerArray = object[PARSE_GAMESET_GAMEDATA];
            if(!questionAnswerArray){
                questionAnswerArray = [GameRule getDefaultScenarioForLevel:self.levelNum];
            }
        }else{
            questionAnswerArray = [GameRule getDefaultScenarioForLevel:self.levelNum];
        }
        int currentCharactor = [[levelCharactors objectAtIndex:currentCharactorIndex] intValue];
        [self refreshCharactor:currentCharactor];
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
- (void) refreshCharactor:(int) charactNum
{
    [self.actionContainer initScenarioIndex:charactNum];
    [self.actionContainer initialScenario:questionAnswerArray];
}
- (void) refreshUI:(int) index
{
    if(selectedType == 2){
        [self.view_title setBackgroundColor:[UIColor colorWithRed:0 green:156/255.f blue:120/255.f alpha:1]];
        [self.lbl_type setTextColor:[UIColor colorWithRed:0 green:156/255.f blue:120/255.f alpha:1]];
        self.lbl_type.text = @"Appropriate";
    }else if(selectedType == 0){
        [self.view_title setBackgroundColor:[UIColor colorWithRed:255/255.f green:102/255.f blue:102/255.f alpha:1]];
        [self.lbl_type setTextColor:[UIColor colorWithRed:255/255.f green:102/255.f blue:102/255.f alpha:1]];
        self.lbl_type.text = @"Inappropriate";
    }else if(selectedType == 1){
        [self.view_title setBackgroundColor:[UIColor colorWithRed:255/255.f green:102/255.f blue:102/255.f alpha:1]];
        [self.lbl_type setTextColor:[UIColor colorWithRed:255/255.f green:248/255.f blue:57/255.f alpha:1]];
        self.lbl_type.text = @"Circumstancial";
    }
}
- (IBAction)onBack:(id)sender {
    [self.actionContainer releaseMemory];
    for (UIView * subView in self.actionContainer.subviews) {
        [subView removeFromSuperview];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onAppropriate:(id)sender {
    selectedType = 2;
    [self refreshUI:selectedType];
}
- (IBAction)onInappropriate:(id)sender {
    selectedType = 0;
    [self refreshUI:selectedType];
}
- (IBAction)onCircumstancial:(id)sender {
    selectedType = 1;
    [self refreshUI:selectedType];
}
- (IBAction)onComplete:(id)sender {
    NSMutableDictionary * chipQA = [self.actionContainer QAListArray];
    if(!gameScenarioDict)
        gameScenarioDict = [PFObject objectWithClassName:PARSE_TABLE_GAMESET];
    gameScenarioDict[PARSE_GAMESET_USER] = self.family;
    gameScenarioDict[PARSE_GAMESET_LEVELNUM] = [NSNumber numberWithInt:self.levelNum];
    gameScenarioDict[PARSE_GAMESET_OWNER] = [PFUser currentUser];
    gameScenarioDict[PARSE_GAMESET_GAMEDATA] = chipQA;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [gameScenarioDict saveEventually:^(BOOL success, NSError * error){
        [SVProgressHUD dismiss];
        if(success){
            [Util showAlertTitle:self title:@"Success" message:[NSString stringWithFormat:@"Game level %d for %@ was designed.", self.levelNum, self.family[PARSE_FAMILY_NAME]] finish:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [Util showAlertTitle:self title:@"Error" message:[error localizedDescription]];
        }
    }];
}

- (int) GameSetViewDelegate_ChipSelected:(id)sender
{
    return selectedType;
}
@end
