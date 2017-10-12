//
//  ObjcRuntime.m
//  Objective
//
//  Created by Bruce on 2017/7/7.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import "ObjcRuntime.h"

@implementation ObjcRuntime

/**
 获取类名
 
 @param name 相应类
 @return NSString：类名
 */
+ (NSString *)fetchClassName:(Class)name
{
    const char *className = class_getName(name);
    return [NSString stringWithUTF8String:className];
}


/**
 获取成员变量
 
 @param className Class
 @return NSArray
 */
+ (NSArray *)fetchIvarList:(Class)className
{
    unsigned int outCount = 0;
    /**
     * __unsafe_unretained Class cls 哪个类
     * unsigned int *outCount 放一个接收值的地址，用来存放属性的个数
     */
    // Ivar是一种代表类中实例变量的类型
    Ivar *ivars = class_copyIvarList(className, &outCount);
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:outCount];
    // 遍历所有成员变量
    for (unsigned int i = 0; i < outCount; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar);
        const char *ivarType = ivar_getTypeEncoding(ivar);
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        dic[@"ivarType"] = [NSString stringWithUTF8String: ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String: ivarName];
        [mutableArray addObject:dic];
    }
    // 注意释放内存！
    free(ivars);
    return mutableArray;
}


/**
 获取类的属性列表, 包括私有和公有属性，以及定义在延展中的属性
 
 @param className Class
 @return 属性列表数组
 */
+ (NSArray *)fetchPropertyList:(Class)className {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(className, &count);
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableArray addObject:[NSString stringWithUTF8String: propertyName]];
    }
    free(propertyList);
    return mutableArray;
}


/**
 获取实例方法列表：getter, setter, 对象方法等。但不能获取类方法
 
 @param className 类名
 @return 类的实例方法列表数组
 */
+ (NSArray *)fetchMethodList:(Class)className {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(className, &count);
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableArray addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return mutableArray;
}




@end



/**
 往类上添加新的方法与其实现
 
 @param c 相应的类
 @param methodSel 方法的名
 @param methodSelImpl 对应方法实现的方法名
 */

void AddClassMethod(Class c , SEL methodSel , SEL methodSelImpl ) {
    Method method = class_getInstanceMethod(c, methodSelImpl);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(c, methodSel, methodIMP, types);
}

//静态就交换静态，实例方法就交换实例方法
void Swizzle(Class c, SEL origSEL, SEL newSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
    if (!origMethod) {
        origMethod = class_getClassMethod(c, origSEL);
        if (!origMethod) {
            return;
        }
        newMethod = class_getClassMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }else{
        newMethod = class_getInstanceMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }
    
    //自身已经有了就添加不成功，直接交换即可
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
    }
}
