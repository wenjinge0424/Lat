//
//  LAAnimationView.m
//  lat
//
//  Created by Techsviewer on 6/18/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "LAAnimationView.h"

@implementation LAAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) initWithAnimationItem:(LAScenarioItem*)item
{
    self.m_info = item;
    int totalCount = item.chipsCount;
    int scenaioIndex= item.index;
    
    for(int i= totalCount- 1; i>=totalCount- 3; i--){
        
        UIImage * maskImage = [UIImage imageNamed:[NSString stringWithFormat:@"mask_%d_%d", scenaioIndex, i]];
        CALayer * maskLayer = [CALayer layer];
        maskLayer.contents = (id)maskImage.CGImage;
        maskLayer.frame = self.bounds;
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_psd", scenaioIndex]]];
        imageView.layer.mask = maskLayer;
        imageView.layer.borderColor = [UIColor redColor].CGColor;
        imageView.layer.borderWidth = 1.f;
        
        CALayer * clolorLayer = [[CALayer alloc] initWithLayer:imageView.layer];
        clolorLayer.backgroundColor = [UIColor redColor].CGColor;
        [imageView.layer addSublayer:clolorLayer];
        
        [self addSubview:imageView];
        
//        LAAnimationItem * button = [[LAAnimationItem alloc] initWithFrame:self.bounds];
//        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mask_%d_%d", scenaioIndex, i]] forState:UIControlStateNormal];
//        [button setBorderWithColor:[UIColor redColor]];
//        button.clipsToBounds = YES;
//        button.tag = i;
//        [button addTarget:self action:@selector(onSelectButton:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:button];
    }
}
- (void) onSelectButton:(UIButton*)button
{
    NSLog(@"selected at :%d", button.tag);
}
@end
