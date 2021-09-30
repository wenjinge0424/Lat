//
//  AdminUserDetailViewController.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "AdminUserDetailViewController.h"
#import "AdminResignViewController.h"

@interface AdminUserDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_userName;
@property (weak, nonatomic) IBOutlet CircleImageView *img_thumb;

@property (weak, nonatomic) IBOutlet UILabel *lbl_userTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userPassword;
@property (weak, nonatomic) IBOutlet UILabel *lbl_level;
@property (weak, nonatomic) IBOutlet UILabel *lbl_coins;
@property (weak, nonatomic) IBOutlet UILabel *lbl_tokens;
@property (weak, nonatomic) IBOutlet UILabel *lbl_points;
@property (weak, nonatomic) IBOutlet UIButton *btn_ban;
@end

@implementation AdminUserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [self.family fetchIfNeededInBackgroundWithBlock:^(PFObject * object, NSError * error){
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            self.family = object;
            self.lbl_userName.text = self.family[PARSE_FAMILY_NAME];
            PFFile * thumbFile = self.family[PARSE_FAMILY_AVATAR];
            [Util setImage:self.img_thumb imgFile:thumbFile withDefaultImage:[UIImage imageNamed:@"img_emptyUser"]];
            self.lbl_userTitle.text = [NSString  stringWithFormat:@"Username: %@", self.family[PARSE_FAMILY_NAME]];
            self.lbl_userPassword.text = @"Password: ";
            
            if([self.family[PARSE_FAMILY_ISBANNED] boolValue]){
                [self.btn_ban setTitle:@"Unban" forState:UIControlStateNormal];
                self.lbl_level.text = @"";
                self.lbl_coins.text = @"";
                self.lbl_tokens.text = @"";
                self.lbl_points.text = @"This user is banned.";
            }else{
                [self.btn_ban setTitle:@"Ban User" forState:UIControlStateNormal];
                self.lbl_level.text = [NSString stringWithFormat:@"Level: %d", [self.family[PARSE_FAMILY_LEVEL] intValue]];
                self.lbl_coins.text = [NSString stringWithFormat:@"Coins: %d", [self.family[PARSE_FAMILY_COINS] intValue]];
                self.lbl_tokens.text = [NSString stringWithFormat:@"Tokens: %d", [self.family[PARSE_FAMILY_TOKENS] intValue]];
                self.lbl_points.text = [NSString stringWithFormat:@"Points: %d", [self.family[PARSE_FAMILY_POINTS] intValue]];
            }
            
            
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)onResign:(id)sender {
    AdminResignViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdminResignViewController"];
    rootView.family = self.family;
    [self.navigationController pushViewController:rootView animated:YES];
}
- (IBAction)onBanUser:(id)sender {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSString * message = @"";
    if([self.family[PARSE_FAMILY_ISBANNED] boolValue]){
        self.family[PARSE_FAMILY_ISBANNED] = [NSNumber numberWithBool:NO];
        message = @"This user unbanned.";
    }else{
        self.family[PARSE_FAMILY_ISBANNED] = [NSNumber numberWithBool:YES];
        message = @"This user banned.";
    }
    [self.family saveInBackgroundWithBlock:^(BOOL success, NSError * error){
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [Util showAlertTitle:self title:@"Success" message:message finish:^(void){
                [self.navigationController popViewControllerAnimated:YES];
            }];
        });
    }];
    
}
- (IBAction)onDeleteUser:(id)sender {
    NSString *msg = @"Are you sure delete this user?";
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    alert.customViewColor = MAIN_COLOR;
    alert.horizontalButtons = YES;
    [alert addButton:@"No" actionBlock:^(void) {
    }];
    [alert addButton:@"Yes" actionBlock:^(void) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [self.family deleteInBackgroundWithBlock:^(BOOL success, NSError * error){
            [SVProgressHUD dismiss];
            if(error){
                [Util showAlertTitle:self title:@"Error" message:error.localizedDescription];
            }else{
                [Util showAlertTitle:self title:@"Success" message:@"User account was deleted." finish:^(void){
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }];
    }];
    [alert showError:@"Delete user" subTitle:msg closeButtonTitle:nil duration:0.0f];
}
@end
