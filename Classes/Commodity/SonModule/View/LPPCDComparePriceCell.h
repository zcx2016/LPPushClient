//
//  LPPCDComparePriceCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPPCDComparePriceCellDelegate<NSObject>

@optional
- (void)reloadGoodsUIWithSizeId:(NSString *)sizeID;

@end

@interface LPPCDComparePriceCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArray;

@property (weak, nonatomic) IBOutlet UIView *sizeListView;

@property (nonatomic, weak) id <LPPCDComparePriceCellDelegate> delegate;

@end
