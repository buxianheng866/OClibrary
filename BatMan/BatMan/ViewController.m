//
//  ViewController.m
//  BatMan
//
//  Created by nb616 on 2017/9/27.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawDrawBoard];
}

- (void)drawDrawBoard {
    DrawView *dv = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, 300*layoutScale, 600*layoutScale)];
    dv.center = CGPointMake(MScreenWidth/2, MScreenHeight/2);
    [self.view addSubview:dv];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
