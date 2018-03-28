//
//  LPPRegisterVC.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/5.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPRegisterVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendVerifyCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *pwdNumTextField;

@property (weak, nonatomic) IBOutlet UITextField *surePwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTextField;


@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@end
