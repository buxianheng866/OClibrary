//
//  ObjcRuntime.h
//  Objective
//
//  Created by Bruce on 2017/7/7.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
// 交换类方法 或者 实例方法,可拦截系统方法
void Swizzle(Class c, SEL origSEL, SEL newSEL);

// 往类上添加新的方法与其实现
void AddClassMethod(Class c , SEL methodSel , SEL methodSelImpl );
@interface ObjcRuntime : NSObject

/**
 获取类名
 
 @param name 相应类
 @return NSString：类名
 */
+ (NSString *)fetchClassName:(Class)name;

/**
 获取成员变量
 
 @param className Class
 @return NSArray
 */
+ (NSArray *)fetchIvarList:(Class)className;


/**
 获取类的属性列表, 包括私有和公有属性，以及定义在延展中的属性
 
 @param className Class
 @return 属性列表数组
 */
+ (NSArray *)fetchPropertyList:(Class)className;


/**
 获取实例方法列表：getter, setter, 对象方法等。但不能获取类方法
 
 @param className 类名
 @return 类的实例方法列表数组
 */
+ (NSArray *)fetchMethodList:(Class)className;


@end


