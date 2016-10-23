//
//  Girlfriend.h
//  Rumtime
//
//  Created by MoGo on 16/10/23.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCBaseEntity.h"
#import "Boyfriend.h"
@interface Girlfriend : LCBaseEntity
@property (nonatomic , strong) NSString *name;
@property (nonatomic , assign) int age;
@property (nonatomic , assign) int height;
@property (nonatomic , assign) int weight;
@property (nonatomic , strong) NSString *nickname;
@property (nonatomic , strong) NSString *price;
@property (nonatomic , strong) NSString *prototype;
@property (nonatomic , strong) NSDictionary *expandProperties;
@property (nonatomic , strong) Boyfriend *boyfriend;
@end
