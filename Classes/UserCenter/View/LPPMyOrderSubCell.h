//
//  LPPMyOrderSubCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/12.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPMyOrderSonModel.h"

@interface LPPMyOrderSubCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic, strong) LPPMyOrderSonModel *model;

@end
