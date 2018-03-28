//
//  LPPShopCarBottomView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPShopCarModel.h"

@interface LPPShopCarBottomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *goToBuyBtn;

@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;

@property (weak, nonatomic) IBOutlet UILabel *endMoneyLabel;

@property (nonatomic, strong) LPPShopCarModel *model;

@end
