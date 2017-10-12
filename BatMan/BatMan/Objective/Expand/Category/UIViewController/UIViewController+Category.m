//
//  UIViewController+Category.m
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)
- (void) setBackBarButtonTitle:(NSString *)title{
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:nil];
}

- (void) setLeftBarButtonTitle:(NSString *)title action:(SEL)action{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
}
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


- (void)deleteNavibarUnderline {
   
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
    {
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list)
        {
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }else
            {
                if ([obj isKindOfClass:[UIImageView class]])
                {
                    
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2)
                    {
                        if ([obj2 isKindOfClass:[UIImageView class]])
                        {
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=YES;
                        }
                    }
                }
            }
        }
    }
}
- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar {
   
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.size.height -= 20;
    if (hasNav) {
        frame.size.height -= 44;
    }
    if (hasTabBar) {
        frame.size.height -= 48;
    }
    
    return frame;
}


@end
