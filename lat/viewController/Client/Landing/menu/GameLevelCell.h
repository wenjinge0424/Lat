//
//  GameLevelCell.h
//  lat
//
//  Created by Techsviewer on 6/20/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameLevelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_levelName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_levelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *lmg_levelLine;

- (void) setPassed;
- (void) setLocked;

@end
