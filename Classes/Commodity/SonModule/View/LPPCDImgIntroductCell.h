//
//  LPPCDImgIntroductCell.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPPCDImgIntroductCellDelegate<NSObject>
@optional
- (void)returnWebViewHeight:(CGFloat)webHeight;
@end

@interface LPPCDImgIntroductCell : UITableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *scrollToTopBtn;

@property (nonatomic, copy) NSString  *webStr;

@property (nonatomic, strong) UIButton *tapToTopBtn;

@property (nonatomic, weak) id <LPPCDImgIntroductCellDelegate> delegate;

@end
