//
//  LPPWriteOrderAddressModel.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/27.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPPWriteOrderAddressModel : NSObject

@property (nonatomic, copy) NSString  *addr_id;
@property (nonatomic, copy) NSString  *areaAddr;
@property (nonatomic, copy) NSString  *areaInfo;
@property (nonatomic, copy) NSString  *telephone;
@property (nonatomic, copy) NSString  *trueName;

@property (nonatomic, assign) NSInteger verify;

@end
