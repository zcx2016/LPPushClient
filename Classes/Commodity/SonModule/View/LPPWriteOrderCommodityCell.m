//
//  LPPWriteOrderCommodityCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPWriteOrderCommodityCell.h"
#import "LPPWriteOrderCommoditySubView.h"

@implementation LPPWriteOrderCommodityCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    self.outView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.outView.layer.borderWidth = 1;
    self.outView.layer.cornerRadius = 5;
    self.outView.layer.masksToBounds = YES;
}

@synthesize count = _count;
- (void)setCount:(NSInteger )count{
    if (count> 0 && _flag == NO) {
        _flag = YES;
        for (int i = 0; i < count; i++) {
            LPPWriteOrderCommoditySubView *orderView = [[NSBundle mainBundle] loadNibNamed:@"LPPWriteOrderCommoditySubView" owner:nil options:nil].lastObject;
            orderView.lineView.hidden = NO;
            orderView.frame = CGRectMake(0, 30 +140 *i, kScreenWidth- 50, 10);
            if (i == count - 1) {
                orderView.lineView.hidden = YES;
            }
            [self.outView addSubview:orderView];
        }
        
    }
}


@end
