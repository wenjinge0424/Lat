//
//  GameRule.h
//  lat
//
//  Created by Techsviewer on 6/20/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GAMERULE_GREEN      2
#define GAMERULE_YELLOW     1
#define GAMERULE_RED        0

@interface GameRule : NSObject
+ (NSMutableArray *) getScenarioForLevel:(int)level;
+ (int) getSettingScenarioForLevel:(int)level;
+ (NSMutableDictionary *) getDefaultScenarioForLevel:(int)level;
@end
