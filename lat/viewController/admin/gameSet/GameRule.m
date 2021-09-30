//
//  GameRule.m
//  lat
//
//  Created by Techsviewer on 6/20/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "GameRule.h"
/////0 : green
/////1 : red
/////2 : yellow
@implementation GameRule

+ (NSMutableDictionary *) getDefaultScenarioForLevel:(int)level
{
    NSMutableDictionary * dataDict = [NSMutableDictionary new];
    if(level == 1){
        NSMutableArray * greenAreas = [[NSMutableArray alloc] initWithObjects:
                                       [NSNumber numberWithInt:8],
                                       [NSNumber numberWithInt:9],
                                       [NSNumber numberWithInt:11],
                                       [NSNumber numberWithInt:13], nil];
        NSMutableArray * yellowAreas = [[NSMutableArray alloc] initWithObjects:
                                        [NSNumber numberWithInt:1],
                                        [NSNumber numberWithInt:10],
                                        [NSNumber numberWithInt:12],
                                        [NSNumber numberWithInt:6],
                                        [NSNumber numberWithInt:7],nil];
        NSMutableArray * redAreas = [[NSMutableArray alloc] initWithObjects:
                                        [NSNumber numberWithInt:0],
                                        [NSNumber numberWithInt:2],
                                        [NSNumber numberWithInt:3],
                                        [NSNumber numberWithInt:4],
                                        [NSNumber numberWithInt:5],nil];
        [dataDict setObject:greenAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_GREEN]];
        [dataDict setObject:yellowAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_YELLOW]];
        [dataDict setObject:redAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_RED]];
    }else if(level == 2){
        NSMutableArray * greenAreas = [[NSMutableArray alloc] initWithObjects:
                                       [NSNumber numberWithInt:8],
                                       [NSNumber numberWithInt:9],
                                       [NSNumber numberWithInt:11],
                                       [NSNumber numberWithInt:13], nil];
        NSMutableArray * yellowAreas = [[NSMutableArray alloc] initWithObjects:
                                        [NSNumber numberWithInt:1],
                                        [NSNumber numberWithInt:10],
                                        [NSNumber numberWithInt:12],
                                        [NSNumber numberWithInt:4],
                                        [NSNumber numberWithInt:6],
                                        [NSNumber numberWithInt:7],nil];
        NSMutableArray * redAreas = [[NSMutableArray alloc] initWithObjects:
                                     [NSNumber numberWithInt:0],
                                     [NSNumber numberWithInt:2],
                                     [NSNumber numberWithInt:3],
                                     [NSNumber numberWithInt:5],nil];
        [dataDict setObject:greenAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_GREEN]];
        [dataDict setObject:yellowAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_YELLOW]];
        [dataDict setObject:redAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_RED]];
    }else if(level == 3 || level == 4){
        NSMutableArray * greenAreas = [[NSMutableArray alloc] init];
        NSMutableArray * yellowAreas = [[NSMutableArray alloc] initWithObjects:
                                        [NSNumber numberWithInt:10],
                                        [NSNumber numberWithInt:12],
                                        [NSNumber numberWithInt:11],
                                        [NSNumber numberWithInt:13],
                                        [NSNumber numberWithInt:8],
                                        [NSNumber numberWithInt:9],nil];
        NSMutableArray * redAreas = [[NSMutableArray alloc] initWithObjects:
                                     [NSNumber numberWithInt:0],
                                      [NSNumber numberWithInt:1],
                                     [NSNumber numberWithInt:2],
                                     [NSNumber numberWithInt:3],
                                     [NSNumber numberWithInt:4],
                                     [NSNumber numberWithInt:5],
                                     [NSNumber numberWithInt:6],
                                     [NSNumber numberWithInt:7],nil];
        [dataDict setObject:greenAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_GREEN]];
        [dataDict setObject:yellowAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_YELLOW]];
        [dataDict setObject:redAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_RED]];
    }else if(level == 5 || level == 6){
        NSMutableArray * greenAreas = [[NSMutableArray alloc] initWithObjects:
                                       [NSNumber numberWithInt:11],
                                       [NSNumber numberWithInt:13],nil];
        NSMutableArray * yellowAreas = [[NSMutableArray alloc] init];
        NSMutableArray * redAreas = [[NSMutableArray alloc] initWithObjects:
                                     [NSNumber numberWithInt:0],
                                     [NSNumber numberWithInt:1],
                                     [NSNumber numberWithInt:2],
                                     [NSNumber numberWithInt:3],
                                     [NSNumber numberWithInt:4],
                                     [NSNumber numberWithInt:5],
                                     [NSNumber numberWithInt:6],
                                     [NSNumber numberWithInt:7],
                                     [NSNumber numberWithInt:8],
                                     [NSNumber numberWithInt:9],
                                     [NSNumber numberWithInt:10],
                                     [NSNumber numberWithInt:12],nil];
        [dataDict setObject:greenAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_GREEN]];
        [dataDict setObject:yellowAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_YELLOW]];
        [dataDict setObject:redAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_RED]];
    }else if(level == 7 || level == 10){
        NSMutableArray * greenAreas = [[NSMutableArray alloc] init];
        NSMutableArray * yellowAreas = [[NSMutableArray alloc] initWithObjects:
                                        [NSNumber numberWithInt:10],
                                        [NSNumber numberWithInt:12],
                                        [NSNumber numberWithInt:11],
                                        [NSNumber numberWithInt:13],
                                        nil];
        NSMutableArray * redAreas = [[NSMutableArray alloc] initWithObjects:
                                     [NSNumber numberWithInt:0],
                                     [NSNumber numberWithInt:1],
                                     [NSNumber numberWithInt:2],
                                     [NSNumber numberWithInt:3],
                                     [NSNumber numberWithInt:4],
                                     [NSNumber numberWithInt:5],
                                     [NSNumber numberWithInt:6],
                                     [NSNumber numberWithInt:7],
                                     [NSNumber numberWithInt:8],
                                     [NSNumber numberWithInt:9],nil];
        [dataDict setObject:greenAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_GREEN]];
        [dataDict setObject:yellowAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_YELLOW]];
        [dataDict setObject:redAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_RED]];
    }else if(level == 8 || level == 11){
        NSMutableArray * greenAreas = [[NSMutableArray alloc] init];
        NSMutableArray * yellowAreas = [[NSMutableArray alloc] initWithObjects:
                                        [NSNumber numberWithInt:1],
                                        [NSNumber numberWithInt:10],
                                        [NSNumber numberWithInt:12],
                                        [NSNumber numberWithInt:11],
                                        [NSNumber numberWithInt:13],
                                        nil];
        NSMutableArray * redAreas = [[NSMutableArray alloc] initWithObjects:
                                     [NSNumber numberWithInt:0],
                                     [NSNumber numberWithInt:2],
                                     [NSNumber numberWithInt:3],
                                     [NSNumber numberWithInt:4],
                                     [NSNumber numberWithInt:5],
                                     [NSNumber numberWithInt:6],
                                     [NSNumber numberWithInt:7],
                                     [NSNumber numberWithInt:8],
                                     [NSNumber numberWithInt:9],nil];
        [dataDict setObject:greenAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_GREEN]];
        [dataDict setObject:yellowAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_YELLOW]];
        [dataDict setObject:redAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_RED]];
    }else if(level == 9 || level == 12){
        NSMutableArray * greenAreas = [[NSMutableArray alloc] init];
        NSMutableArray * yellowAreas = [[NSMutableArray alloc] initWithObjects:
                                        [NSNumber numberWithInt:1],
                                        [NSNumber numberWithInt:2],
                                        [NSNumber numberWithInt:3],
                                        [NSNumber numberWithInt:4],
                                        [NSNumber numberWithInt:5],
                                        [NSNumber numberWithInt:6],
                                        [NSNumber numberWithInt:7],
                                        [NSNumber numberWithInt:8],
                                        [NSNumber numberWithInt:9],
                                        [NSNumber numberWithInt:10],
                                        [NSNumber numberWithInt:12],
                                        [NSNumber numberWithInt:11],
                                        [NSNumber numberWithInt:13],
                                        nil];
        NSMutableArray * redAreas = [[NSMutableArray alloc] init];
        [dataDict setObject:greenAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_GREEN]];
        [dataDict setObject:yellowAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_YELLOW]];
        [dataDict setObject:redAreas forKey:[NSString stringWithFormat:@"%d", GAMERULE_RED]];
    }
    return dataDict;
}

+ (int) getSettingScenarioForLevel:(int)level
{
    if(level == 1 || level == 2)
        return 0;
    if(level == 3 || level == 4)
        return 0;
    if(level == 5 || level == 6)
        return 0;
    if(level == 7 || level == 8)
        return 0;
    if(level == 9 || level == 10)
        return 0;
    if(level == 11)
        return 1;
    if(level == 12)
        return 0;
    return 0;
}
+ (NSMutableArray *) getScenarioForLevel:(int)level
{
    if(level == 1 || level == 2){
        return [[NSMutableArray alloc] initWithObjects:
                [NSNumber numberWithInt:0],
               [NSNumber numberWithInt:1],
                [NSNumber numberWithInt:2],
                [NSNumber numberWithInt:3],
                [NSNumber numberWithInt:4],
                [NSNumber numberWithInt:5],
                [NSNumber numberWithInt:6],
                [NSNumber numberWithInt:7],
                [NSNumber numberWithInt:8],
                [NSNumber numberWithInt:9],
                [NSNumber numberWithInt:10],
                [NSNumber numberWithInt:11],
                [NSNumber numberWithInt:12],
                [NSNumber numberWithInt:13],
                [NSNumber numberWithInt:14],
                [NSNumber numberWithInt:15],nil];
    }
    if(level == 3 || level == 4){
        return [[NSMutableArray alloc] initWithObjects:
                [NSNumber numberWithInt:0],
                [NSNumber numberWithInt:1],
                [NSNumber numberWithInt:2],
                [NSNumber numberWithInt:3],
                [NSNumber numberWithInt:4],
                [NSNumber numberWithInt:5],
                [NSNumber numberWithInt:6],
                [NSNumber numberWithInt:7],
                [NSNumber numberWithInt:8],
                [NSNumber numberWithInt:9],
                [NSNumber numberWithInt:10],
                [NSNumber numberWithInt:11],
                [NSNumber numberWithInt:12],
                [NSNumber numberWithInt:13],
                [NSNumber numberWithInt:14],
                [NSNumber numberWithInt:15],nil];
    }
    if(level == 5 || level == 6){
        return [[NSMutableArray alloc] initWithObjects:
                [NSNumber numberWithInt:0],
                [NSNumber numberWithInt:1],
                [NSNumber numberWithInt:2],
                [NSNumber numberWithInt:3],
                [NSNumber numberWithInt:4],
                [NSNumber numberWithInt:5],
                [NSNumber numberWithInt:6],
                [NSNumber numberWithInt:7],
                [NSNumber numberWithInt:8],
                [NSNumber numberWithInt:9],
                [NSNumber numberWithInt:10],
                [NSNumber numberWithInt:11],
                [NSNumber numberWithInt:12],
                [NSNumber numberWithInt:13],
                [NSNumber numberWithInt:14],
                [NSNumber numberWithInt:15],nil];
    }
    if(level == 7 || level == 8){
        return [[NSMutableArray alloc] initWithObjects:
                [NSNumber numberWithInt:0],
                [NSNumber numberWithInt:1],
                [NSNumber numberWithInt:2],
                [NSNumber numberWithInt:3],
                [NSNumber numberWithInt:18],
                [NSNumber numberWithInt:19],nil];
    }
    if(level == 9){
        return [[NSMutableArray alloc] initWithObjects:
                [NSNumber numberWithInt:0],
                [NSNumber numberWithInt:1],
                [NSNumber numberWithInt:2],
                [NSNumber numberWithInt:3],
                [NSNumber numberWithInt:16],
                [NSNumber numberWithInt:17],nil];
    }
    if(level == 10){
        return [[NSMutableArray alloc] initWithObjects:
                [NSNumber numberWithInt:0],
                [NSNumber numberWithInt:2],
                [NSNumber numberWithInt:4],
                [NSNumber numberWithInt:6],
                [NSNumber numberWithInt:8],
                [NSNumber numberWithInt:10],
                [NSNumber numberWithInt:12],
                [NSNumber numberWithInt:14],
                [NSNumber numberWithInt:16],
                [NSNumber numberWithInt:18],nil];
    }
    if(level == 11){
        return [[NSMutableArray alloc] initWithObjects:
                [NSNumber numberWithInt:1],
                [NSNumber numberWithInt:3],
                [NSNumber numberWithInt:5],
                [NSNumber numberWithInt:7],
                [NSNumber numberWithInt:9],
                [NSNumber numberWithInt:11],
                [NSNumber numberWithInt:13],
                [NSNumber numberWithInt:15],
                [NSNumber numberWithInt:17],
                [NSNumber numberWithInt:19],nil];
    }
    if(level == 12){
        return [[NSMutableArray alloc] initWithObjects:
                [NSNumber numberWithInt:0],
                [NSNumber numberWithInt:1],
                [NSNumber numberWithInt:2],
                [NSNumber numberWithInt:3],
                [NSNumber numberWithInt:4],
                [NSNumber numberWithInt:5],
                [NSNumber numberWithInt:6],
                [NSNumber numberWithInt:7],
                [NSNumber numberWithInt:8],
                [NSNumber numberWithInt:9],
                [NSNumber numberWithInt:10],
                [NSNumber numberWithInt:11],
                [NSNumber numberWithInt:12],
                [NSNumber numberWithInt:13],
                [NSNumber numberWithInt:14],
                [NSNumber numberWithInt:15],
                [NSNumber numberWithInt:16],
                [NSNumber numberWithInt:17],
                [NSNumber numberWithInt:18],
                [NSNumber numberWithInt:19],nil];
    }
    return nil;
}
@end
