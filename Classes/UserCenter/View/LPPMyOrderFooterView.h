//
//  LPPMyOrderFooterView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPMyOrderFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIView *outView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIButton *goToPayBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancelOrderBtn;

@end
