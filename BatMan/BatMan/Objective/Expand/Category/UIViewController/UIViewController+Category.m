//
//  UIViewController+Category.m
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

- (void) setRightBarButtonTitle:(NSString *)title action:(SEL)action{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont boldSystemFontOfSize:16], NSFontAttributeName,
                                         [UIColor whiteColor], NSForegroundColorAttributeName,
                                         nil]
                               forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =rightButton;
}

- (void)setLeftBarButtonImage:(UIImage *)image highlightImage:(UIImage *)highlightImage action:(SEL)action{
  
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImage:highlightImage forState:UIControlStateHighlighted];
    [leftButton setFrame:CGRectMake(0, 0, 48, 48)];
    [leftButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -16;
    self.navigationItem.leftBarButtonItems  = @[negativeSpacer, leftItem];
}

- (void)setRightBarButtonImage:(UIImage *)image highlightImage:(UIImage *)highlightImage action:(SEL)action{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton setImage:highlightImage forState:UIControlStateHighlighted];
    [rightButton setFrame:CGRectMake(0, 0, 44, 44)];
    [rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -16;
   
    self.navigationItem.rightBarButtonItems  = @[negativeSpacer, rightItem];
}




- (void)restoreRootViewController:(UIViewController *)rootViewController {
    //    UIModalTransitionStyleCoverVertical 底部滑入
    //    UIModalTransitionStyleFlipHorizontal 水平翻转进入
    //    UIModalTransitionStyleCrossDissolve 交叉溶解
    //    UIModalTransitionStylePartialCurl 翻页
    //
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [UIView transitionWithView:kKeyWindow duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        kKeyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    } completion:nil];
}

- (void)authorizationPhoto {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
           
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
               
            });
            
        }
    }];
}

- (void)authorizationCamera {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (!granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
               
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
           
            });
        }
    }];
}

@end
