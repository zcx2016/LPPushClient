//
//  LPPHeadScrollSingleView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/16.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPHeadScrollSingleView.h"

@implementation LPPHeadScrollSingleView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, kScreenWidth/3, 40);
}

+ (instancetype)singleViewWithFrame:(CGRect)frame {
    
    LPPHeadScrollSingleView *instance = nil;
    UINib *nib = [UINib nibWithNibName:@"LPPHeadScrollSingleView" bundle:nil];
    
    NSArray *views = [nib instantiateWithOwner:instance options:nil];
    
    if ([[views objectAtIndex:0] isKindOfClass:self]) {
        instance = [views objectAtIndex:0];
        instance.frame = frame;
    }
    return instance;
}

- (void)setSelected:(BOOL)selected {
    if (_selected != selected) {
        [self willChangeValueForKey:@"selected"];
        
        _selected = selected;
        //TODO:选中状态做些样式改变
        if (selected) {
            self.indicatorView.hidden = NO;
            self.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        } else {
            self.indicatorView.hidden = YES;
            self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        }
        
        [self didChangeValueForKey:@"selected"];
    }

}

@end
