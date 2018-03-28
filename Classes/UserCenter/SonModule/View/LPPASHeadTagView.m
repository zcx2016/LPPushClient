//
//  LPPASHeadTagView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/16.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPASHeadTagView.h"

@implementation LPPASHeadTagView

- (void)awakeFromNib{
    [super awakeFromNib];
    //242 173 163
    self.frame = CGRectMake(0, 0, kScreenWidth, 50);
    
    self.myOrderLabel.userInteractionEnabled = YES;
    [self.myOrderLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myOrderEvents:)]];
    
    self.waitDealLabel.userInteractionEnabled = YES;
    [self.waitDealLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(waitDealEvents:)]];
    self.waitDealLineView.hidden = YES;
    
    self.chargeBackLabel.userInteractionEnabled = YES;
    [self.chargeBackLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chargeBackEvents:)]];
    self.chargeBackLineView.hidden = YES;
}

- (void)myOrderEvents:(UITapGestureRecognizer *)recognize{
    self.myOrderLabel.textColor = [UIColor whiteColor];
    self.myOrderLineView.hidden = NO;
    
    self.waitDealLabel.textColor = ZCXColor(242, 173, 163);
    self.waitDealLineView.hidden = YES;
    self.chargeBackLabel.textColor = ZCXColor(242, 173, 163);
    self.chargeBackLineView.hidden = YES;
}

- (void)waitDealEvents:(UITapGestureRecognizer *)recognize{

    self.waitDealLabel.textColor = [UIColor whiteColor];
    self.waitDealLineView.hidden = NO;
    
    self.myOrderLabel.textColor = ZCXColor(242, 173, 163);
    self.myOrderLineView.hidden = YES;
    self.chargeBackLabel.textColor = ZCXColor(242, 173, 163);
    self.chargeBackLineView.hidden = YES;
}

- (void)chargeBackEvents:(UITapGestureRecognizer *)recognize{
    
    self.chargeBackLabel.textColor = [UIColor whiteColor];
    self.chargeBackLineView.hidden = NO;
    
    self.myOrderLabel.textColor = ZCXColor(242, 173, 163);
    self.myOrderLineView.hidden = YES;
    
    self.waitDealLabel.textColor = ZCXColor(242, 173, 163);
    self.waitDealLineView.hidden = YES;
}

@end
