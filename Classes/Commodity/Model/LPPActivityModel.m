//
//  LPPActivityModel.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/9.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPActivityModel.h"

@implementation LPPActivityModel

- (id)copyWithZone:(NSZone *)zone {
    
    return [self yy_modelCopy];
}

@end
