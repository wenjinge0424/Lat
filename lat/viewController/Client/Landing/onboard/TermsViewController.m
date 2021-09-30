//
//  TermsViewController.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "TermsViewController.h"
#import "SignInViewController.h"
#import "LearningTypeViewController.h"
#import "AdminMenuViewController.h"
#import "ProfileViewController.h"
#import "ProfileViewController.h"

@interface TermsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSStringEncodingConversionAllowLossy  error:nil];
    [self.m_webView setOpaque:NO];
    [self.m_webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
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
- (IBAction)onDecline:(id)sender {
    if(self.isAdmin){
        NSArray * viewControllers = [self.navigationController viewControllers];
        UIViewController * targetController = nil;
        for(UIViewController * subCtr in viewControllers){
            if([subCtr isKindOfClass:[SignInViewController class]]){
                targetController = subCtr;
            }
        }
        if(targetController)
            [self.navigationController popToViewController:targetController animated:YES];
    }else{
        NSArray * viewControllers = [self.navigationController viewControllers];
        UIViewController * targetController = nil;
        for(UIViewController * subCtr in viewControllers){
            if([subCtr isKindOfClass:[ProfileViewController class]]){
                targetController = subCtr;
            }
        }
        if(targetController){
            [self.navigationController popToViewController:targetController animated:YES];
        }else{
            UIViewController * parentViewController = [viewControllers firstObject];
            ProfileViewController * controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileViewController"];
            [parentViewController.navigationController pushViewController:controller animated:YES];
        }
    }
}
- (IBAction)onAccept:(id)sender {
    if(self.isAdmin){
        if(self.user){
            [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeGradient];
            [self.user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [SVProgressHUD dismiss];
                if (!error) {
                    [Util setLoginUserName:self.user.username password:self.user.password];
                    ProfileViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                    [self.navigationController pushViewController:rootView animated:YES];
                } else {
                    NSString *message = [error localizedDescription];
                    if ([message containsString:@"already"]){
                        message = @"Account already exists for this email.";
                    }
                    [Util showAlertTitle:self title:@"Error" message:message];
                }
            }];
        }
    }else{
        if(self.family){
            [SVProgressHUD showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeGradient];
            [self.family saveInBackgroundWithBlock:^(BOOL success, NSError * error){
                 [SVProgressHUD dismiss];
                if(success){
                    [Util showAlertTitle:self title:@"Success" message:@"New profile created." finish:^{
                        NSArray * viewControllers = [self.navigationController viewControllers];
                        UIViewController * targetController = nil;
                        for(UIViewController * subCtr in viewControllers){
                            if([subCtr isKindOfClass:[ProfileViewController class]]){
                                targetController = subCtr;
                            }
                        }
                        if(targetController){
                            [self.navigationController popToViewController:targetController animated:YES];
                        }else{
                            UIViewController * parentViewController = [viewControllers firstObject];
                            ProfileViewController * controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                            [parentViewController.navigationController pushViewController:controller animated:YES];
                        }
                    }];
                }else{
                    [Util showAlertTitle:self title:@"Error" message:[error localizedDescription]];
                }
            }];
        }
    }
}

@end
