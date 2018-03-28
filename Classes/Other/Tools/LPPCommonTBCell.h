//
//  LPPCommonTBCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/21.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPCommonTBCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *diyTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *diyDetailLabel;

@property (weak, nonatomic) IBOutlet UIButton *diyIndicatorBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *diyDetailLabelTrailingConstraint;

@end
