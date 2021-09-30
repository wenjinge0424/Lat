//
//  BaseViewController.m
//  lat
//
//  Created by Techsviewer on 6/16/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    BOOL refreshed;
}
@end

@implementation BaseViewController

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
- (BOOL) checkNetworkState
{
    if (![Util isConnectableInternet]){
        [Util showAlertTitle:self title:@"Network error" message:@"Couldn't connect to the Server. Please check your network connection."];
        return NO;
    }
    return YES;
}
- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(didFinishAutoLayout)
                                               object:nil];
    [self performSelector:@selector(didFinishAutoLayout) withObject:nil
               afterDelay:0];
}
- (void) didFinishAutoLayout {
    if(refreshed)
        return;
    refreshed = YES;
    [self UIRefreshCompleted];
}
- (void) UIRefreshCompleted
{
    
}
@end
