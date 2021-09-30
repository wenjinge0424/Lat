//
//  TermsViewController.h
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "BaseViewController.h"

@interface TermsViewController : BaseViewController
@property (atomic) BOOL isAdmin;
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) PFObject * family;
@end
