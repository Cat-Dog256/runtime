//
//  Boyfriend.h
//  Rumtime
//
//  Created by MoGo on 16/10/24.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCBaseEntity.h"
#import "Simplefriend.h"
@interface Boyfriend : LCBaseEntity
@property (nonatomic , strong) NSString *name;
@property (nonatomic , assign) int age;
@property (nonatomic , assign) int height;
@property (nonatomic , assign) int weight;
@property (nonatomic , strong) NSString *nickname;
@property (nonatomic , strong) NSString *prototype;
@property (nonatomic , strong) NSDictionary *expandProperties;
@property (nonatomic , strong) NSArray *girlfriends;
@property (nonatomic , strong) NSArray *simplefriends;
@end
