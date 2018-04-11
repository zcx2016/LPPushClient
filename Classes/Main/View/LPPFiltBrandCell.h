//
//  LPPFiltBrandCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPPFiltBrandCellDelegate <NSObject>
@optional
- (void)pickBrand:(NSString *)name;
@end

@interface LPPFiltBrandCell : UITableViewCell

@property (nonatomic, strong) NSArray *brandListArray;
@property (nonatomic, assign) CGFloat brandHeight;

@property (nonatomic, weak) id <LPPFiltBrandCellDelegate> delegate;
@end
