//
//  LAAnimationView.h
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAAnimationItem.h"
#import "LAScenarioItem.h"

@interface LAAnimationView : UIImageView
@property (nonatomic, retain) LAScenarioItem * m_info;
- (void) initWithAnimationItem:(LAScenarioItem*)item;
@end
