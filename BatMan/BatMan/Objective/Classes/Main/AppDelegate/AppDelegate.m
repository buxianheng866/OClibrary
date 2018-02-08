//
//  AppDelegate.m
//  BatMan
//
//  Created by nb616 on 2017/9/27.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import "AppDelegate.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%@",[XCFileManager documentsDir]);
    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //     [self cleanNotNum];
}


/*
 #pragma mark Notification
 //应用在后台运行
 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
 
 //    // Required, iOS 7 Support
 //    [JPUSHService handleRemoteNotification:userInfo];
 //
 //    completionHandler(UIBackgroundFetchResultNewData);
 }
 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
 // iOS 10 以下 Required
 //    [JPUSHService handleRemoteNotification:userInfo];
 }
 
 
 - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center  willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
 // iOS 10 Support
 //    NSDictionary * userInfo = notification.request.content.userInfo;
 //    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
 //        [JPUSHService handleRemoteNotification:userInfo];
 //    }
 //    else {
 //        // 本地通知
 //    }
 //    //    [self handlePushApsDict:userInfo];
 //    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
 }
 // iOS 10 Support
 - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler: (void (^)())completionHandler {
 // Required
 //    NSDictionary * userInfo = response.notification.request.content.userInfo;
 //    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
 //        [JPUSHService handleRemoteNotification:userInfo];
 //    }
 //    else {
 //        // 本地通知
 //    }
 //    [self handlePushApsDict:userInfo];
 //    completionHandler();  // 系统要求执行这个方法
 }
 - (void)application:(UIApplication *)application
 didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
 /// Required - 注册 DeviceToken
 //    NSLog(@"deviceToken:%@",deviceToken);
 //    [JPUSHService registerDeviceToken:deviceToken];
 //    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
 //        [[NSUserDefaults standardUserDefaults]setObject:registrationID forKey:@"registrationID"];
 //        [[NSUserDefaults standardUserDefaults]synchronize];
 //    }];
 
 }
 - (void)handlePushApsDict:(NSDictionary *)userInfo {
 // 取得 APNs 标准信息内容
 NSLog(@"推送userInfo:%@",userInfo);
 [self cleanNotNum];
 
 NSString *type = userInfo[@"type"];
 NSDictionary *vc_dict = @{@"order":@"YBLOrderDetailViewController",
 @"purchase_order":@"YBLPurchaseGoodsDetailVC",
 @"follow_shop_pay":@"YBLStoreViewController",
 @"follow_shop":@"YBLStoreFollowViewController",
 @"follow_options":@"YBLStoreViewController",
 @"comment":@"YBLGoodsDetailViewController",
 @"follow_product":@"YBLGoodsDetailViewController",
 @"cart":@"YBLGoodsDetailViewController",};
 }
 - (void)cleanNotNum{
 //    [JPUSHService resetBadge];
 //    [YBLMethodTools cleanNotificationNumber];
 }
 
 #pragma mark - handle url
 - (BOOL)application:(UIApplication *)application
 openURL:(NSURL *)url
 sourceApplication:(nullable NSString *)sourceApplication
 annotation:(id)annotation{
 return [self handleURL:url];
 }
 
 //iOS 9 after
 -(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
 return [self handleURL:url];
 }
 //iOS 9 later
 - (BOOL)application:(UIApplication *)app
 openURL:(NSURL *)url
 options:(NSDictionary<NSString *,id> *)options
 {
 BOOL result = NO;
 //    BOOL result = [WXApi handleOpenURL:url delegate:self];
 if (result == NO) {
 return [self handleURL:url];
 }
 return result;
 
 }
 
 - (BOOL)handleURL:(NSURL *)url {
 
 //    NSString *host = [url host];
 //    NSString *scheme = [url scheme];
 //    NSString *absoluteString = [url absoluteString];
 //    if(!url){
 //        return NO;
 //    }
 //    if ([url.host isEqualToString:@"safepay"]) {
 //        //跳转支付宝钱包进行支付，处理支付结果
 //        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
 //            NSLog(@"result = %@",resultDic);
 //        }];
 //    }
 //    if ([WXApi handleOpenURL:url delegate:self]) {
 //        return [WXApi handleOpenURL:url delegate:self];
 //    }
 //
 return YES;
 }
 - (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler {
 NSLog(@"activityType  is %@",userActivity.activityType);
 NSLog(@"title  is %@",userActivity.title);
 NSLog(@"userInfo  is %@",userActivity.userInfo);
 NSLog(@"webpageURL  is %@",userActivity.webpageURL);
 NSLog(@"keywords  is %@",userActivity.keywords);
 if([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]){
 // 跳转 app 方式
 NSURL *webUrl = userActivity.webpageURL;
 if ([webUrl.host isEqualToString:@"kuaiyiyuncai.cn"]||[webUrl.host isEqualToString:@"www.kuaiyiyuncai.cn"]) {
 }
 }
 return YES;
 }
 */
@end

