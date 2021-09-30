//
//  LearningTypeViewController.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "LearningTypeViewController.h"
#import "GameViewController.h"
#import "LAScenarioItem.h"
#import "GameMenuViewController.h"

@interface LearningTypeViewController ()
@property (weak, nonatomic) IBOutlet UIView *view_radios_0;
@property (weak, nonatomic) IBOutlet UIView *view_radios_1;
@property (weak, nonatomic) IBOutlet UIView *view_radios_2;

@end

@implementation LearningTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view_radios_0.layer.cornerRadius = self.view_radios_0.frame.size.height / 2.f;
    self.view_radios_1.layer.cornerRadius = self.view_radios_1.frame.size.height / 2.f;
    self.view_radios_2.layer.cornerRadius = self.view_radios_2.frame.size.height / 2.f;
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
- (IBAction)onNext:(id)sender {
    LAScenarioItem * item = [LAScenarioItem new];
    item.index = 0;
    item.chipsCount = 14;
    
    GameMenuViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GameMenuViewController"];
    [self.navigationController pushViewController:rootView animated:YES];
    
//    GameViewController * rootView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GameViewController"];
//    rootView.playType = GAME_TYPE_HOWTOPLAY;
//    rootView.m_scenarion = item;
//    [self.navigationController pushViewController:rootView animated:YES];
}
- (IBAction)onAppropriate:(id)sender {
}
- (IBAction)onInappropriate:(id)sender {
}
- (IBAction)onCircumstancial:(id)sender {
}
@end
