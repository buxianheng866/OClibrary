//
//  ViewController.m
//  BatMan
//
//  Created by nb616 on 2017/9/27.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import "ViewController.h"
#import "DrawController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)prsetentToVC:(id)sender {
    [self presentViewController:[DrawController new] animated:YES completion:nil];
}


@end
