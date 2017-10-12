//
//  GlobalManager+save.h
//  BatMan
//
//  Created by nb616 on 2017/9/27.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import "GlobalManager.h"

@interface GlobalManager (save)
- (void)setobject:(id)object key:(NSString *)key;
- (id)objectForKey:(NSString *)key;
- (void)removeforKey:(NSString *)key;
- (void)saveSchemeData:(id)data key:(NSString *)key suiteName:(NSString *)suiteName;
- (id)schemeDataForKey:(NSString *)key suitName:(NSString *)suiteName;

@end
