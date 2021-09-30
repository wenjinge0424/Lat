//
//  PlayingViewController.h
//  lat
//
//  Created by Techsviewer on 7/23/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "BaseViewController.h"

@interface PlayingViewController : BaseViewController
@property (atomic) int levelNum;
@property (atomic) NSString * levelName;
@property (nonatomic, retain) PFObject * family;
@end
