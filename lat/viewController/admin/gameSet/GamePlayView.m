//
//  GamePlayView.m
//  lat
//
//  Created by Techsviewer on 6/23/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "GamePlayView.h"
#import "LAChipsPlayItem.h"

@interface GamePlayView ()<LAChipsPlayItemDelegate>
@end

@implementation GamePlayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) initScenarioIndex:(int)index
{
    for(UIView * subview in self.subviews){
        [subview removeFromSuperview];
    }
    self.scenarioIndex = index;
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"item_%d", self.scenarioIndex]]];
    [self addSubview:imageView];
    
    for(int i=13;i>=0;i--){
        CGRect scenarioRect = [self getScenarioRect:self.scenarioIndex :i];
        float xpos = scenarioRect.origin.x * self.bounds.size.width/1000.f;
        float ypos = scenarioRect.origin.y * self.bounds.size.height/3000.f;
        float width = scenarioRect.size.width * self.bounds.size.width/1000.f;
        float height = scenarioRect.size.height * self.bounds.size.height/3000.f;
        
        LAChipsPlayItem * item = [[LAChipsPlayItem alloc] initWithFrame:CGRectMake(xpos, ypos, width, height)];
        item.scenarioIndex = self.scenarioIndex;
        if(self.scenarioIndex < 7){
            item.chipIndex = i;
            item.tag  = i;
        }else{
            int actionIndex = i;
            if(i <= 4){
                actionIndex = i;
            }
            else if(i ==9){actionIndex = 5;}
            else if(i ==10){actionIndex = 6;}
            else if(i ==11){actionIndex = 7;}
            else if(i ==12){actionIndex = 8;}
            else if(i ==13){actionIndex = 9;}
            else if(i ==5){actionIndex = 10;}
            else if(i ==6){actionIndex = 11;}
            else if(i ==7){actionIndex = 12;}
            else if(i ==8){actionIndex = 13;}
            
            if(self.scenarioIndex == 8){
                if(actionIndex ==9){actionIndex = 8;}
                else if(actionIndex ==8){actionIndex = 9;}
            }
            
            item.chipIndex = actionIndex;
            item.tag  = actionIndex;
        }
        item.imageRect = [NSValue valueWithCGRect:scenarioRect];
        item.delegate = self;
        [self addSubview:item];
        [item initWithScenarioIndex];
        
        item = nil;
    }
}
- (void) initialSelection:(NSMutableArray*)array
{
    for(NSMutableDictionary * dataDict in array){
        int tagIndex = [[[dataDict allKeys] firstObject] intValue];
        int tagState = [[dataDict objectForKey:[NSString stringWithFormat:@"%d", tagIndex]] intValue];
        for(UIView * subView in self.subviews){
            if([subView isKindOfClass:[LAChipsPlayItem class]]){
                LAChipsPlayItem * actionItem = (LAChipsPlayItem*)subView;
                int chipIndex = actionItem.chipIndex;
                if(chipIndex == tagIndex){
                    [actionItem setOriginalState:tagState];
                }
            }
        }
    }
}
- (void) initialScenario:(NSMutableDictionary*)setData
{
    for(NSString * tagkey in setData.allKeys){
        int type = tagkey.intValue;
        NSMutableArray * areaTags = setData[tagkey];
        for(NSNumber * aIndex in areaTags){
            int index = [aIndex intValue];
            for(UIView * subView in self.subviews){
                if([subView isKindOfClass:[LAChipsPlayItem class]]){
                    LAChipsPlayItem * actionItem = (LAChipsPlayItem*)subView;
                    int chipIndex = actionItem.chipIndex;
                    if(chipIndex == index){
                        [actionItem setOriginalState:type];
                    }
                }
            }
        }
    }
}
- (void) LAChipsPlayItem_Clicked:(id)sender
{
    [self.player_delegate GamePlayViewDelegate_ChipSelected:sender];
}
@end
