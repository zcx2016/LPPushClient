//
//  LPPShopCarCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPShopCarCell.h"

@interface LPPShopCarCell()

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIView *smsContentView;
@end

@implementation LPPShopCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.outView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.outView.layer.borderWidth = 1;
    self.outView.layer.cornerRadius = 5;
    self.outView.layer.masksToBounds = YES;
    
    //设置 加减 view
    self.changeCountView.layer.cornerRadius = 14;
    self.changeCountView.layer.masksToBounds = YES;
    self.changeCountView.layer.borderWidth = 1;
    self.changeCountView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.reduceBtn addTarget:self action:@selector(reduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //选择按钮
    [self.selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedAll:) name:@"shopCarSelectAll" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disSelectedAll:) name:@"shopCarDisSelectAll" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startEditCountNoti:) name:@"startEditCount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopEditCountNoti:) name:@"stopEditCount" object:nil];
    //进来时，数量加减框不显示
    self.changeCountView.hidden = YES;
}

- (void)startEditCountNoti:(NSNotification *)noti{
    self.changeCountView.hidden = NO;
}

- (void)stopEditCountNoti:(NSNotification *)noti{
    self.changeCountView.hidden = YES;
}

- (void)selectedAll:(NSNotification *)noti{
    //这样不行，有问题
    [self.selectedBtn setImage:[UIImage imageNamed:@"shopCarSelect"] forState:UIControlStateNormal];
}

- (void)disSelectedAll:(NSNotification *)noti{
    //这样不行，有问题
    [self.selectedBtn setImage:[UIImage imageNamed:@"shopCarDisSelect"] forState:UIControlStateNormal];
}

- (void)selectedBtnClick:(UIButton *)btn{
    if (!btn.selected) {
        [btn setImage:[UIImage imageNamed:@"shopCarSelect"] forState:UIControlStateNormal];
        btn.selected = !btn.selected;
        if ([self.delegate respondsToSelector:@selector(selectGoods:Type:)]) {
            [self.delegate selectGoods:btn Type:1];
        }
    }else{
        [btn setImage:[UIImage imageNamed:@"shopCarDisSelect"] forState:UIControlStateNormal];
        btn.selected = !btn.selected;
        if ([self.delegate respondsToSelector:@selector(selectGoods:Type:)]) {
            [self.delegate selectGoods:btn Type:0];
        }
    }
}

#pragma mark - 按钮点击事件
- (void)addBtnClick:(UIButton *)btn{
    NSInteger a = [self.changeCountLabel.text integerValue];
    a++;
    self.changeCountLabel.text = [NSString stringWithFormat:@"%ld",(long)a];
    if ([self.delegate respondsToSelector:@selector(adjustGoodsNum:Count:)]) {
        [self.delegate adjustGoodsNum:btn Count:a];
    }
}

- (void)reduceBtnClick:(UIButton *)btn{
    NSInteger a = [self.changeCountLabel.text integerValue];
    if (a>1) {
        a--;
        self.changeCountLabel.text = [NSString stringWithFormat:@"%ld",(long)a];
        if ([self.delegate respondsToSelector:@selector(adjustGoodsNum:Count:)]) {
            [self.delegate adjustGoodsNum:btn Count:a];
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 去掉隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self setupSlideBtn];
    [CATransaction commit];
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(1, 1, 50, 50)];
        [_deleteBtn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self.smsContentView addSubview:_deleteBtn];
    }
    return _deleteBtn;
}

// 设置左滑菜单按钮的样式
- (void)setupSlideBtn
{
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            
            UIView *smsContentView = subView.subviews[0];
            smsContentView.backgroundColor = ZCXColor(239, 92, 82);
            
            if (self.deleteBtn) {
                [self.deleteBtn removeFromSuperview];
            }
            self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 50, 50)];
            [self.deleteBtn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
            [self.deleteBtn addTarget:self action:@selector(deleteEvents:) forControlEvents:UIControlEventTouchUpInside];
            [smsContentView addSubview:self.deleteBtn];
        }
    }
}

- (void)deleteEvents:(UIButton *)btn{
    NSLog(@"删除!!!");
    if ([self.delegate respondsToSelector:@selector(deleteOneCell:)]) {
        [self.delegate deleteOneCell:btn];
    }
}

- (void)setModel:(LPPShopCarModel *)model{
    _model = model;
    
    _commodityNameLabel.text = model.goods_name;
    _priceLabel.text = model.goods_price;
    if (model.goods_count.length != 0) {
        _countLabel.text = [@"数量x" stringByAppendingString:model.goods_count];
    }
    NSURL *imageUrl = [NSURL URLWithString:model.goods_main_photo];
    [self.commodityImage sd_setImageWithURL:imageUrl placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
}
@end
