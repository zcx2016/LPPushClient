//
//  LPPCDCommodityStyleCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPPCDCommodityStyleCellDelegate<NSObject>

@optional
- (void)reloadGoodsUIWithColorId:(NSString *)colorID;

@end

@interface LPPCDCommodityStyleCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) id <LPPCDCommodityStyleCellDelegate> delegate;
@end
