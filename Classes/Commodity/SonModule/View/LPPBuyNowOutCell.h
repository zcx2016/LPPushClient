//
//  LPPBuyNowOutCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/13.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPBuyNowOutCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *outView;

@property (weak, nonatomic) IBOutlet UILabel *AllCountLabel;

@property (nonatomic, strong) NSArray *dataSource;
@end
