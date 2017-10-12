//
//  GlobalManager.m
//  ProductModel
//
//  Created by nb616 on 2017/9/26.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import "GlobalManager.h"

@interface GlobalManager ()
@property (nonatomic, assign,readwrite) BOOL loginStatus;
@end
@implementation GlobalManager
+ (instancetype)share {
    static GlobalManager *gloabl;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gloabl = [[GlobalManager alloc] init];
    });
    return gloabl;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addNotification];
    }
    return self;
}
#pragma ------PublicMethod
+ (void)logIn {
    
}

+ (void)logOut {
    
}


#pragma ------PravteMethod

- (void)addNotification {
    [kNotificationCenter addObserverForName:NC_AppNetWorkStatus object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSString *obj = note.object;
        self.onNet = [obj boolValue];
    }];
}


#pragma ------setter getter


- (void)setUserInfor:(UserInformation *)userInfor {
    
}
- (UserInformation *)userInfor {
    UserInformation *infor = nil;
    return infor;
}
- (BOOL)isLoginStaus {
    return self.userInfor.userName != nil;
}

@end
