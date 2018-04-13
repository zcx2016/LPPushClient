//
//  LPPCommodityDetailBottomView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/7.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCommodityDetailBottomView.h"
#import "LPPShopCarVC.h"
#import "ZCXActionSheetView.h"

@implementation LPPCommodityDetailBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.frame =CGRectMake(0, 0, kScreenWidth, 50);
    //给2个uiview添加点击事件
    self.shareViewBtn.userInteractionEnabled = YES;
    [self.shareViewBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareEvent:)]];
    
    self.shoppingCarViewBtn.userInteractionEnabled = YES;
    [self.shoppingCarViewBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shoppingCarEvent:)]];
}

//分享
- (void)shareEvent:(UITapGestureRecognizer *)gesture{
    ZCXActionSheetView *sheet = [[ZCXActionSheetView alloc] initWithActionSheet];
    //放在最上层
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:sheet];
}

//购物车
- (void)shoppingCarEvent:(UITapGestureRecognizer *)gesture{
    NSLog(@"购物车");
    LPPShopCarVC *vc = [LPPShopCarVC new];
    vc.isFromCommodityDetailVc = YES;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}


//获取控制器
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
