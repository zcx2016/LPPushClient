//
//  LPPRecommendFooterView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPFooterViewModel.h"

@interface LPPRecommendFooterView : UITableViewHeaderFooterView

@property (nonatomic, assign) BOOL  flag;  // 控制标签
@property (nonatomic, assign) NSInteger count; // 控件个数

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) NSArray <LPPFooterViewModel *>*modelArr;
@end
