//
//  LAChipsPlayItem.m
//  lat
//
//  Created by Techsviewer on 6/23/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "LAChipsPlayItem.h"

@implementation LAChipsPlayItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIImage*) crop:(CGRect)rect inImage:(UIImage*)source
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([source CGImage], rect);
    UIImage * result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return result;
}
- (void) initWithScenarioIndex
{
    self.opaque = NO;
    UIImage * cropedImage = [self crop:[self.imageRect CGRectValue] inImage:[UIImage imageNamed:[NSString stringWithFormat:@"mask_%d_%d", self.scenarioIndex, self.chipIndex]]];
    [self setBackgroundImage:cropedImage forState:UIControlStateNormal];
    cropedImage = nil;
    self.stateCode = -1;
    [self addTarget:self action:@selector(onSelectButton:) forControlEvents:UIControlEventTouchUpInside];
}
- (void) onSelectButton:(UIButton*)button
{
    NSLog(@"selected at:%d", (int)button.tag);
    [self.delegate LAChipsPlayItem_Clicked:self];
}
- (void) setOriginalState:(int)stateCode
{
    self.stateCode = stateCode;
    if(self.stateCode >= 0){
        if(self.scenarioIndex < 4){
            UIImage * cropedImage = [self crop:[self.imageRect CGRectValue] inImage:[UIImage imageNamed:[NSString stringWithFormat:@"mask_%d_%d_%d", self.scenarioIndex, self.chipIndex, self.stateCode]]];
            [self setBackgroundImage:cropedImage forState:UIControlStateNormal];
        }
    }
}
@end
