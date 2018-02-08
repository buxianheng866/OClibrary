//
//  NSString+Category.h
//  BatMan
//
//  Created by nb616 on 2017/12/11.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
- (BOOL)isMobileNumber:(NSString *)mobileNum;

//只检查车牌号 （不包括缩写与英文代号：例如：京A)
- (BOOL)isCarNumber;

//检查是否字符串为网址
- (BOOL)isURL;

@end
