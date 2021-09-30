//
//  ProfileUserCell.h
//  lat
//
//  Created by Techsviewer on 6/17/18.
//  Copyright © 2018 brainyapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleImageView.h"

@interface ProfileUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet CircleImageView *img_thumb;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userType;
@property (weak, nonatomic) IBOutlet UILabel *lbl_levelNum;

@end
