//
//  GameMenuViewController.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "GameMenuViewController.h"
#import "SettingsViewController.h"
#import "GameLevelCell.h"
#import "GameViewController.h"
#import "PlayingViewController.h"
#import "MechanicViewController.h"

@interface GameMenuViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    int passedLevel;
    NSMutableArray * levelNames;
}
@property (weak, nonatomic) IBOutlet CircleImageView *img_thumb;
@property (weak, nonatomic) IBOutlet UILabel *lbl_username;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userType;
@property (weak, nonatomic) IBOutlet UILabel *lbl_point;
@property (weak, nonatomic) IBOutlet UILabel *lbl_tokens;
@property (weak, nonatomic) IBOutlet UILabel *lbl_levels;
@property (weak, nonatomic) IBOutlet UILabel *lbl_coins;

@property (weak, nonatomic) IBOutlet UILabel *lbl_setting_sound;
@property (weak, nonatomic) IBOutlet UILabel *lbl_setting_music;
@property (weak, nonatomic) IBOutlet UITableView *tbl_data;
@end

@implementation GameMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults * userDfault = [NSUserDefaults standardUserDefaults];
    BOOL isSoundOn = [userDfault boolForKey:SETTING_KEY_SOUND];
    BOOL isMusicOn = [userDfault boolForKey:SETTING_KEY_MUSIC];
    if(isSoundOn){
        self.lbl_setting_sound.text = @"Sound:On";
    }else{
        self.lbl_setting_sound.text = @"Sound:Off";
    }
    if(isMusicOn){
        self.lbl_setting_music.text = @"Music:On";
    }else{
        self.lbl_setting_music.text = @"Music:Off";
    }
    
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
- (void) fetchData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [self.family fetchInBackgroundWithBlock:^(PFObject * object, NSError * error){
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if(object)
                self.family = object;
            PFFile * thumbFile = self.family[PARSE_FAMILY_AVATAR];
            [Util setImage:self.img_thumb imgFile:thumbFile withDefaultImage:[UIImage imageNamed:@"img_emptyUser"]];
            self.lbl_username.text = self.family[PARSE_FAMILY_NAME];
            self.lbl_point.text = [NSString stringWithFormat:@"%d", [self.family[PARSE_FAMILY_POINTS] intValue]];
            self.lbl_tokens.text = [NSString stringWithFormat:@"%d", [self.family[PARSE_FAMILY_TOKENS] intValue]];
            self.lbl_coins.text = [NSString stringWithFormat:@"%d", [self.family[PARSE_FAMILY_COINS] intValue]];
            self.lbl_levels.text = [NSString stringWithFormat:@"%d", [self.family[PARSE_FAMILY_LEVEL] intValue]];
            passedLevel = [self.family[PARSE_FAMILY_LEVEL] intValue] + 1;
            
            levelNames = [[NSMutableArray alloc] initWithObjects:@"Touching Family Member", @"Being Touched by Family Member", @"Touching Friend", @"Being Touched by Friend",
                          @"Touching Stranger", @"Being Touched by Stranger", @"Touching Teacher", @"Being Touched by Teacher", @"Being Touched by Doctor", @"Intermixed 1",
                          @"Intermixed 2", @"Intermixed All", nil];
            
            self.tbl_data.delegate = self;
            self.tbl_data.dataSource = self;
            [self.tbl_data reloadData];
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
- (IBAction)onSettingSound:(id)sender {
    NSUserDefaults * userDfault = [NSUserDefaults standardUserDefaults];
    BOOL isSoundOn = [userDfault boolForKey:SETTING_KEY_SOUND];
    [userDfault setBool:!isSoundOn forKey:SETTING_KEY_SOUND];
    [userDfault synchronize];
    isSoundOn = [userDfault boolForKey:SETTING_KEY_SOUND];
    if(isSoundOn){
        self.lbl_setting_sound.text = @"Sound:On";
    }else{
        self.lbl_setting_sound.text = @"Sound:Off";
    }
}
- (IBAction)onSettingMusic:(id)sender {
    NSUserDefaults * userDfault = [NSUserDefaults standardUserDefaults];
    BOOL isMusicOn = [userDfault boolForKey:SETTING_KEY_MUSIC];
    [userDfault setBool:!isMusicOn forKey:SETTING_KEY_MUSIC];
    [userDfault synchronize];
    isMusicOn = [userDfault boolForKey:SETTING_KEY_MUSIC];
    if(isMusicOn){
        self.lbl_setting_music.text = @"Music:On";
    }else{
        self.lbl_setting_music.text = @"Music:Off";
    }
}

- (IBAction)onSettingMechanic:(id)sender {
    MechanicViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MechanicViewController"];
    [self.navigationController pushViewController:rootView animated:YES];    
}
- (IBAction)onSetting:(id)sender {
    SettingsViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    rootView.family = self.family;
    [self.navigationController pushViewController:rootView animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"GameLevelCell";
    GameLevelCell *cell = (GameLevelCell *)[tv dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell){
        int levelNumber = 12 - (int)indexPath.row;
        if(levelNumber <= passedLevel){
            [cell setPassed];
        }else{
            [cell setLocked];
        }
        [cell.btn_levelName setTitle:[levelNames objectAtIndex:levelNumber-1] forState:UIControlStateNormal];
        [cell.lbl_levelTitle setText:[NSString stringWithFormat:@"LEVEL %d", levelNumber]];
        cell.btn_levelName.tag = levelNumber;
        [cell.btn_levelName addTarget:self action:@selector(onStartMission:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void) onStartMission:(UIButton*)button
{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    
    if((int)button.tag > passedLevel){
        return;
    }
    
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SCLAlertViewShowAnimationSimplyAppear;
    [alert alertIsDismissed:^{
        PlayingViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PlayingViewController"];
        rootView.levelNum = (int)button.tag;
        rootView.levelName = [levelNames objectAtIndex:(int)button.tag - 1];
        rootView.family = self.family;
        [self.navigationController pushViewController:rootView animated:YES];
    }];
    alert.customViewColor = [UIColor colorWithRed:2/255.f green:114/255.f blue:202/255.f alpha:1.f];
    
    [alert showInfo:self title:@"Reminder:" subTitle:@"It is important to ask for permission before touching someone new or in a yellow/circumstantial region. You can always ask someone to stop touching you if you do not want to be touched." closeButtonTitle:@"Continue" duration:0.0f];
}

@end
