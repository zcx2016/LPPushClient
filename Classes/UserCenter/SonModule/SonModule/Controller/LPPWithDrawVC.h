//
//  LPPWithDrawVC.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPWithDrawVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *withDrawView;

@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@property (weak, nonatomic) IBOutlet UILabel *canWithDrawMoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end
