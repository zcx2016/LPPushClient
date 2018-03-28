//
//  LPPMyAccountCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPMyAccountCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *sonView;

@property (weak, nonatomic) IBOutlet UIImageView *headIcon;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
