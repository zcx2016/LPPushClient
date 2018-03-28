//
//  LPPShopCarModel.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/28.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPPShopCarModel : NSObject

@property (nonatomic, copy) NSString  *cart_id;
@property (nonatomic, copy) NSString  *cart_price;
@property (nonatomic, copy) NSString  *goods_count;
@property (nonatomic, copy) NSString  *goods_id;
@property (nonatomic, copy) NSString  *goods_main_photo;
@property (nonatomic, copy) NSString  *goods_name;
@property (nonatomic, copy) NSString  *goods_price;
@property (nonatomic, copy) NSString  *goods_status;

@end
