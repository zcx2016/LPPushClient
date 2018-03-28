//
//  LPPLogisticsDetailTopView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPLogisticsDetailTopView : UIView

@property (weak, nonatomic) IBOutlet UIView *outView;

@property (weak, nonatomic) IBOutlet UIImageView *commodityImgView;

@property (weak, nonatomic) IBOutlet UILabel *commodityCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel;

//物流状态
@property (weak, nonatomic) IBOutlet UILabel *logisticsStateLabel;

//快递
@property (weak, nonatomic) IBOutlet UILabel *expressLabel;

@end
