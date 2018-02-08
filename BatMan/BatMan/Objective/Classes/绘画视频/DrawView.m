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
    
    DDXMLDocument *document;
    DDXMLElement *rootElement;
    
    NSString *NoteKey;
}

@property (nonatomic, strong) UIImageView *borad;
@end
@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        int x = arc4random()%999;
        NoteKey = [NSString stringWithFormat:@"%dM%d%dL",x,x,x];
        lineColor = [UIColor greenColor];
        self.backgroundColor = [UIColor whiteColor];
        self.borad = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.borad.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.borad];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:pan];
        
        [self getXMLSvg];
    }
    return self;
}

- (void)panGesture:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            
        {
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
            
//            DDXMLElement *lineEle = [DDXMLElement elementWithName:@"line"];
//            [lineEle addAttributeWithName:@"x1" stringValue:[self getstringValue:pt1.x]];
//            [lineEle addAttributeWithName:@"y1" stringValue:[self getstringValue:pt1.y]];
//            [lineEle addAttributeWithName:@"x2" stringValue:[self getstringValue:mid.x]];
//            [lineEle addAttributeWithName:@"y2" stringValue:[self getstringValue:mid.y]];
//            [lineEle addAttributeWithName:@"stroke-width" stringValue:[NSString stringWithFormat:@"%f",lineW]];
//
//            [rootElement addChild:lineEle];
//            [rootElement addChild:[DDXMLNode textWithStringValue:@"\n"]];
        }
            
            break;
        case UIGestureRecognizerStateChanged:
            
        {
            pt1 = pt2;
            pt2 = mid;
            mid = point;
            CGPoint m1 = midPoint(pt1, pt2);
            CGPoint m2 = midPoint(pt2, mid);
            CGContextMoveToPoint(_context, m1.x, m1.y);
            CGContextAddQuadCurveToPoint(_context, pt2.x, pt2.y, m2.x, m2.y);
            CGContextStrokePath(_context);
            self.borad.image = UIGraphicsGetImageFromCurrentImageContext();
            
            DDXMLElement *pathEle = [DDXMLElement elementWithName:@"path"];
            [pathEle addAttributeWithName:@"d" stringValue:[NSString stringWithFormat:@"M%@ %@ Q%@ %@ %@ %@",[self getstringValue:m1.x],[self getstringValue:m1.y],[self getstringValue:pt2.x],[self getstringValue:pt2.y],[self getstringValue:m2.x],[self getstringValue:m2.y]]];
            [pathEle addAttributeWithName:@"fill" stringValue:@"none"];
            [pathEle addAttributeWithName:@"stroke-width" stringValue:[NSString stringWithFormat:@"%f",lineW]];
            [rootElement addChild:pathEle];
            [rootElement addChild:[DDXMLNode textWithStringValue:@"\n"]];
        }
            break;
        case UIGestureRecognizerStateRecognized:
        {
            pt1 = pt2;
            pt2 = mid;
            mid = point;
            
            UIGraphicsEndImageContext();
//            DDXMLElement *lineEle = [DDXMLElement elementWithName:@"line"];
//            [lineEle addAttributeWithName:@"x1" stringValue:[self getstringValue:pt1.x]];
//            [lineEle addAttributeWithName:@"y1" stringValue:[self getstringValue:pt1.y]];
//            [lineEle addAttributeWithName:@"x2" stringValue:[self getstringValue:mid.x]];
//            [lineEle addAttributeWithName:@"y2" stringValue:[self getstringValue:mid.y]];
//            [lineEle addAttributeWithName:@"stroke-width" stringValue:[NSString stringWithFormat:@"%f",lineW]];
//
//            [rootElement addChild:lineEle];
//            [rootElement addChild:[DDXMLNode textWithStringValue:@"\n"]];
        }
          
            break;
        default:
            break;
    }
}


- (void)getXMLSvg {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"svg"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    document = [[DDXMLDocument alloc] initWithData:data options:0 error:nil];
    rootElement = [document rootElement];
    [rootElement attributeForName:@"noteKey"].stringValue = NoteKey;
    [rootElement attributeForName:@"stroke"].stringValue = @"green";
    
}

- (void)savePage {
    NSString *new = [[XCFileManager documentsDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.svg",NoteKey]];
    NSLog(@"%@",new);
    [[document XMLString] writeToFile:new atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
- (NSString *)getstringValue:(CGFloat)value {
    return  [NSString stringWithFormat:@"%.4f",value];
}
@end
