//
//  LPPFiltCategoryCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPPFiltCategoryCellDelegate <NSObject>
@optional
- (void)pickCategory:(NSString *)name;
@end

@interface LPPFiltCategoryCell : UITableViewCell

@property (nonatomic, strong) NSArray *classListArray;
@property (nonatomic, assign) CGFloat classHeight;

@property (nonatomic, weak) id<LPPFiltCategoryCellDelegate> delegate;
@end
