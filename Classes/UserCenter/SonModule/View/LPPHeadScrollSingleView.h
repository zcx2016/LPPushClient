//
//  LPPHeadScrollSingleView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/16.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPHeadScrollSingleView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@property (assign, nonatomic, getter=isSelecting) BOOL selected;

+ (instancetype)singleViewWithFrame:(CGRect)frame;
@end
