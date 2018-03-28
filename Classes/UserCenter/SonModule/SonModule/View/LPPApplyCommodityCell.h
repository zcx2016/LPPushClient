//
//  LPPApplyCommodityCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPApplyCommodityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *outView;

@property (weak, nonatomic) IBOutlet UIImageView *commodityImgView;

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *commodityNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel;
@end
