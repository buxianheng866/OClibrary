//
//  DrawController.m
//  BatMan
//
//  Created by nb616 on 2018/2/8.
//  Copyright © 2018年 nb616. All rights reserved.
//

#import "DrawController.h"
#import "DrawView.h"
@interface DrawController ()
@property (nonatomic, strong) DrawView *dw;
@end

@implementation DrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(selectaction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    [self drawDrawBoard];
}
- (void)selectaction {
    [_dw savePage];
}
- (void)drawDrawBoard {
    DrawView *dv = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, 300*layoutScale, 600*layoutScale)];
    dv.center = CGPointMake(MScreenWidth/2, MScreenHeight/2);
    self.dw = dv;
    [self.view addSubview:dv];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
