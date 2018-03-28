//
//  LPPAddressSearchCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPAddressSearchCell.h"

@implementation LPPAddressSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.searchTextField.returnKeyType = UIReturnKeyDone;
    self.searchTextField.delegate = self;
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    [self.searchTextField resignFirstResponder];
}
//点击 完成 收回 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

@end
