//
//  LPPActivityHeadModel.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPPActivityModel.h"

@interface LPPActivityHeadModel : NSObject

@property (nonatomic, copy) NSString  *secondId;
@property (nonatomic, copy) NSString  *secondName;
@property (nonatomic, strong) NSArray <LPPActivityModel *> *secondList;
@end
