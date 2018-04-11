//
//  LPPRecommendFooterView.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/19.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPRecommendFooterView.h"

@implementation LPPRecommendFooterView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@synthesize count = _count;
- (void)setCount:(NSInteger )count{
    if (count> 0 && _flag == NO) {
        _flag = YES;
        for (int i = 0; i < count; i++) {
            self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 180*i, kScreenWidth, 180)];
            self.imgView.userInteractionEnabled = YES;
            self.imgView.tag = i;
            NSURL *imageUrl = [NSURL URLWithString:self.modelArr[i].classNamePhoto];
            [self.imgView sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
            [self.imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgViewEvents:)]];
            [self addSubview:self.imgView];
        }
    }
}

- (void)tapImgViewEvents:(UITapGestureRecognizer *)recognizer{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)recognizer;
    NSInteger tag = tap.view.tag;
    //后面把tapId传出去 ，跳到指定界面
    NSString *tapId = self.modelArr[tag].id;
    NSLog(@"tapId---%@",tapId);
}

@end
