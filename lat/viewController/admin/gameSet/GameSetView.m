//
//  GameSetView.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "GameSetView.h"
#import "LAChipsItem.h"
#import "GameRule.h"

@interface GameSetView ()<LAChipsItemDelegate>
@end

@implementation GameSetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) releaseMemory
{
    for(UIView * subView in self.subviews){
        if([subView isKindOfClass:[UIButton class]]){
            [(UIButton*)subView setBackgroundImage:nil forState:UIControlStateNormal];
            [subView removeFromSuperview];
        }
    }
}

- (CGRect) getScenarioRect:(int)scenarioId :(int)index
{
    if(scenarioId == 0){/// man with chip color
        int scenario_0_pos[14][4] = {{375,350,165,100}, {252,0,423,561}, {339,454,240,166}, {216,583,482,387}, {212,949,494,443}, {188,1350,532,696}, {238,2041,197,690},
            {480,2039,195,691}, {264,2725,173,237}, {480,2725,173,237}, {75,612,177,953}, {44,1555,118,255}, {662,614,184,947},  {756,1556,118,254}};
        return CGRectMake(scenario_0_pos[index][0], scenario_0_pos[index][1], scenario_0_pos[index][2], scenario_0_pos[index][3]);
        
    }
    if(scenarioId == 1){/// man with chip color
        int scenario_1_pos[14][4] = {{352,334,283,116}, {322,10,353,477}, {278,426,436,174}, {208,522,578,451}, {212,944,566,491}, {212,1408,577,665}, {272,2068,194,678},
            {533,2073,204,678}, {291,2746,174,240}, {533,2746,174,240}, {28,554,190,945}, {32,1502,172,339}, {781,552,194,958},  {808,1494,167,348}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 2){/// girl with chip line
        int scenario_0_pos[14][4] = {{375,350,165,100}, {252,0,423,561}, {339,454,240,166}, {216,583,482,387}, {212,949,494,443}, {188,1350,532,696}, {238,2041,197,690},
            {480,2039,195,691}, {264,2725,173,237}, {480,2725,173,237}, {75,612,177,953}, {44,1555,118,255}, {662,614,184,947},  {756,1556,118,254}};
        return CGRectMake(scenario_0_pos[index][0], scenario_0_pos[index][1], scenario_0_pos[index][2], scenario_0_pos[index][3]);
        
    }
    if(scenarioId == 3){/// man with chip line
        int scenario_1_pos[14][4] = {{352,334,283,116}, {322,10,353,477}, {278,426,436,174}, {208,522,578,451}, {212,944,566,491}, {212,1408,577,665}, {272,2068,194,678},
            {533,2073,204,678}, {291,2746,174,240}, {533,2746,174,240}, {28,554,190,945}, {32,1502,172,339}, {781,552,194,958},  {808,1494,167,348}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 4){/// girl with black bikini
        int scenario_1_pos[14][4] = {{407,324,268,126}, {414,48,266,415}, {374,395,316,225}, {299,498,472,402}, {322,899,428,226}, {256,1125,544,675}, {272,1800,196,900},
            {568,1799,200,901}, {139,2699,240,240}, {624,2699,182,259}, {149,555,172,870}, {102,1424,123,289}, {722,555,178,870},  {780,1424,120,272}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 5){/// man with black bikini
        int scenario_1_pos[14][4] = {{360,332,240,151}, {317,28,311,472}, {299,406,334,194}, {150,524,663,451}, {197,974,553,376}, {196,1349,594,451}, {188,1800,294,900},
            {568,1799,296,901}, {176,2699,199,259}, {646,2699,197,242}, {18,599,207,901}, {42,1499,170,301}, {749,600,238,900},  {844,1499,147,240}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 6){///
        int scenario_1_pos[14][4] = {{419,300,257,132}, {327,40,412,410}, {375,374,300,151}, {224,486,601,414}, {224,899,601,376}, {188,1274,680,526}, {247,1799,278,901},
            {524,1799,288,901}, {311,2699,197,229}, {548,2699,202,226}, {76,533,149,967}, {75,1499,150,247}, {824,524,145,976},  {794,1499,154,249}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 7){///
        int scenario_1_pos[14][4] = {{330,321,234,138}, {309,59,291,414}, {299,450,334,150}, {225,466,554,509}, {224,975,580,375}, {0,600,224,750}, {75,1350,300,251},
            {779,504,221,846}, {658,1350,249,263}, {224,1350,630,450}, {245,1800,322,900}, {567,1800,312,900}, {353,2699,216,182},  {660,2699,240,225}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 8){///
        int scenario_1_pos[14][4] = {{300,300,243,150}, {236,51,365,399}, {224,450,376,150}, {203,487,472,338}, {224,825,451,225}, {100,509,200,766}, {224,1243,264,346},
            {674,538,205,812}, {803,1350,153,300}, {53,1050,899,1053}, {478,2100,185,600}, {300,2100,178,600}, {394,2699,154,257},  {547,2699,200,202}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 9){///
        int scenario_1_pos[14][4] = {{434,300,241,150}, {407,49,291,418}, {374,467,273,133}, {254,524,571,376}, {262,900,518,300}, {100,565,173,935}, {149,1499,193,283},
            {750,616,250,884}, {659,1499,223,273}, {150,1200,675,600}, {214,1800,281,900}, {495,1800,255,900}, {279,2699,246,225},  {503,2699,200,257}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 10){///
        int scenario_1_pos[14][4] = {{254,300,196,150}, {159,50,460,460}, {149,450,451,150}, {224,450,493,450}, {224,900,490,300}, {85,586,140,839}, {125,1424,160,355},
            {714,500,125,700}, {623,1200,217,150}, {150,1200,651,450}, {230,1650,283,1050}, {513,1650,407,1050}, {375,2700,180,256},  {555,2699,345,255}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 11){///
        int scenario_1_pos[14][4] = {{440,357,235,151}, {470,75,256,425}, {374,449,376,226}, {224,349,676,551}, {277,900,548,300}, {48,573,327,735}, {149,1308,301,192},
            {825,900,133,300}, {844,1200,127,127}, {375,1200,467,525}, {210,1724,336,826}, {544,1725,281,975}, {210,2549,195,300},  {530,2699,318,150}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 12){///
        int scenario_1_pos[14][4] = {{204,305,258,146}, {150,75,348,375}, {131,450,394,167}, {115,525,485,414}, {115,939,485,186}, {0,571,117,929}, {0,1499,150,280},
            {599,552,364,723}, {374,1125,226,257}, {117,1125,510,600}, {128,1725,247,975}, {375,1725,198,975}, {183,2699,192,237},  {375,2699,208,237}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 13){///
        int scenario_1_pos[14][4] = {{300,339,267,153}, {283,74,312,426}, {299,498,301,177}, {202,525,520,375}, {224,899,526,451}, {75,600,150,900}, {75,1499,197,271},
            {716,570,222,855}, {749,1425,189,300}, {170,1350,662,750}, {211,2100,239,600}, {450,2100,375,600}, {225,2699,264,236},  {490,2699,280,236}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 14){///
        int scenario_1_pos[14][4] = {{351,288,241,149}, {260,74,415,376}, {274,449,420,151}, {244,524,506,376}, {282,900,468,225}, {159,551,141,874}, {150,1425,114,300},
            {749,540,151,810}, {808,1350,122,338}, {264,1125,544,450}, {133,1575,405,975}, {557,1575,260,975}, {75,2550,174,385},  {492,2549,206,375}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 15){///
        int scenario_1_pos[14][4] = {{336,320,189,140}, {307,74,305,376}, {300,450,316,150}, {224,525,546,375}, {256,900,514,300}, {112,573,150,702}, {140,1274,160,226},
            {750,575,150,850}, {730,1424,170,426}, {206,1200,544,472}, {241,1672,284,1028}, {557,1672,274,1028}, {272,2699,253,240},  {561,2699,225,229}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 16){///
        int scenario_1_pos[14][4] = {{326,399,216,147}, {265,178,316,347}, {299,525,226,225}, {224,599,451,376}, {224,975,451,261}, {0,675,225,564}, {85,1236,328,114},
            {674,675,186,825}, {675,1500,185,225}, {179,1236,495,489}, {179,1725,333,993}, {512,1725,373,953}, {253,2708,237,142},  {610,2677,390,139}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 17){///
        int scenario_1_pos[14][4] = {{414,300,196,150}, {366,50,289,400}, {299,450,409,150}, {178,500,622,400}, {196,900,594,328}, {30,599,174,826}, {61,1425,239,300},
            {794,542,180,958}, {790,1500,186,271}, {204,1228,581,497}, {170,1725,326,975}, {496,1725,279,975}, {300,2699,196,207},  {493,2699,195,256}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 18){///
        int scenario_1_pos[14][4] = {{352,285,173,141}, {278,60,396,375}, {224,435,451,165}, {199,495,512,405}, {224,900,451,225}, {73,540,152,960}, {83,1500,142,225},
            {674,524,163,901}, {713,1425,124,278}, {225,1125,488,525}, {192,1650,317,1050}, {509,1650,391,1050}, {286,2699,239,245},  {686,2699,247,246}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    if(scenarioId == 19){///
        int scenario_1_pos[14][4] = {{300,375,204,142}, {190,87,370,416}, {268,477,332,198}, {148,498,633,477}, {194,975,588,300}, {23,612,171,738}, {776,549,168,801},
            {56,1349,169,151}, {713,1275,187,273}, {134,1275,645,450}, {166,1725,359,900}, {525,1725,225,600}, {375,2624,184,306},  {525,2325,150,300}};
        return CGRectMake(scenario_1_pos[index][0], scenario_1_pos[index][1], scenario_1_pos[index][2], scenario_1_pos[index][3]);
        
    }
    return CGRectZero;
}
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
        
        LAChipsItem * item = [[LAChipsItem alloc] initWithFrame:CGRectMake(xpos, ypos, width, height)];
        item.scenarioIndex = self.scenarioIndex;
        item.chipIndex = i;
        item.imageRect = [NSValue valueWithCGRect:scenarioRect];
        item.tag  = i;
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
            if([subView isKindOfClass:[LAChipsItem class]]){
                LAChipsItem * actionItem = (LAChipsItem*)subView;
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
                if([subView isKindOfClass:[LAChipsItem class]]){
                    LAChipsItem * actionItem = (LAChipsItem*)subView;
                    int chipIndex = actionItem.chipIndex;
                    if(chipIndex == index){
                        [actionItem setOriginalState:type];
                    }
                }
            }
        }
    }
}

- (int) LAChipsItemDelegate_Clicked:(id)sender
{
    return [self.delegate GameSetViewDelegate_ChipSelected:sender];
}

- (NSMutableDictionary*) QAListArray
{
    NSMutableArray * greenIdArray = [NSMutableArray new];
    NSMutableArray * yellowIdArray = [NSMutableArray new];
    NSMutableArray * redIdArray = [NSMutableArray new];
    NSMutableDictionary * dataDict = [NSMutableDictionary new];
    for(UIView * subView in self.subviews){
        if([subView isKindOfClass:[LAChipsItem class]]){
            LAChipsItem * actionItem = (LAChipsItem*)subView;
            int chipIndex = actionItem.chipIndex;
            int selectedMod = actionItem.stateCode;
            if(selectedMod == GAMERULE_GREEN){
                [greenIdArray addObject:[NSNumber numberWithInt:chipIndex]];
            }else if(selectedMod == GAMERULE_YELLOW){
                [yellowIdArray addObject:[NSNumber numberWithInt:chipIndex]];
            }else if(selectedMod == GAMERULE_RED){
                [redIdArray addObject:[NSNumber numberWithInt:chipIndex]];
            }
        }
    }
    [dataDict setObject:greenIdArray forKey:[NSString stringWithFormat:@"%d", GAMERULE_GREEN]];
    [dataDict setObject:yellowIdArray forKey:[NSString stringWithFormat:@"%d", GAMERULE_YELLOW]];
    [dataDict setObject:redIdArray forKey:[NSString stringWithFormat:@"%d", GAMERULE_RED]];
    return dataDict;
}
@end
