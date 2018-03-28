//
//  LPPAddressTFCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/16.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPAddressTFCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UITextField *detailTextField;

@property (weak, nonatomic) IBOutlet UIButton *rightArrowBtn;

@end
