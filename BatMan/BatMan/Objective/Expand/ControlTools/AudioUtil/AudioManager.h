//
//  AudioManager.h
//  Objective
//
//  Created by Bruce on 2017/7/5.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AudioManagerproximitySensorDelegate <NSObject>

/*
 @method
 @brief 当手机靠近耳朵时或者离开耳朵时的回调方法
 @param isCloseToUser YES为靠近了用户, NO为远离了用户
 
 */
- (void)proximitySensorChanged:(BOOL)isCloseToUser;

@end
@interface AudioManager : NSObject

{
    NSDate              *_recorderStartDate;
    NSDate              *_recorderEndDate;
    
    BOOL _isSupportProximitySensor;
    BOOL _isCloseToUser;
    
    NSString            *_currCategory;
    BOOL                _currActive;
}
- (int)currentRecordTime;
@property (weak , nonatomic) id <AudioManagerproximitySensorDelegate> delegate;
+(instancetype)sharedInstance;
@end
