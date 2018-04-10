//
//  LPPCDImgIntroductCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCDImgIntroductCell.h"
#import <WebKit/WebKit.h>

@interface LPPCDImgIntroductCell ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView  *webView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LPPCDImgIntroductCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    self.scrollToTopBtn.hidden = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.webStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _textView.attributedText = attributedString;
    NSLog(@"gao---%f",_textView.contentSize.height);
//    [self setUIWebView];
//    [self setTapToTopBtn];
    
    //让table view重新计算高度
    
    [_tableView beginUpdates];
    
    [_tableView endUpdates];
}

- (UITableView*)tableView{
    
    UIView*tableView =self.superview;
    
    while(![tableView isKindOfClass:[UITableView class]] && tableView) {
        
        tableView = tableView.superview;
        
    }
    return(UITableView*)tableView;
    
}


- (void)setUIWebView{
    self.webView = [[UIWebView  alloc]init];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).with.offset(5);
        make.right.bottom.equalTo(self.contentView).with.offset(-5);
    }];
    self.webView.delegate = self;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webView.scrollView.scrollEnabled = NO;

    [self.webView sizeToFit];
    
    NSLog(@"获得---%@",self.webStr);
    [self.webView loadHTMLString:self.webStr baseURL:nil];
}

- (void)setTapToTopBtn{
    self.tapToTopBtn = [UIButton new];
    [self.contentView addSubview:self.tapToTopBtn];
    [self.tapToTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-5);
        make.bottom.equalTo(self.contentView).with.offset(-70);
        make.height.width.equalTo(@30);
    }];
    [self.tapToTopBtn setImage:[UIImage imageNamed:@"scrollToTop"] forState:UIControlStateNormal];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat scrollHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
//    CGFloat WebViewHeight = [webView.scrollView contentSize].height;
//    NSLog(@"高度---%f",scrollHeight);
//    /* 获取网页现有的frame*/
//    CGRect WebViewRect = webView.frame;
//    /* 改版WebView的高度*/
//    WebViewRect.size.height = WebViewHeight;
//    /* 重新设置网页的frame*/
//    webView.frame = WebViewRect;
    
    
    
    if ([self.delegate respondsToSelector:@selector(returnWebViewHeight:)]) {
        [self.delegate returnWebViewHeight:scrollHeight];
    }
}

@end
