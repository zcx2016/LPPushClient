//
//  LPPMyOrderVC.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPMyOrderTopView.h"

@interface LPPMyOrderVC : UIViewController

@property (nonatomic, strong) LPPMyOrderTopView *topView;

@property (nonatomic, copy) NSString  *btnName;
@end
