//
//  AppHelper.h
//  ProductModel
//
//  Created by nb616 on 2017/9/26.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AppHelper : NSObject
+ (void)finishLaunchOption:(NSDictionary *)launchOptions;
+ (UINavigationController *)getCurrentNavigation;
@end
