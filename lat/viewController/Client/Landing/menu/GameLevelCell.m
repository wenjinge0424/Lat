//
//  GameLevelCell.m
//  lat
//
//  Created by Techsviewer on 6/20/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import "GameLevelCell.h"

@implementation GameLevelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setPassed
{
    [self.btn_levelName setBackgroundImage:[UIImage imageNamed:@"ico_active_level"] forState:UIControlStateNormal];
    self.lmg_levelLine.image = [UIImage imageNamed:@"ico_locked_line"];
    [self.btn_levelName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.lbl_levelTitle.textColor = [UIColor  colorWithRed:142/255.f green:163/255.f blue:50/255.f alpha:1.f];
}
- (void) setLocked
{
    [self.btn_levelName setBackgroundImage:[UIImage imageNamed:@"ico_locked_level"] forState:UIControlStateNormal];
    self.lmg_levelLine.image = [UIImage imageNamed:@"ico_active_line"];
    UIColor * redColor = [UIColor colorWithRed:237/255.f green:95/255.f blue:95/255.f alpha:1.f];
    [self.btn_levelName setTitleColor:redColor forState:UIControlStateNormal];
    self.lbl_levelTitle.textColor = redColor;
}
@end
