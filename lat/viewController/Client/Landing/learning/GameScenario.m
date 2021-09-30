//
//  GameScenario.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "GameScenario.h"

@implementation GameScenario_Girl
+ (NSString *) getImageName
{
    return @"bg_normalGirl";
}
+ (int) getScenarioCount
{
    return 5;
}
+ (NSMutableArray *) getScenarioStrings
{
    return  [[NSMutableArray alloc] initWithObjects:@"Touch the head",@"Touch the head",@"Touch the head",@"Touch the head",@"Touch the head", nil];
}
+ (int) correctTouhType
{
    return TOUCHED_AT_YELLOW;
}
- (NSMutableArray * ) getRedPaths
{
    NSMutableArray * array = [NSMutableArray new];
    UIBezierPath * path0 = [UIBezierPath bezierPath];
    [path0 moveToPoint:CGPointMake(382, 382)];
    [path0 addLineToPoint:CGPointMake(414, 367)];
    [path0 addLineToPoint:CGPointMake(418, 372)];
    [path0 addLineToPoint:CGPointMake(429, 366)];
    [path0 addLineToPoint:CGPointMake(455, 380)];
    [path0 addLineToPoint:CGPointMake(431, 404)];
    [path0 addLineToPoint:CGPointMake(419, 399)];
    [path0 addLineToPoint:CGPointMake(407, 404)];
    [path0 addLineToPoint:CGPointMake(382, 382)];
    [array addObject:path0];
    
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(355, 437)];
    [path1 addLineToPoint:CGPointMake(344, 525)];
    [path1 addLineToPoint:CGPointMake(273, 579)];
    [path1 addLineToPoint:CGPointMake(181, 593)];
    [path1 addLineToPoint:CGPointMake(209, 1124)];
    [path1 addLineToPoint:CGPointMake(150, 1574)];
    [path1 addLineToPoint:CGPointMake(198, 2015)];
    [path1 addLineToPoint:CGPointMake(376, 2015)];
    [path1 addLineToPoint:CGPointMake(402, 1724)];
    [path1 addLineToPoint:CGPointMake(405, 1513)];
    [path1 addLineToPoint:CGPointMake(419, 1499)];
    [path1 addLineToPoint:CGPointMake(430, 1514)];
    [path1 addLineToPoint:CGPointMake(442, 1800)];
    [path1 addLineToPoint:CGPointMake(464, 2015)];
    [path1 addLineToPoint:CGPointMake(636, 2015)];
    [path1 addLineToPoint:CGPointMake(677, 1722)];
    [path1 addLineToPoint:CGPointMake(682, 1519)];
    [path1 addLineToPoint:CGPointMake(625, 1123)];
    [path1 addLineToPoint:CGPointMake(628, 909)];
    [path1 addLineToPoint:CGPointMake(658, 592)];
    [path1 addLineToPoint:CGPointMake(596, 588)];
    [path1 addLineToPoint:CGPointMake(508, 543)];
    [path1 addLineToPoint:CGPointMake(480, 490)];
    [path1 addLineToPoint:CGPointMake(480, 490)];
    [path1 addLineToPoint:CGPointMake(479, 435)];
    [path1 addLineToPoint:CGPointMake(421, 457)];
    [path1 addLineToPoint:CGPointMake(355, 437)];
    [array addObject:path1];
    return array;
}
- (NSMutableArray * ) getGreenPaths
{
    NSMutableArray * array = [NSMutableArray new];
    UIBezierPath * path0 = [UIBezierPath bezierPath];
    [path0 moveToPoint:CGPointMake(30, 1532)];
    [path0 addLineToPoint:CGPointMake(0, 1650)];
    [path0 addLineToPoint:CGPointMake(76, 1786)];
    [path0 addLineToPoint:CGPointMake(93, 1775)];
    [path0 addLineToPoint:CGPointMake(117, 1651)];
    [path0 addLineToPoint:CGPointMake(87, 1532)];
    [path0 addLineToPoint:CGPointMake(30, 1532)];
    [array addObject:path0];
    
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(751, 1532)];
    [path1 addLineToPoint:CGPointMake(754, 1786)];
    [path1 addLineToPoint:CGPointMake(781, 1770)];
    [path1 addLineToPoint:CGPointMake(839, 1652)];
    [path1 addLineToPoint:CGPointMake(808, 1532)];
    [path1 addLineToPoint:CGPointMake(751, 1532)];
    [array addObject:path1];
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(302, 2700)];
    [path2 addLineToPoint:CGPointMake(300, 2772)];
    [path2 addLineToPoint:CGPointMake(224, 2898)];
    [path2 addLineToPoint:CGPointMake(253, 2923)];
    [path2 addLineToPoint:CGPointMake(376, 2918)];
    [path2 addLineToPoint:CGPointMake(395, 2890)];
    [path2 addLineToPoint:CGPointMake(395, 2890)];
    [path2 addLineToPoint:CGPointMake(372, 2773)];
    [path2 addLineToPoint:CGPointMake(384, 2741)];
    [path2 addLineToPoint:CGPointMake(367, 2700)];
    [path2 addLineToPoint:CGPointMake(302, 2700)];
    [array addObject:path2];
    
    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(472, 2700)];
    [path3 addLineToPoint:CGPointMake(454, 2743)];
    [path3 addLineToPoint:CGPointMake(463, 2777)];
    [path3 addLineToPoint:CGPointMake(441, 2885)];
    [path3 addLineToPoint:CGPointMake(459, 2922)];
    [path3 addLineToPoint:CGPointMake(594, 2920)];
    [path3 addLineToPoint:CGPointMake(617, 2894)];
    [path3 addLineToPoint:CGPointMake(530, 2747)];
    [path3 addLineToPoint:CGPointMake(535, 2700)];
    [path3 addLineToPoint:CGPointMake(472, 2700)];
    [array addObject:path3];
    
    return array;
}
- (NSMutableArray * ) getYellowPaths
{
    NSMutableArray * array = [NSMutableArray new];
    UIBezierPath * path0 = [UIBezierPath bezierPath];
    [path0 moveToPoint:CGPointMake(394, 0)];
    [path0 addLineToPoint:CGPointMake(285, 38)];
    [path0 addLineToPoint:CGPointMake(241, 129)];
    [path0 addLineToPoint:CGPointMake(224, 203)];
    [path0 addLineToPoint:CGPointMake(206, 311)];
    [path0 addLineToPoint:CGPointMake(223, 438)];
    [path0 addLineToPoint:CGPointMake(338, 530)];
    [path0 addLineToPoint:CGPointMake(354, 497)];
    [path0 addLineToPoint:CGPointMake(354, 497)];
    [path0 addLineToPoint:CGPointMake(357, 436)];
    [path0 addLineToPoint:CGPointMake(421, 459)];
    [path0 addLineToPoint:CGPointMake(479, 436)];
    [path0 addLineToPoint:CGPointMake(479, 493)];
    [path0 addLineToPoint:CGPointMake(496, 531)];
    [path0 addLineToPoint:CGPointMake(634, 406)];
    [path0 addLineToPoint:CGPointMake(636, 323)];
    [path0 addLineToPoint:CGPointMake(602, 209)];
    [path0 addLineToPoint:CGPointMake(587, 99)];
    [path0 addLineToPoint:CGPointMake(546, 40)];
    [path0 addLineToPoint:CGPointMake(507, 41)];
    [path0 addLineToPoint:CGPointMake(507, 41)];
    [path0 addLineToPoint:CGPointMake(446, 7)];
    [path0 addLineToPoint:CGPointMake(394, 0)];
    [array addObject:path0];
    
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(177, 595)];
    [path1 addLineToPoint:CGPointMake(207, 1050)];
    [path1 addLineToPoint:CGPointMake(88, 1532)];
    [path1 addLineToPoint:CGPointMake(29, 1532)];
    [path1 addLineToPoint:CGPointMake(41, 1348)];
    [path1 addLineToPoint:CGPointMake(89, 1102)];
    [path1 addLineToPoint:CGPointMake(96, 702)];
    [path1 addLineToPoint:CGPointMake(129, 621)];
    [path1 addLineToPoint:CGPointMake(177, 595)];
    [array addObject:path1];
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(656, 595)];
    [path2 addLineToPoint:CGPointMake(628, 1051)];
    [path2 addLineToPoint:CGPointMake(752, 1533)];
    [path2 addLineToPoint:CGPointMake(807, 1533)];
    [path2 addLineToPoint:CGPointMake(795, 1330)];
    [path2 addLineToPoint:CGPointMake(750, 1113)];
    [path2 addLineToPoint:CGPointMake(750, 1113)];
    [path2 addLineToPoint:CGPointMake(741, 703)];
    [path2 addLineToPoint:CGPointMake(711, 624)];
    [path2 addLineToPoint:CGPointMake(656, 595)];
    [array addObject:path2];
    
    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(199, 2014)];
    [path3 addLineToPoint:CGPointMake(209, 2284)];
    [path3 addLineToPoint:CGPointMake(303, 2700)];
    [path3 addLineToPoint:CGPointMake(367, 2700)];
    [path3 addLineToPoint:CGPointMake(396, 2325)];
    [path3 addLineToPoint:CGPointMake(374, 2014)];
    [path3 addLineToPoint:CGPointMake(199, 2014)];
    [array addObject:path3];
    
    UIBezierPath * path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(465, 2014)];
    [path4 addLineToPoint:CGPointMake(440, 2324)];
    [path4 addLineToPoint:CGPointMake(440, 2324)];
    [path4 addLineToPoint:CGPointMake(472, 2700)];
    [path4 addLineToPoint:CGPointMake(533, 2700)];
    [path4 addLineToPoint:CGPointMake(631, 2273)];
    [path4 addLineToPoint:CGPointMake(635, 2014)];
    [path4 addLineToPoint:CGPointMake(465, 2014)];
    [array addObject:path4];
    
    return array;
}

- (int) getTouchTypeAt:(CGPoint)point inView:(UIView*)view
{
    CGSize totalImageSize = CGSizeMake(840, 2969);
    CGSize viewSize = view.frame.size;
    CGPoint convertedCoint = point;
    convertedCoint.x = point.x * totalImageSize.width / viewSize.width;
    convertedCoint.y = point.y * totalImageSize.height / viewSize.height;
    
    NSMutableArray * redPathArray = [self getRedPaths];
    for(UIBezierPath * path in redPathArray){
        if([path containsPoint:convertedCoint]){
            return TOUCHED_AT_RED;
        }
    }
    NSMutableArray * greenPathArray = [self getGreenPaths];
    for(UIBezierPath * path in greenPathArray){
        if([path containsPoint:convertedCoint]){
            return TOUCHED_AT_GREEN;
        }
    }
    NSMutableArray * yellowPathArray = [self getYellowPaths];
    for(UIBezierPath * path in yellowPathArray){
        if([path containsPoint:convertedCoint]){
            return TOUCHED_AT_YELLOW;
        }
    }
    
    return TOUCHED_AT_BLACK;
}

@end
