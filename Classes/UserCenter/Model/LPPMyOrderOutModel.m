//
//  LPPMyOrderOutModel.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/12.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyOrderOutModel.h"

@implementation LPPMyOrderOutModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goods_infos" : @"LPPMyOrderSonModel" };
}

- (id)copyWithZone:(NSZone *)zone {
    
    return [self yy_modelCopy];
}

@end
