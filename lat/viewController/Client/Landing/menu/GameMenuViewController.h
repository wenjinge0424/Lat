//
//  GameMenuViewController.h
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "BaseViewController.h"

#define SETTING_KEY_SOUND  @"setting_sound"
#define SETTING_KEY_MUSIC  @"setting_music"

@interface GameMenuViewController : BaseViewController
@property (nonatomic, retain) PFObject * family;
@end
