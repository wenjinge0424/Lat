//
//  GameScenario.h
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TOUCHED_AT_GREEN  0
#define TOUCHED_AT_YELLOW   1
#define TOUCHED_AT_RED   2
#define TOUCHED_AT_BLACK   3

@interface GameScenario_Girl : NSObject
+ (int) getScenarioCount;
+ (NSMutableArray *) getScenarioStrings;
+ (int) correctTouhType;
+ (NSString *) getImageName;
- (int) getTouchTypeAt:(CGPoint)point inView:(UIView*)view;
@end
