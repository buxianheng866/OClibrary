//
//  UIScrollView+Category.h
//  Objective
//
//  Created by nb616 on 2017/9/5.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Category)
// contentInset
@property (assign, nonatomic) CGFloat insetT;
@property (assign, nonatomic) CGFloat insetB;
@property (assign, nonatomic) CGFloat insetL;
@property (assign, nonatomic) CGFloat insetR;

// contentOffset
@property (assign, nonatomic) CGFloat offsetX;
@property (assign, nonatomic) CGFloat offsetY;

// contentSize
@property (assign, nonatomic) CGFloat contentW;
@property (assign, nonatomic) CGFloat contentH;
@end
