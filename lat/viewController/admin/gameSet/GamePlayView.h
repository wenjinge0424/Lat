//
//  GamePlayView.h
//  lat
//
//  Created by Techsviewer on 6/23/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSetView.h"

@protocol GamePlayViewDelegate
- (void) GamePlayViewDelegate_ChipSelected:(id)sender;
@end

@interface GamePlayView : GameSetView
@property (nonatomic, retain) id<GamePlayViewDelegate> player_delegate;
@property (atomic) int scenarioIndex;
- (CGRect) getScenarioRect:(int)scenarioId :(int)index;
- (void) initScenarioIndex:(int)index;
- (void) initialScenario:(NSMutableDictionary*)setData;
- (void) releaseMemory;
@end
