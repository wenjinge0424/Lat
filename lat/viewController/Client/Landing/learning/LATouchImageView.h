//
//  LATouchImageView.h
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LATouchImageViewDelegate
- (void) LATouchImageViewDelegate_touchedAt:(CGPoint)point;
@end

@interface LATouchImageView : UIImageView
@property (nonatomic, retain) id<LATouchImageViewDelegate> delegate;
@end
