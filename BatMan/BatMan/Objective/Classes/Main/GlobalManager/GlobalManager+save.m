//
//  GlobalManager+save.m
//  BatMan
//
//  Created by nb616 on 2017/9/27.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import "GlobalManager+save.h"

@implementation GlobalManager (save)
- (void)setobject:(id)object key:(NSString *)key
{
    [kUserDefaults setObject:object forKey:key];
    [kUserDefaults synchronize];
}

- (id)objectForKey:(NSString *)key
{
    return [kUserDefaults objectForKey:key];
}

- (void)removeforKey:(NSString *)key{
    [kUserDefaults removeObjectForKey:key];
}

- (void)saveSchemeData:(id)data key:(NSString *)key suiteName:(NSString *)suiteName
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
    [userDefaults setObject:data forKey:key];
    [userDefaults synchronize];
}

- (id)schemeDataForKey:(NSString *)key suitName:(NSString *)suiteName
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
    return [userDefaults objectForKey:key];
}

@end
