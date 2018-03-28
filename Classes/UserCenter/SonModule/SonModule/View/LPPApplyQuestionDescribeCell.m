//
//  LPPApplyQuestionDescribeCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPApplyQuestionDescribeCell.h"

@interface LPPApplyQuestionDescribeCell()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end


@implementation LPPApplyQuestionDescribeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.questionDescribeTextView.layer.borderWidth = 1;
    self.questionDescribeTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.questionDescribeTextView.layer.cornerRadius = 3;
    self.questionDescribeTextView.layer.masksToBounds = YES;
    
    //设置textView
    self.questionDescribeTextView.delegate = self;
    self.questionDescribeTextView.returnKeyType = UIReturnKeyDone;
    
    //进入后台时取消键盘响应事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [self setPlaceHolderLabelEvents];
}

- (void)setPlaceHolderLabelEvents{
    self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 7, 200, 20)];
    self.placeHolderLabel.textAlignment = NSTextAlignmentLeft;
    self.placeHolderLabel.font = [UIFont systemFontOfSize:14];
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
    self.placeHolderLabel.text = @"请输入您要反馈的意见......";
    [self.questionDescribeTextView addSubview:self.placeHolderLabel];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0 )
    {
        self.placeHolderLabel.text = @"请输入您要反馈的意见......";
    }
    else
    {
        self.placeHolderLabel.text = @"";
    }
}

#pragma mark - 实现textView代理---收回键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//进入后台时取消键盘响应事件
- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    [self.questionDescribeTextView resignFirstResponder];
}

@end
