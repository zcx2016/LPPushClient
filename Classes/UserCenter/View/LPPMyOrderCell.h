//
//  LPPMyOrderCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPMyOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *outView;

@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;

@property (nonatomic, assign) BOOL  flag;  // 控制标签
@property (nonatomic, assign) NSInteger count; // 控件个数

@end
