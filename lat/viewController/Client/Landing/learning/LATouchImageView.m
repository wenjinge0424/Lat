//
//  LATouchImageView.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "LATouchImageView.h"

@implementation LATouchImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * aTouch = [touches anyObject];
    CGPoint point = [aTouch locationInView:self];
    [self.delegate LATouchImageViewDelegate_touchedAt:point];
}
@end
