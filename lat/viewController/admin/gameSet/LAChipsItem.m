//
//  LAChipsItem.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "LAChipsItem.h"

@implementation LAChipsItem

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
    int code = [self.delegate LAChipsItemDelegate_Clicked:self];
    if(self.stateCode >= 0){
        if(self.stateCode == code){
            self.stateCode = -1;
            if(self.scenarioIndex < 4){
                UIImage * cropedImage = [self crop:[self.imageRect CGRectValue] inImage:[UIImage imageNamed:[NSString stringWithFormat:@"mask_%d_%d", self.scenarioIndex, self.chipIndex]]];
                [self setBackgroundImage:cropedImage forState:UIControlStateNormal];
            }else{
                self.layer.borderWidth = 1.f;
                self.layer.borderColor = [UIColor clearColor].CGColor;
            }
            return;
        }
    }
    self.stateCode = code;
    if(self.scenarioIndex < 4){
        UIImage * cropedImage = [self crop:[self.imageRect CGRectValue] inImage:[UIImage imageNamed:[NSString stringWithFormat:@"mask_%d_%d_%d", self.scenarioIndex, self.chipIndex, self.stateCode]]];
        [self setBackgroundImage:cropedImage forState:UIControlStateNormal];
    }else{
        self.layer.borderWidth = 1.f;
        if(self.stateCode == 0)
            self.layer.borderColor = [UIColor redColor].CGColor;
        else if(self.stateCode == 1)
            self.layer.borderColor = [UIColor yellowColor].CGColor;
        else
            self.layer.borderColor = [UIColor greenColor].CGColor;
    }
}
- (void) setOriginalState:(int)stateCode
{
    self.stateCode = stateCode;
    if(self.stateCode >= 0){
        if(self.scenarioIndex < 4){
            UIImage * cropedImage = [self crop:[self.imageRect CGRectValue] inImage:[UIImage imageNamed:[NSString stringWithFormat:@"mask_%d_%d_%d", self.scenarioIndex, self.chipIndex, self.stateCode]]];
            [self setBackgroundImage:cropedImage forState:UIControlStateNormal];
        }else{
            self.layer.borderWidth = 1.f;
            if(self.stateCode == 0)
                self.layer.borderColor = [UIColor redColor].CGColor;
            else if(self.stateCode == 1)
                self.layer.borderColor = [UIColor yellowColor].CGColor;
            else
                self.layer.borderColor = [UIColor greenColor].CGColor;
        }
    }
}
@end
