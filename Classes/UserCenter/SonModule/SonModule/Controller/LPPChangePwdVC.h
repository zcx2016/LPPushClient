//
//  LPPChangePwdVC.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/7.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPChangePwdVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *newsPwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *sureNewsPwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@end
