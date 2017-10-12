//
//  UIViewController+Category.h
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Category)
- (void) setBackBarButtonTitle:(NSString *)title;



- (void)setLeftBarButtonTitle:(NSString *)title action:(SEL)action;
- (void)setRightBarButtonTitle:(NSString *)title action:(SEL)action;
- (void)setLeftBarButtonImage:(UIImage *)image highlightImage:(UIImage *)highlightImage action:(SEL)action;
- (void)setRightBarButtonImage:(UIImage *)image highlightImage:(UIImage *)highlightImage action:(SEL)action;

- (void)deleteNavibarUnderline;  //删除黑线

- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar;


@end
