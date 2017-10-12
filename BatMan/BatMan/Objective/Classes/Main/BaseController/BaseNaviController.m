//
//  BaseNaviController.m
//  ProductModel
//
//  Created by nb616 on 2017/9/26.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import "BaseNaviController.h"

@interface BaseNaviController ()<UIGestureRecognizerDelegate>
@property (strong , nonatomic) UIButton *backBut;
@end

@implementation BaseNaviController

+ (void)initialize {
    UINavigationBar *naviBar = [UINavigationBar appearance];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    [naviBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBAColor(40, 40, 40, 1),NSFontAttributeName : Text_Font(17), NSShadowAttributeName : shadow}];
    [naviBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:(UIBarMetricsDefault)];
    [naviBar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    [self.navigationBar setTranslucent:NO];
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16],NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
}
- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        
        if (navigationController.childViewControllers.count == 1) {
            
            self.interactivePopGestureRecognizer.enabled = NO;
            
        }else
            self.interactivePopGestureRecognizer.enabled = self.isPopGestureRecognizerEnable;
    }
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBut];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -20;
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer,leftItem];
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:YES];
}

- (UIButton *)backBut
{
    if (!_backBut) {
        _backBut = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backBut.frame = CGRectMake(0, 0, 30, 44);
        [_backBut addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_backBut setImage:Navi_backImage forState:(UIControlStateNormal)];
    }
    return _backBut;
}
- (void)backBtnAction
{
    [self popViewControllerAnimated:YES];
}
@end
