//
//  LPPFilterFirstCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/20.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPPFilterFirstCellDelegate<NSObject>
@optional
- (void)pickUpOrDown:(NSInteger)num;

@end

@interface LPPFilterFirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;

@property (nonatomic, weak) id <LPPFilterFirstCellDelegate> delegate;

@end
