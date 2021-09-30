//
//  SignUpEmailViewController.m
//  lat
//
//  Created by Techsviewer on 6/21/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "SignUpEmailViewController.h"
#import "SignUpPwdViewController.h"

@interface SignUpEmailViewController ()<UITextFieldDelegate>
{
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITextField *et_email;
@property (weak, nonatomic) IBOutlet UIButton *btn_next;

@property (weak, nonatomic) IBOutlet UIButton *checker_valid;
@property (weak, nonatomic) IBOutlet UIButton *checker_notuse;
@end

@implementation SignUpEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.et_email.delegate = self;
    [self.et_email addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.btn_next setEnabled:NO];
    if (![Util isConnectableInternet]){
        [Util showAlertTitle:self title:@"Error" message:@"No internet connectivity detected."];
        return;
    }
    if(self.sentEmailAddress)
        [self.et_email setText:self.sentEmailAddress];
    
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
            if(self.sentEmailAddress.length > 0){
                [self checkState:self.sentEmailAddress];
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
        NSString *email = _et_email.text;
        email = [Util trim:email];
        if (email.length == 0){
            [Util showAlertTitle:self title:@"Error" message:@"Please enter your email address." finish:^(void){
                [_et_email becomeFirstResponder];
            }];
            return;
        }
        PFUser *user = [PFUser user];
        user.username = _et_email.text;
        user[PARSE_USER_EMAIL] = _et_email.text;
        
        SignUpPwdViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignUpPwdViewController"];
        rootView.user = user;
        [self.navigationController pushViewController:rootView animated:YES];
    }
    
    
    
}

- (void) checkState:(NSString*)email
{
    _btn_next.enabled = NO;
    self.checker_valid.selected = [email isEmail];
    self.checker_notuse.selected = ![Util stringContainsInArray:email :dataArray];
    if([email isEmail] && ![Util stringContainsInArray:email :dataArray]){
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
