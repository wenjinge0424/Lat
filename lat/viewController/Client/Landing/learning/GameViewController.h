//
//  GameViewController.h
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "BaseViewController.h"

@interface GameViewController : BaseViewController
@property (atomic) int levelNum;
@property (atomic) NSString * levelName;
@property (nonatomic, retain) PFObject * family;
@end
