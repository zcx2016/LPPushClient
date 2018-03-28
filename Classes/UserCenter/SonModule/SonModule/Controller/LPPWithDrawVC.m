//
//  LPPWithDrawVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPWithDrawVC.h"

@interface LPPWithDrawVC ()

@end

@implementation LPPWithDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"提现";
    
    self.withDrawView.layer.cornerRadius = 5;
    self.withDrawView.layer.masksToBounds = YES;
    
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.layer.masksToBounds = YES;
}


@end
