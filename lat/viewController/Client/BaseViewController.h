//
//  BaseViewController.h
//  lat
//
//  Created by Techsviewer on 6/16/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+Email.h"
#import "Utils.h"
#import "Config.h"
#import "SCLAlertView.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import "IQDropDownTextField.h"
#import "AFNetworking.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
#import "LATectField.h"
#import "CircleImageView.h"

@interface BaseViewController : UIViewController
- (BOOL) checkNetworkState;
- (void) UIRefreshCompleted;
@end
