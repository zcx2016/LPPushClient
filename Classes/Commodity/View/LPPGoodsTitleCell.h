//
//  LPPGoodsTitleCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/11.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPGoodsTitleModel.h"

@interface LPPGoodsTitleCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@property (nonatomic, strong) LPPGoodsTitleModel *model;

@end
