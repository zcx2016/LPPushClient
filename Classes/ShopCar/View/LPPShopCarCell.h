//
//  LPPShopCarCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPShopCarModel.h"

@interface LPPShopCarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *outView;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@property (weak, nonatomic) IBOutlet UIImageView *commodityImage;

@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIView *changeCountView;

@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UILabel *changeCountLabel;

@property (nonatomic, strong) LPPShopCarModel *model;

@end
