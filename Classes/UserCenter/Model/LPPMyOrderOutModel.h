//
//  LPPMyOrderOutModel.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/12.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPPMyOrderSonModel.h"

@interface LPPMyOrderOutModel : NSObject

@property (nonatomic, copy) NSString  *addTime;
@property (nonatomic, copy) NSString  *cartIds;
@property (nonatomic, copy) NSString  *order_id;
@property (nonatomic, copy) NSString  *order_num;
@property (nonatomic, copy) NSString  *order_status;
@property (nonatomic, copy) NSString  *order_total_price;


@property (nonatomic, strong) NSArray <LPPMyOrderSonModel *> *goods_infos;
@end
