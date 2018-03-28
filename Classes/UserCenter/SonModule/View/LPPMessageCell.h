//
//  LPPMessageCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *outView;

@property (weak, nonatomic) IBOutlet UIImageView *tagImgView;

@property (weak, nonatomic) IBOutlet UILabel *msgTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *msgDetailLabel;
@end
