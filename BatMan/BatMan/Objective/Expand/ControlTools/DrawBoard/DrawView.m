//
//  DrawView.m
//  DrawSvg
//
//  Created by nb616 on 2018/2/5.
//  Copyright © 2018年 nb616. All rights reserved.
//

#import "DrawView.h"


CGPoint midPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x)/2, (p1.y + p2.y)/2);
}
static CGFloat lineW = 1;

@interface DrawView ()
{
    UIColor *lineColor;
    CGPoint pt1;
    CGPoint pt2;
    CGPoint mid;
    CGContextRef _context;
}

@property (nonatomic, strong) UIImageView *borad;
@end
@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        lineColor = [UIColor greenColor];
        self.backgroundColor = [UIColor whiteColor];
        self.borad = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.borad.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.borad];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)panGesture:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            
            pt1 = point;
            pt2 = point;
            mid = point;
            
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1);
            [self.borad drawRect:self.bounds];
            _context = UIGraphicsGetCurrentContext();
            CGContextSetAllowsAntialiasing(_context, YES);
            CGContextSetLineCap(_context, kCGLineCapRound);
            CGContextSetLineJoin(_context, kCGLineJoinRound);
            CGContextSetLineWidth(_context, lineW);
            CGContextSetStrokeColorWithColor(_context, lineColor.CGColor);
            CGContextSetShouldAntialias(_context, YES);
            CGContextBeginPath(_context);
            
            break;
        case UIGestureRecognizerStateChanged:
            
            pt1 = pt2;
            pt2 = mid;
            mid = point;
            CGPoint m1 = midPoint(pt1, pt2);
            CGPoint m2 = midPoint(pt2, mid);
            CGContextMoveToPoint(_context, m1.x, m1.y);
            CGContextAddQuadCurveToPoint(_context, pt2.x, pt2.y, m2.x, m2.y);
            CGContextStrokePath(_context);
            
            self.borad.image = UIGraphicsGetImageFromCurrentImageContext();
            break;
        case UIGestureRecognizerStateRecognized:
            UIGraphicsEndImageContext();
            
            break;
        default:
            break;
    }
    
    
    
}

@end
