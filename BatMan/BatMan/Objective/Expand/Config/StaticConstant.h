//
//  StaticConstant.h
//  BatMan
//
//  Created by nb616 on 2017/9/27.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UserType) {
    UserTypeGuest = 0,
    UserTypeWeXin
};


#pragma ------通知类
UIKIT_EXTERN NSString *const NC_AppNetWorkStatus;



#pragma ------NSUserDefatult类
UIKIT_EXTERN NSString *const UD_UserInformation;





#pragma ------自定义类
UIKIT_EXTERN CGFloat const CM_TitleHeight;
