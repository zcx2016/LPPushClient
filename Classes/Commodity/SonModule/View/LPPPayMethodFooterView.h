//
//  LPPPayMethodFooterView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPPayMethodFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIView *wechatPayView;
@property (weak, nonatomic) IBOutlet UIButton *wechatPayBtn;

@property (weak, nonatomic) IBOutlet UIView *aliPayView;
@property (weak, nonatomic) IBOutlet UIButton *aliPayBtn;

@end
