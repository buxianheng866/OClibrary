//
//  GlobalManager.h
//  ProductModel
//
//  Created by nb616 on 2017/9/26.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInformation.h"
@interface GlobalManager : NSObject
+ (instancetype)share;

/** 是否登录*/
@property (nonatomic, assign, getter=isLoginStaus, readonly) BOOL loginStatus;
/** 是否有网络*/
@property (nonatomic, assign, getter=isOnNet) BOOL onNet;
/** 用户信息*/
@property (nonatomic, strong) UserInformation *userInfor;

/** 登陆*/
+ (void)logIn;
/** 注销*/
+ (void)logOut;
@end
