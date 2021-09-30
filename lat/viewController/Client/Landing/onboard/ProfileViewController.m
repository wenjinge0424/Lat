//
//  ProfileViewController.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileUserCell.h"
#import "CreateProfileViewController.h"
#import "AdminMenuViewController.h"
#import "GameMenuViewController.h"

@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * m_showData;
}
@property (weak, nonatomic) IBOutlet UITableView *tbl_data;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    m_showData = [NSMutableArray new];
    [m_showData addObject:[PFUser currentUser]];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    PFQuery * query = [PFQuery queryWithClassName:PARSE_TABLE_FAMILY];
    [query whereKey:PARSE_FAMILY_ADMIN equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *arrays, NSError *errs){
        if (errs){
            [SVProgressHUD dismiss];
            [Util showAlertTitle:self title:@"Error" message:[errs localizedDescription]];
        }else{
            if(arrays.count == 0){/// is friend
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    self.tbl_data.delegate = self;
                    self.tbl_data.dataSource = self;
                    [self.tbl_data reloadData];
                });
            }else{
                for(PFObject * object in arrays){
                    [m_showData addObject:object];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    self.tbl_data.delegate = self;
                    self.tbl_data.dataSource = self;
                    [self.tbl_data reloadData];
                });
            }
        }
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [m_showData count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < m_showData.count){
        static NSString *cellIdentifier = @"ProfileUserCell";
        ProfileUserCell *cell = (ProfileUserCell *)[tv dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell){
            if(indexPath.row == 0){
                PFUser * adminUser = [PFUser currentUser];
                [adminUser fetchIfNeeded];
                cell.lbl_userName.textColor = [UIColor redColor];
                cell.lbl_userType.text = @"Admin";
                [cell.lbl_userName setText:[NSString stringWithFormat:@"%@ %@", adminUser[PARSE_USER_FIRSTNAME], adminUser[PARSE_USER_LASTSTNAME]]];
                cell.lbl_levelNum.text = @"12";
                PFFile * thumbFile = adminUser[PARSE_USER_AVATAR];
                [Util setImage:cell.img_thumb imgFile:thumbFile withDefaultImage:[UIImage imageNamed:@"img_emptyUser"]];
            }else{
                PFObject * family = [m_showData objectAtIndex:indexPath.row];
                cell.lbl_userName.textColor = [UIColor blueColor];
                cell.lbl_userType.text = @"User";
                cell.lbl_userName.text = family[PARSE_FAMILY_NAME];
                cell.lbl_levelNum.text = [NSString stringWithFormat:@"%d", [family[PARSE_FAMILY_LEVEL] intValue] + 1];
                PFFile * thumbFile = family[PARSE_FAMILY_AVATAR];
                [Util setImage:cell.img_thumb imgFile:thumbFile  withDefaultImage:[UIImage imageNamed:@"img_emptyUser"]];
            }
        }
        return cell;
    }else{
        static NSString *cellIdentifier = @"ProfileUserCell_title";
        ProfileUserCell *cell = (ProfileUserCell *)[tv dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell){
        }
        return cell;
    }
    return nil;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.row == m_showData.count){
        CreateProfileViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CreateProfileViewController"];
        [self.navigationController pushViewController:rootView animated:YES];
    }else if(indexPath.row == 0){
        AdminMenuViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdminMenuViewController"];
        [self.navigationController pushViewController:rootView animated:YES];
    }else{
        PFObject * family = [m_showData objectAtIndex:indexPath.row];
        BOOL isBanned = [family[PARSE_FAMILY_ISBANNED] boolValue];
        if(!isBanned){
            
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.customViewColor = MAIN_COLOR;
            alert.horizontalButtons = YES;
            
            SCLTextView *nameView = [alert addTextField:@"password"];
            nameView.tintColor = MAIN_COLOR;
            nameView.secureTextEntry = YES;
            nameView.keyboardType = UIKeyboardTypeDefault;
            
            NSString *title = @"Please input your password.";
            
            [alert addButton:@"Cancel" actionBlock:^(void) {
            }];
            
            [alert addButton:@"Confirm" validationBlock:^BOOL {
                NSString *password = nameView.text;
                NSString * confirm = family[PARSE_FAMILY_PASSWORD];
                [nameView resignFirstResponder];
                if (password.length == 0) {
                    [Util showAlertTitle:nil title:@"" message:@"Oops! Please input your password." finish:^(void) {
                        [nameView becomeFirstResponder];
                    }];
                    return NO;
                }
                if(![password isEqualToString:confirm]){
                    [Util showAlertTitle:nil title:@"" message:@"Oops! Input password was invalid." finish:^(void) {
                        [nameView becomeFirstResponder];
                    }];
                    return NO;
                }
                return YES;
            } actionBlock:^(void) {
                GameMenuViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GameMenuViewController"];
                rootView.family = family;
                [self.navigationController pushViewController:rootView animated:YES];
            }];
            
            [alert addButton:@"Reset" validationBlock:^BOOL {
                return YES;
            } actionBlock:^(void){
                ///// reset password dialog
                SCLAlertView *resetAlert = [[SCLAlertView alloc] init];
                resetAlert.customViewColor = MAIN_COLOR;
                resetAlert.horizontalButtons = YES;
                SCLTextView *passwordView = [resetAlert addTextField:@"new password"];
                passwordView.tintColor = MAIN_COLOR;
                passwordView.secureTextEntry = YES;
                passwordView.keyboardType = UIKeyboardTypeDefault;
                SCLTextView *confirmView = [resetAlert addTextField:@"confirm password"];
                confirmView.tintColor = MAIN_COLOR;
                confirmView.secureTextEntry = YES;
                confirmView.keyboardType = UIKeyboardTypeDefault;
                NSString *resetTitle = @"Please input your new password.";
                
                [resetAlert addButton:@"Cancel" actionBlock:^(void) {
                }];
                [resetAlert addButton:@"Confirm" validationBlock:^BOOL {
                    NSString *password = passwordView.text;
                    NSString *confirm = confirmView.text;
                    if(password.length == 0){
                        [Util showAlertTitle:nil title:@"" message:@"Oops! Please input your password." finish:^(void) {
                            [passwordView becomeFirstResponder];
                        }];
                    }
                    if(![password isEqualToString:confirm]){
                        [Util showAlertTitle:nil title:@"" message:@"Oops! Please check your confirm password." finish:^(void) {
                            [confirmView becomeFirstResponder];
                        }];
                    }
                    return YES;
                } actionBlock:^(void){
                    family[PARSE_FAMILY_PASSWORD] = passwordView.text;
                    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                    [family saveInBackgroundWithBlock:^(BOOL success, NSError * error){
                        if(success){
                            [SVProgressHUD dismiss];
                            [Util showAlertTitle:nil title:@"Success" message:@"Password changed." finish:^(void) {
                            }];
                        }else{
                            [SVProgressHUD dismiss];
                            [Util showAlertTitle:self title:@"Error" message:[error localizedDescription]];
                        }
                    }];
                }];
                [resetAlert showEdit:self title:@"" subTitle:resetTitle closeButtonTitle:nil duration:0.0f];
            }];
            
            [alert showEdit:self title:@"" subTitle:title closeButtonTitle:nil duration:0.0f];
        }else{
            [Util showAlertTitle:self title:@"Error" message:@"Your account was banned."];
        }
    }
}
@end
