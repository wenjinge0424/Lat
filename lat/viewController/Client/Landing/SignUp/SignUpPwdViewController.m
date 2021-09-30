//
//  SignUpPwdViewController.m
//  lat
//
//  Created by Techsviewer on 6/21/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "SignUpPwdViewController.h"
#import "SignUpConfirmViewController.h"

@interface SignUpPwdViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *edt_password;
@property (weak, nonatomic) IBOutlet UIButton *btn_next;

@property (weak, nonatomic) IBOutlet UIButton *checker_length;
@property (weak, nonatomic) IBOutlet UIButton *checker_upper;
@property (weak, nonatomic) IBOutlet UIButton *checker_num;
@end

@implementation SignUpPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edt_password.delegate = self;
    [_edt_password addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.btn_next setEnabled:NO];
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
        self.user[PARSE_USER_PASSWORD] = _edt_password.text;
        self.user.password = _edt_password.text;
        SignUpConfirmViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignUpConfirmViewController"];
        rootView.user =  self.user;
        [self.navigationController pushViewController:rootView animated:YES];
    }
}

- (void) checkState:(NSString*)password
{
    [_btn_next setEnabled:NO];
    self.checker_length.selected = (password.length >= 6);
    self.checker_upper.selected = [Util stringContainLetter:password];
    self.checker_num.selected = [Util isContainsNumber:password];
    if(password.length >= 6 && [Util stringContainLetter:password] && [Util isContainsNumber:password]){
        [_btn_next setEnabled:YES];
    }
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
