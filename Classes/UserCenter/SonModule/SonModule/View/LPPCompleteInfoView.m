//
//  LPPCompleteInfoView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/8.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCompleteInfoView.h"

@implementation LPPCompleteInfoView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    //设置大小
    self.frame = CGRectMake(0,  0, kScreenWidth, kScreenHeight);
    //设置组件 边角弧度
    self.uploadView.layer.cornerRadius = 10;
    self.uploadView.layer.masksToBounds = YES;
    
    self.submitBtn.layer.cornerRadius = 10;
    self.submitBtn.layer.masksToBounds = YES;
    
    //设置背景图片
    NSString *path = [[NSBundle mainBundle]pathForResource:@"info_bg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.topInfoView.layer.contents = (id)image.CGImage;
    
    NSString *path2 = [[NSBundle mainBundle]pathForResource:@"idCard_bg"ofType:@"png"];
    UIImage *image2 = [UIImage imageWithContentsOfFile:path2];
    self.uploadView.layer.contents = (id)image2.CGImage;
    
    //设置2个按钮点击事件
//    [self.idCardFrontBtn addTarget:self action:@selector(idCardFrontBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.idCardBackBtn addTarget:self action:@selector(idCardBackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)idCardFrontBtnClick:(UIButton *)btn{
//    NSLog(@"正面照");
//}
//
//- (void)idCardBackBtnClick:(UIButton *)btn{
//    NSLog(@"背面照");
//}
@end
