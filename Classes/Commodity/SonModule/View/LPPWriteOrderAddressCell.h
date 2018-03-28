//
//  LPPWriteOrderAddressCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPWriteOrderAddressModel.h"

@interface LPPWriteOrderAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *outView;

@property (weak, nonatomic) IBOutlet UILabel *receiverLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic, strong) LPPWriteOrderAddressModel *model;
@end
