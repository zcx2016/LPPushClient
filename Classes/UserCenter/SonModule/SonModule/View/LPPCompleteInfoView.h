//
//  LPPCompleteInfoView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/8.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPCompleteInfoView : UIView

@property (weak, nonatomic) IBOutlet UIView *topInfoView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (weak, nonatomic) IBOutlet UITextField *idCardTextField;

@property (weak, nonatomic) IBOutlet UITextView *addressTextView;

@property (weak, nonatomic) IBOutlet UITextField *postalCodeTextField;

@property (weak, nonatomic) IBOutlet UIView *uploadView;

@property (weak, nonatomic) IBOutlet UIImageView *idCardFrontImgView;

@property (weak, nonatomic) IBOutlet UIImageView *idCardBackImgView;

@property (weak, nonatomic) IBOutlet UIButton *idCardFrontBtn;

@property (weak, nonatomic) IBOutlet UIButton *idCardBackBtn;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end
