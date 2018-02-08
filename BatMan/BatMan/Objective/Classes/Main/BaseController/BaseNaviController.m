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
 
    
    
//    隐藏返回按钮后面的文字
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
//
    

//
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//
//    UIImageView *img = [self findHairlineImageViewUnder:self.view];
//    
//    img.hidden = YES;
//    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, gScreenWidth, 0.5)];
//    line.backgroundColor = RGBA(0, 0, 0, 0.1);
//    [self.navigationBar addSubview:line];
    
    //    1，依旧保留半透明效果：也就是说tabBar和navigationBar的translucnet还是默认的YES时：
    //
    //    方法1：你可以不从（0，0）开始布局，而是从（0，64）开始布局（同理，底部的tabBar也要留下位置）
    //
    //    方法2：你一定要从（0，0）开始布局，则修改viewController的一个属性： UIRectEdgeNone
    //
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    [self.navigationBar setTranslucent:NO]; //从 navbar下面 0.0计算
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
