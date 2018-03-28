//
//  LPPWriteOrderAddressCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPWriteOrderAddressCell.h"
#import "LPPMyShippingAddressVC.h"

@implementation LPPWriteOrderAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    self.outView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.outView.layer.borderWidth = 1;
    self.outView.layer.cornerRadius = 5;
    self.outView.layer.masksToBounds = YES;
    
    
    [self.outView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)]];
}

- (void)tapCell:(UITapGestureRecognizer *)recognizer{
    LPPMyShippingAddressVC *vc = [LPPMyShippingAddressVC new];
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

//获取控制器
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setModel:(LPPWriteOrderAddressModel *)model{
    _model = model;
    
    self.receiverLabel.text = model.trueName;
    self.phoneNumLabel.text = model.telephone;
    self.addressLabel.text = [model.areaAddr stringByAppendingString:model.areaInfo];
}

@end
