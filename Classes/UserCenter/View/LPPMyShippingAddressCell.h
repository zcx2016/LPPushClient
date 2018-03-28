//
//  LPPMyShippingAddressCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPMyShippingAddressModel.h"

@protocol LPPMyShippingAddressCellDelegate <NSObject>

@optional
- (void)isEditBtnClick:(UIButton *)btn;
- (void)isDeleteBtnClick:(UIButton *)btn;
- (void)isDefaultAddressBtnClick:(UIButton *)btn;

@end

@interface LPPMyShippingAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIButton *defaultAddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic, weak) id <LPPMyShippingAddressCellDelegate> delegate;

@property (nonatomic, strong) LPPMyShippingAddressModel *model;
@end
