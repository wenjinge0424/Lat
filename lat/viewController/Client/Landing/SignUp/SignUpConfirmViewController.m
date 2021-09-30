//
//  SignUpConfirmViewController.m
//  lat
//
//  Created by Techsviewer on 6/21/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "SignUpConfirmViewController.h"
#import "TermsViewController.h"
#import "SignUpInfoViewController.h"

@interface SignUpConfirmViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *edt_confirm;
@property (weak, nonatomic) IBOutlet UIButton *btn_next;

@property (weak, nonatomic) IBOutlet UIButton *checker_valid;
@end

@implementation SignUpConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edt_confirm.delegate = self;
    [_edt_confirm addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
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
    SignUpInfoViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignUpInfoViewController"];
    rootView.user = self.user;
    [self.navigationController pushViewController:rootView animated:YES];
}
- (void) checkState:(NSString*)pwd
{
    _btn_next.enabled = NO;
    self.checker_valid.selected = [self.user[PARSE_USER_PASSWORD] isEqualToString:pwd];
    if([self.user[PARSE_USER_PASSWORD] isEqualToString:pwd]){
        _btn_next.enabled = YES;
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
