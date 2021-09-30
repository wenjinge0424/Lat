//
//  AdminMenuViewController.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "AdminMenuViewController.h"
#import "AdminAllUsersViewController.h"
#import "AdminSettingsViewController.h"

@interface AdminMenuViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lbl_adminName;
@end

@implementation AdminMenuViewController

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
- (IBAction)onUsers:(id)sender {
    AdminAllUsersViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdminAllUsersViewController"];
    [self.navigationController pushViewController:rootView animated:YES];
}
- (IBAction)onSettings:(id)sender {
    AdminSettingsViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdminSettingsViewController"];
    [self.navigationController pushViewController:rootView animated:YES];
}

@end
