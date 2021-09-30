//
//  LATectField.m
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "LATectField.h"

@implementation LATectField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [_edt_text setTextColor:[UIColor blackColor]];
    [_edt_text setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_img_bg setImage:[UIImage imageNamed:@"bg_textfield_gray"]];
}
- (void) setText:(NSString *)text
{
    [_edt_text setText:text];
}
- (NSString*) text{
    return _edt_text.text;
}

- (void) setError
{
    [_edt_text setTextColor:[UIColor redColor]];
    [_edt_text setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_img_bg setImage:[UIImage imageNamed:@"bg_textfield_red"]];
}
- (void) setNormal
{
    [_edt_text setTextColor:[UIColor blackColor]];
    [_edt_text setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_img_bg setImage:[UIImage imageNamed:@"bg_textfield_gray"]];
}
@end

@implementation LABigTectField

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)layoutSubviews
{
    [_edt_text setTextColor:[UIColor blackColor]];
    [_edt_text setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_img_bg setImage:[UIImage imageNamed:@"bg_big_textfield_gray"]];
}
- (void) setText:(NSString *)text
{
    [_edt_text setText:text];
}
- (NSString*) text{
    return _edt_text.text;
}

- (void) setError
{
    [_edt_text setTextColor:[UIColor redColor]];
    [_edt_text setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_img_bg setImage:[UIImage imageNamed:@"bg_big_textfield_red"]];
}
- (void) setNormal
{
    [_edt_text setTextColor:[UIColor blackColor]];
    [_edt_text setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_img_bg setImage:[UIImage imageNamed:@"bg_big_textfield_gray"]];
}
@end
