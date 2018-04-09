//
//  LPPFirstCollectionCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPFirstCellModel.h"

@interface LPPFirstCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (nonatomic, strong) LPPFirstCellModel *model;

@end
