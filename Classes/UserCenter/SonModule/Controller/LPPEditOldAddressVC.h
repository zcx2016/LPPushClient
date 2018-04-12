//
//  LPPEditOldAddressVC.h
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LPPEditOldAddressVC : UIViewController

//收货地址列表
@property (nonatomic, copy) NSString  *addr_id;
@property (nonatomic, copy) NSString  *areaAddr;
@property (nonatomic, copy) NSString  *areaInfo;
@property (nonatomic, copy) NSString  *telephone;
@property (nonatomic, copy) NSString  *trueName;

@property (nonatomic, copy) NSString  *defaultNum;

@property (nonatomic, copy) NSString  *idcardfond;
@property (nonatomic, copy) NSString  *idcardback;

@end
