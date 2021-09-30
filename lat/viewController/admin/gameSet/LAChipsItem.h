//
//  LAChipsItem.h
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LAChipsItemDelegate
- (int) LAChipsItemDelegate_Clicked:(id)sender;
@end

@interface LAChipsItem : UIButton
@property (nonatomic, retain) id<LAChipsItemDelegate>delegate;
@property (atomic) int scenarioIndex;
@property (atomic) int chipIndex;
@property (atomic) int stateCode;
@property (nonatomic, retain) NSValue * imageRect;
- (void) initWithScenarioIndex;
- (void) setOriginalState:(int)stateCode;
@end
