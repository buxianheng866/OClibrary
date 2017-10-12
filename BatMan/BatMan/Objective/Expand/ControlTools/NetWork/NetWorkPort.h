//
//  NetWorkPort.h
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#include <sys/stat.h>
#import <CommonCrypto/CommonDigest.h>
typedef NS_ENUM(NSInteger,APIEnum)
{
    API_LOGIN = 0,
    API_LOGIN_SMS
};

@interface NetWorkPort : NSObject
- (BOOL)appNetWorkStatue;
@end
