//
//  CreateProfileViewController.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "CreateProfileViewController.h"
#import "TermsViewController.h"

@interface CreateProfileViewController ()<UITextFieldDelegate>
{
    NSMutableArray * m_showData;
}
@property (weak, nonatomic) IBOutlet LABigTectField *edt_name;
@property (weak, nonatomic) IBOutlet UITextField *edt_pwd;
@property (weak, nonatomic) IBOutlet UITextField *edt_confirm;
@end

@implementation CreateProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _edt_name.edt_text.delegate = self;
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
               });
            }else{
                for(PFObject * object in arrays){
                    [m_showData addObject:object[PARSE_FAMILY_NAME]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    LABigTectField * field = (LABigTectField*)textField.superview;
    [field setNormal];
    return YES;
}
- (BOOL) isValid {
    [self.view endEditing:YES];
    _edt_name.text = [Util trim:_edt_name.text];
    NSString * name = _edt_name.text;
    if(name.length == 0){
        [_edt_name setError];
        return NO;
    }
    return YES;
}
- (IBAction)onNext:(id)sender {
    if([super checkNetworkState]){
        if (![self isValid]){
            return;
        }
        [_edt_name resignFirstResponder];
        NSString * name = _edt_name.text;
        NSString * pwd = _edt_pwd.text;
        NSString * confirm = _edt_confirm.text;
        
        if([Util stringContainsInArray:name :m_showData]){
            NSString *errorString = @"You entered an existing profile name. Please try again.";
            [Util showAlertTitle:self title:@"Error" message:errorString finish:^{
                [_edt_name setError];
            }];
            return;
        }
        if(pwd.length == 0){
            NSString *errorString = @"Please input password.";
            [Util showAlertTitle:self title:@"Error" message:errorString finish:^{
                [_edt_pwd becomeFirstResponder];
            }];
            return;
        }else if(![pwd isEqualToString:confirm]){
            NSString *errorString = @"Please check your confirm password.";
            [Util showAlertTitle:self title:@"Error" message:errorString finish:^{
                [_edt_confirm becomeFirstResponder];
            }];
            return;
        }
        PFObject * family = [PFObject objectWithClassName:PARSE_TABLE_FAMILY];
        family[PARSE_FAMILY_NAME] = name;
        family[PARSE_FAMILY_ADMIN] = [PFUser currentUser];
        family[PARSE_FAMILY_LEVEL] = [NSNumber numberWithInt:0];
        family[PARSE_FAMILY_COINS] = [NSNumber numberWithInt:0];
        family[PARSE_FAMILY_POINTS] = [NSNumber numberWithInt:0];
        family[PARSE_FAMILY_TOKENS] = [NSNumber numberWithInt:0];
        family[PARSE_FAMILY_PASSWORD] = pwd;
        family[PARSE_FAMILY_ISBANNED] = [NSNumber numberWithBool:NO];
        TermsViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TermsViewController"];
        rootView.family = family;
        [self.navigationController pushViewController:rootView animated:YES];
    }
}

@end
