//
//  LCBaseEntity.h
//  Rumtime
//
//  Created by MoGo on 16/10/23.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LCBaseEntity : NSObject<NSCoding>
+ (instancetype)modelWithDict:(NSDictionary *)dict;
+ (NSDictionary *)arrayContainModelClass;
@end
