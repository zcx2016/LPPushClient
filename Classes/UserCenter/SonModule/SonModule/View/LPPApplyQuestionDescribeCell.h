//
//  LPPApplyQuestionDescribeCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPApplyQuestionDescribeCell : UITableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *questionDescribeTextView;

@property (weak, nonatomic) IBOutlet UIButton *takePhotoBtn;

@end
