//
//  LAChipsPlayItem.h
//  lat
//
//  Created by Techsviewer on 6/23/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LAChipsPlayItemDelegate
- (void) LAChipsPlayItem_Clicked:(id)sender;
@end

@interface LAChipsPlayItem : UIButton
@property (nonatomic, retain) id<LAChipsPlayItemDelegate>delegate;
@property (atomic) int scenarioIndex;
@property (atomic) int chipIndex;
@property (atomic) int stateCode;
@property (nonatomic, retain) NSValue * imageRect;
- (void) initWithScenarioIndex;
- (void) setOriginalState:(int)stateCode;
@end
