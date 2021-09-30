//
//  LATectField.h
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LATectField : UIView
@property (nonatomic, retain) IBOutlet UITextField * edt_text;
@property (nonatomic, retain) IBOutlet UIImageView * img_bg;
@property (nonatomic, retain) UIColor * placefolderColor;

@property (nonatomic, retain, getter = text) NSString * text;

- (void) setError;
- (void) setNormal;
@end

@interface LABigTectField : UIView
@property (nonatomic, retain) IBOutlet UITextField * edt_text;
@property (nonatomic, retain) IBOutlet UIImageView * img_bg;
@property (nonatomic, retain) UIColor * placefolderColor;

@property (nonatomic, retain, getter = text) NSString * text;

- (void) setError;
- (void) setNormal;
@end
