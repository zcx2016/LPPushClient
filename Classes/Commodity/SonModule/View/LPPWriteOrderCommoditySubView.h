//
//  LPPWriteOrderCommoditySubView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/21.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPWriteOrderCommoditySubView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *commodityImgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
