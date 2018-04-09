//
//  LPPMyShippingAddressCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyShippingAddressCell.h"

@implementation LPPMyShippingAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //默认地址按钮
    [self.defaultAddressBtn addTarget:self action:@selector(defaultAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)editBtnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(isEditBtnClick:)]) {
        [self.delegate isEditBtnClick:btn];
    }
}

- (void)deleteBtnClick:(UIButton *)btn{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定要删除该地址吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:actionNo];
    
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self.delegate respondsToSelector:@selector(isDeleteBtnClick:)]) {
            [self.delegate isDeleteBtnClick:btn];
        }
    }];
    [alertVC addAction:actionYes];
    [[self viewController] presentViewController:alertVC animated:YES completion:nil];
}

- (void)defaultAddressBtnClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(isDefaultAddressBtnClick:)]) {
        [self.delegate isDefaultAddressBtnClick:btn];
    }
}

- (void)setModel:(LPPMyShippingAddressModel *)model{
    _model = model;
    
    self.nameLabel.text = model.trueName;
    self.phoneNumLabel.text = model.telephone;
    self.addressLabel.text = [model.areaAddr stringByAppendingString:model.areaInfo];
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
@end
