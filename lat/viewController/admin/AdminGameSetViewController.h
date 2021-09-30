//
//  AdminGameSetViewController.h
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "BaseViewController.h"

@interface AdminGameSetViewController : BaseViewController
@property (atomic) int levelNum;
@property (nonatomic, retain) PFObject * family;
@end
