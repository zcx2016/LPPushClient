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
    
    self.backgroundColor = [UIColor blueColor];
    self.frame =CGRectMake(0, 0, kScreenWidth, 50);
    //给2个uiview添加点击事件
    self.shareViewBtn.userInteractionEnabled = YES;
    [self.shareViewBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareEvent:)]];
    
    self.shoppingCarViewBtn.userInteractionEnabled = YES;
    [self.shoppingCarViewBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shoppingCarEvent:)]];
    
    //给2个button添加点击事件
    [self.joinInShopCarBtn addTarget:self action:@selector(joinInShopCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buyNowBtn addTarget:self action:@selector(buyNowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

//加入购物车
- (void)joinInShopCarBtnClick:(UIButton *)btn{
    NSLog(@"加入购物车");
    [self addInShopCar];
}

- (void)addInShopCar{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSDictionary *dict = @{@"user_id" : user_id , @"token" : token ,@"count":@"1", @"goods_id" :@"000",@"gsp":@"000"};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/add_goods_new_cart.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-responseObject---%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

//立即购买
- (void)buyNowBtnClick:(UIButton *)btn{
    NSLog(@"立即购买");
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
