//
//  LPPSizeCollectionCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/10.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPSizeListModel.h"

@interface LPPSizeCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@property (nonatomic, strong) LPPSizeListModel *model;
@end
