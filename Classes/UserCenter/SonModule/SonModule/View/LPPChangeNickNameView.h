//
//  LPPChangeNickNameView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/7.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPChangeNickNameView : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *maskBgView;

@property (weak, nonatomic) IBOutlet UIView *popView;

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end
