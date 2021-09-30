//
//  OnboardViewController.m
//  lat
//
//  Created by Techsviewer on 6/16/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "OnboardViewController.h"
#import "SignInViewController.h"

@interface OnboardViewController ()

@end

@implementation OnboardViewController

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
- (IBAction)onDone:(id)sender {
    NSUserDefaults * userDefaul = [NSUserDefaults standardUserDefaults];
    [userDefaul setBool:YES forKey:@"FIRST_USER"];
    [userDefaul synchronize];
    
    SignInViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self.navigationController pushViewController:rootView animated:YES];
}

@end
