//
//  LPPLogisticsProgressCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/17.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPLogisticsProgressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *upLineView;

@property (weak, nonatomic) IBOutlet UIView *midCircleView;

@property (weak, nonatomic) IBOutlet UIView *downLineView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *transportStateLabel;


@end
