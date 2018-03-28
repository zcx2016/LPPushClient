//
//  ZCXActionSheetHeadView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCXActionSheetHeadView.h"

@implementation ZCXActionSheetHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor = ZCXColor(247, 244, 244);
    
    self.shareReasonTextField.returnKeyType = UIReturnKeyDone;
    self.shareReasonTextField.delegate = self;
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    [self.shareReasonTextField resignFirstResponder];
}
//点击 完成 收回 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
@end
