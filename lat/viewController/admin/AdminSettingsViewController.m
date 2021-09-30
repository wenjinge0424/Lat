//
//  AdminSettingsViewController.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "AdminSettingsViewController.h"
#import "AdminEditProfileViewController.h"
#import "SignInViewController.h"

@interface AdminSettingsViewController ()

@end

@implementation AdminSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)onEditProfile:(id)sender {
    AdminEditProfileViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdminEditProfileViewController"];
    [self.navigationController pushViewController:rootView animated:YES];
}
- (IBAction)onLogOut:(id)sender {
    [SVProgressHUD showWithStatus:@"Logging out..." maskType:SVProgressHUDMaskTypeGradient];
    [PFUser logOutInBackgroundWithBlock:^(NSError *error){
        [SVProgressHUD dismiss];
        if (error){
            [Util showAlertTitle:self title:@"Logout" message:[error localizedDescription]];
        } else {
            [Util setLoginUserName:@"" password:@""];
            
            NSArray * viewControllers = [self.navigationController viewControllers];
            UIViewController * targetController = nil;
            for(UIViewController * subCtr in viewControllers){
                if([subCtr isKindOfClass:[SignInViewController class]]){
                    targetController = subCtr;
                }
            }
            if(targetController){
                [self.navigationController popToViewController:targetController animated:YES];
            }else{
                UIViewController * parentViewController = [viewControllers firstObject];
                SignInViewController * controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignInViewController"];
                [parentViewController.navigationController pushViewController:controller animated:YES];
            }
            
        }
    }];
}
@end
