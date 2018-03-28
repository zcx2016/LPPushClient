//
//  LPPASHeadTagView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/16.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPASHeadTagView : UIView

@property (weak, nonatomic) IBOutlet UILabel *myOrderLabel;
@property (weak, nonatomic) IBOutlet UIView *myOrderLineView;


@property (weak, nonatomic) IBOutlet UILabel *waitDealLabel;
@property (weak, nonatomic) IBOutlet UIView *waitDealLineView;


@property (weak, nonatomic) IBOutlet UILabel *chargeBackLabel;
@property (weak, nonatomic) IBOutlet UIView *chargeBackLineView;

@end
