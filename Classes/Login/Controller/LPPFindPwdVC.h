//
//  LPPFindPwdVC.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/5.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPFindPwdVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendVerifyCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *newsPwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *sureNewPwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *sureFindBackBtn;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end
