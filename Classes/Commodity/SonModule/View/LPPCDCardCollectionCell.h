//
//  LPPCDCardCollectionCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPColorListModel.h"

@interface LPPCDCardCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;

@property (nonatomic, strong) LPPColorListModel *colorListModel;

@end
