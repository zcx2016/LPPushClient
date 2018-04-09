//
//  LPPActivityHeadView.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPActivityHeadModel.h"

@interface LPPActivityHeadView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) LPPActivityHeadModel *headModel;

@end
