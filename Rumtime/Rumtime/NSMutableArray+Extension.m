//
//  NSMutableArray+Extension.m
//  Rumtime
//
//  Created by MoGo on 16/10/23.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>
@implementation NSMutableArray (Extension)
//类加载的时候调用
+(void)load{
    //系统的方法
    Method systemMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    //自己的方法
    Method myMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(my_addObject:));
    //替换系统的方法
    method_exchangeImplementations(systemMethod, myMethod);
}
- (void)my_addObject:(id)object{
    if (object != nil) {
        [self my_addObject:object];
    }
}
@end
