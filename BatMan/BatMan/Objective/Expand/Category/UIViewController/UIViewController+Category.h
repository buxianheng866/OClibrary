//
//  UIViewController+Category.h
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
@interface UIViewController (Category)
- (void) setBackBarButtonTitle:(NSString *)title;

- (void)setLeftBarButtonTitle:(NSString *)title action:(SEL)action;
- (void)setRightBarButtonTitle:(NSString *)title action:(SEL)action;
- (void)setLeftBarButtonImage:(UIImage *)image highlightImage:(UIImage *)highlightImage action:(SEL)action;
- (void)setRightBarButtonImage:(UIImage *)image highlightImage:(UIImage *)highlightImage action:(SEL)action;


- (void)restoreRootViewController:(UIViewController *)rootViewController;

/*!
 @method
 @abstract 授权相机
 */
- (void)authorizationCamera;
/*!
 @method
 @abstract 授权相册
 */

- (void)authorizationPhoto;
@end
