//
//  ForgotPwdViewController.m
//  lat
//
//  Created by Techsviewer on 6/21/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "ForgotPwdViewController.h"
#import "SignUpEmailViewController.h"

@interface ForgotPwdViewController ()<UITextFieldDelegate>
{
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITextField *edt_email;
@property (weak, nonatomic) IBOutlet UIButton *btn_next;

@end

@implementation ForgotPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edt_email.delegate = self;
    [self.edt_email addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    if (![Util isConnectableInternet]){
        [Util showAlertTitle:self title:@"Error" message:@"No internet connectivity detected."];
        return;
    }
    
    dataArray = [[NSMutableArray alloc] init];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    PFQuery *query = [PFUser query];
    [query setLimit:1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        [SVProgressHUD dismiss];
        if (error){
            [Util showAlertTitle:self title:@"Error" message:[error localizedDescription]];
        } else {
            for (int i=0;i<array.count;i++){
                PFUser *user = [array objectAtIndex:i];
                [dataArray addObject:user[PARSE_USER_NAME]];
            }
        }
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
- (IBAction)onNext:(id)sender
{
    if([super checkNetworkState]){
        [_edt_email resignFirstResponder];
        NSString *email = _edt_email.text;
        email = [Util trim:email];
        if (!_btn_next.selected){
            NSString *msg = @"Email entered is not registered. Create an account now?";
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            alert.customViewColor = MAIN_COLOR;
            alert.horizontalButtons = YES;
            [alert addButton:@"Not Now" actionBlock:^(void) {
            }];
            [alert addButton:@"Sign Up" actionBlock:^(void) {
                SignUpEmailViewController * controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignUpEmailViewController"];
                [self.navigationController pushViewController:controller animated:YES];
            }];
            [alert showError:@"Reset Password" subTitle:msg closeButtonTitle:nil duration:0.0f];
        }else{
            [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeGradient];
            [PFUser requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded,NSError *error) {
                [SVProgressHUD dismiss];
                if (!error) {
                    [Util showAlertTitle:self
                                   title:@"Success"
                                 message: @"We have sent a password reset link to your email address. Please check your email."
                                  finish:^(void) {
                                      [self onBack:nil];
                                  }];
                } else {
                    if (![Util isConnectableInternet]){
                        if ([SVProgressHUD isVisible]){
                            [SVProgressHUD dismiss];
                        }
                        [Util showAlertTitle:self title:@"Error" message:@"No internet connectivity detected."];
                        return;
                    }
                    NSString *errorString = [error localizedDescription];
                    [Util showAlertTitle:self
                                   title:@"Error" message:errorString
                                  finish:^(void) {
                                  }];
                }
            }];
        }
    }
}


- (void) checkState:(NSString*)email
{
    _btn_next.enabled = [email isEmail];
    _btn_next.selected = ([Util stringContainsInArray:email :dataArray]);
}
#pragma mark - UItextfield delegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString*  str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self checkState:str];
    return YES;
}
- (void)textFieldChanged:(UITextField *)textField
{
    [self checkState:textField.text];
}

@end
