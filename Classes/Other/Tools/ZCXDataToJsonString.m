//
//  ZCXDataToJsonString.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/4/12.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "ZCXDataToJsonString.h"

@implementation ZCXDataToJsonString

+ (NSString*)DataToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
