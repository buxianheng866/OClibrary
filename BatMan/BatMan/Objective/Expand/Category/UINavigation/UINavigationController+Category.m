//
//  UINavigationController+Category.m
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import "UINavigationController+Category.h"
static const char * PopGestureRecognizerKey = "PopGestureRecognizerKey";
@implementation UINavigationController (Category)
- (BOOL)isPopGestureRecognizerEnable {
    return [objc_getAssociatedObject(self, PopGestureRecognizerKey) boolValue];
}
- (void)setIsPopGestureRecognizerEnable:(BOOL)isPopGestureRecognizerEnable {
    objc_setAssociatedObject(self, PopGestureRecognizerKey, [NSNumber numberWithBool:isPopGestureRecognizerEnable], OBJC_ASSOCIATION_ASSIGN);
}
- (id)findViewController:(NSString*)className
{
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    
    return nil;
}
/**
 *  @brief  判断是否只有一个RootViewController
 *
 *  @return 是否只有一个RootViewController
 */
- (BOOL)isOnlyContainRootViewController
{
    if (self.viewControllers &&
        self.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

- (UIViewController *)rootViewController
{
    if (self.viewControllers && [self.viewControllers count] >0) {
        return [self.viewControllers firstObject];
    }
    return nil;
}

- (NSArray *)popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;
{
    return [self popToViewController:[self findViewController:className] animated:YES];
}

- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated
{
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}

@end
