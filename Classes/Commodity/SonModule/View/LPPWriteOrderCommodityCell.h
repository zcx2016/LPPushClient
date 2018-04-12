//
//  LPPWriteOrderCommodityCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPWriteOrderCommodityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *outView;

@property (weak, nonatomic) IBOutlet UILabel *AllCountLabel;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) BOOL  flag;  // 控制标签
@property (nonatomic, assign) NSInteger count; // 控件个数

@end
