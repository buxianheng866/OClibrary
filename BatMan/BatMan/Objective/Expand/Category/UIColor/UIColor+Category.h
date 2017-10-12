//
//  UIColor+Category.h
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

/**
 @brief 16进制

 @param hexString ..
 @return ..
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;


/**
 获取16进制

 @return .
 */
- (NSString *)HEXString;


/**
 *  @brief  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)RandomColor;
@end
