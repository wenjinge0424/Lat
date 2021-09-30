//
//  SignInViewController.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "SignInViewController.h"
#import "LATectField.h"
#import "ProfileViewController.h"
#import "SignUpEmailViewController.h"
#import "ForgotPwdViewController.h"

@interface SignInViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet LATectField *edt_email;
@property (weak, nonatomic) IBOutlet LATectField *edt_password;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([Util getLoginUserName].length > 0){
        _edt_email.text = [Util getLoginUserName];
        _edt_password.text = [Util getLoginUserPassword];
        [self onSignIn:nil];
    }
    _edt_email.edt_text.delegate = self;
    _edt_password.edt_text.delegate = self;
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _edt_email.text = [Util getLoginUserName];
    _edt_password.text = [Util getLoginUserPassword];
    [_edt_email resignFirstResponder];
    [_edt_password resignFirstResponder];
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    LATectField * field = (LATectField*)textField.superview;
    [field setNormal];
    return YES;
}


- (BOOL) isValid {
    [self.view endEditing:YES];
    NSString *errMsg = @"";
    _edt_email.text = [Util trim:_edt_email.text];
    NSString *email = _edt_email.text;
    NSString *password = _edt_password.text;
    if (email.length == 0 && password.length == 0){
        errMsg = [errMsg stringByAppendingString:@"Please enter your email and password."];
        [_edt_email setError];
        [_edt_password setError];
        [Util showAlertTitle:self title:@"Login Error" message:errMsg];
    }else if(email.length == 0){
        errMsg = [errMsg stringByAppendingString:@"Please enter your email."];
        [_edt_email setError];
        [Util showAlertTitle:self title:@"Login Error" message:errMsg];
    }else if(password.length == 0){
        errMsg = [errMsg stringByAppendingString:@"Please enter your password."];
        [_edt_password setError];
        [Util showAlertTitle:self title:@"Login Error" message:errMsg];
    }else if(![email isEmail]){
        errMsg = [errMsg stringByAppendingString:@"Please enter valid email."];
        [_edt_email setError];
        [Util showAlertTitle:self title:@"Login Error" message:errMsg];
    }else if ([password containsString:@" "]){
        [Util showAlertTitle:self title:@"Login Error" message:@"Blank space is not allowed in password."];
        [_edt_password setError];
    }else{
        [_edt_email setNormal];
        [_edt_password setNormal];
        return YES;
    }
    return NO;
}

- (IBAction)onForgotPassword:(id)sender {
    ForgotPwdViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ForgotPwdViewController"];
    [self.navigationController pushViewController:rootView animated:YES];
}
- (IBAction)onSignUp:(id)sender {
    SignUpEmailViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignUpEmailViewController"];
    [self.navigationController pushViewController:rootView animated:YES];
}
- (IBAction)onSignIn:(id)sender {
    if([super checkNetworkState]){
        if (![self isValid]){
            return;
        }
        [_edt_email resignFirstResponder];
        [_edt_password resignFirstResponder];
        
        [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeGradient];
        PFQuery *query = [PFUser query];
        [query whereKey:PARSE_USER_EMAIL equalTo:_edt_email.text];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error && object) {
                PFUser *user = (PFUser *)object;
                NSString *username = user.username;
                [PFUser logInWithUsernameInBackground:username password:_edt_password.text block:^(PFUser *user, NSError *error) {
                    [SVProgressHUD dismiss];
                    if (user) {
                        //                        if(self.btn_checker.isSelected){
                        [Util setLoginUserName:user.email password:_edt_password.text];
                        //                        }
                        ProfileViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                        [self.navigationController pushViewController:rootView animated:YES];
                    } else {
                        if (![Util isConnectableInternet]){
                            if ([SVProgressHUD isVisible]){
                                [SVProgressHUD dismiss];
                            }
                            [Util showAlertTitle:self title:@"Login Error" message:@"No internet connectivity detected."];
                            return;
                        }
                        NSString *errorString = @"Incorrect password. Please try again.";
                        [Util showAlertTitle:self title:@"Login Error" message:errorString finish:^{
                            [_edt_password becomeFirstResponder];
                        }];
                    }
                }];
            } else {
                if (![Util isConnectableInternet]){
                    if ([SVProgressHUD isVisible]){
                        [SVProgressHUD dismiss];
                    }
                    [Util showAlertTitle:self title:@"Error" message:@"No internet connectivity detected."];
                    return;
                }
                [SVProgressHUD dismiss];
                [Util setLoginUserName:@"" password:@""];
                
                NSString *msg = @"Unrecognized email. Please try again or sign up with a new account.";
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                alert.customViewColor = MAIN_COLOR;
                alert.horizontalButtons = YES;
                [alert addButton:@"Not now" actionBlock:^(void) {
                }];
                [alert addButton:@"Sign Up" actionBlock:^(void) {
                    [self onSignUp:nil];
                }];
                [alert showError:@"Sign Up" subTitle:msg closeButtonTitle:nil duration:0.0f];
            }
        }];
        
    }
}
@end
