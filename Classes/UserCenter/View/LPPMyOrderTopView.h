//
//  LPPMyOrderTopView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPPMyOrderTopViewDelegate<NSObject>

@optional
- (void)fourBtnClick:(UIButton *)btn;

@end

@interface LPPMyOrderTopView : UIView<UITextFieldDelegate>

@property (nonatomic, assign) NSInteger tag;

@property (weak, nonatomic) IBOutlet UIView *upOutView;

@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIView *allLineView;

@property (weak, nonatomic) IBOutlet UIButton *waitPayBtn;
@property (weak, nonatomic) IBOutlet UIView *waitPayLineView;

@property (weak, nonatomic) IBOutlet UIButton *waitShipBtn;
@property (weak, nonatomic) IBOutlet UIView *waitShipLineView;

@property (weak, nonatomic) IBOutlet UIButton *waitReceiveBtn;
@property (weak, nonatomic) IBOutlet UIView *waitReceiveLineView;

@property (weak, nonatomic) IBOutlet UIView *downOutView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UIView *uselessLineView;

@property (nonatomic, weak) id <LPPMyOrderTopViewDelegate> stateSelectedDelegate;
@end
