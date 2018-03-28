//
//  LPPNavSearchView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPNavSearchView.h"


@implementation LPPNavSearchView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, kScreenWidth-70, 35);
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
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

#pragma mark - ios11适配
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 注意导航栏及状态栏高度适配
    self.frame = CGRectMake(10, 2, CGRectGetWidth(self.frame), 38);
    for (UIView *view in self.subviews) {
        if([NSStringFromClass([view class]) containsString:@"Background"]) {
            view.frame = self.bounds;
        }else if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
            CGRect frame = view.frame;
            frame.origin.y = 44;
            frame.size.height = self.bounds.size.height - frame.origin.y;
            view.frame = frame;
        }
    }
}

- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
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
