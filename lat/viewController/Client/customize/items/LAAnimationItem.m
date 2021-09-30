//
//  LAAnimationItem.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "LAAnimationItem.h"

@implementation LAAnimationItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) setBorderWithColor:(UIColor*)color
{
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = color.CGColor;
    
}
@end
