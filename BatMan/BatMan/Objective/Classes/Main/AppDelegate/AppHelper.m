//
//  AppHelper.m
//  ProductModel
//
//  Created by nb616 on 2017/9/26.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import "AppHelper.h"
@implementation AppHelper
+ (void)finishLaunchOption:(NSDictionary *)launchOptions {
    [self checkNetWorkStatus];
}

+ (void)checkNetWorkStatus {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络不可达");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"GPRS网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi网络");
                break;
            default:
                break;
        }
        NSString *isNetWork = @"0";
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi){
            isNetWork = @"1";
            [GlobalManager share].onNet = YES;
        } else {
            isNetWork = @"0";
            [GlobalManager share].onNet = NO;
        }
        [kNotificationCenter postNotificationName:NC_AppNetWorkStatus object:isNetWork];
    }];
}

 

+ (UINavigationController *)getCurrentNavigation {
    BaseTabController *tb = (BaseTabController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    return (UINavigationController *)(tb.viewControllers[tb.selectedIndex]);
}
 
@end
