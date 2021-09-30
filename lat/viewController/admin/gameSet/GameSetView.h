//
//  GameSetView.h
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameSetViewDelegate
- (int) GameSetViewDelegate_ChipSelected:(id)sender;
@end

@interface GameSetView : UIView
@property (nonatomic, retain) id<GameSetViewDelegate>delegate;
@property (atomic) int scenarioIndex;
- (CGRect) getScenarioRect:(int)scenarioId :(int)index;
- (void) initScenarioIndex:(int)index;

- (void) releaseMemory;

- (NSMutableDictionary*) QAListArray;
- (void) initialSelection:(NSMutableArray*)array;
- (void) initialScenario:(NSMutableDictionary*)setData;
@end
