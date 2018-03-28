//
//  LPPMyAccountHeadView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPMyAccountHeadView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIView *redHeadView;

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//余额view
@property (weak, nonatomic) IBOutlet UIView *balanceView;
//余额label
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
//充值
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
//提现
@property (weak, nonatomic) IBOutlet UIButton *withDrawBtn;

//金额view
@property (weak, nonatomic) IBOutlet UIView *moneyView;
//销售金额
@property (weak, nonatomic) IBOutlet UILabel *salesAmountLabel;
//待入账金额
@property (weak, nonatomic) IBOutlet UILabel *toBeCreditAmountLabel;
@end
