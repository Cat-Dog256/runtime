//
//  ViewController.m
//  Rumtime
//
//  Created by MoGo on 16/10/23.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "ViewController.h"
#import "Girlfriend.h"
//导入头文件
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self runtimeCreateNewClass];
//    [self getOneClassAllProperties];
//    [self runtimeDictToModel];
//    [self testArchiver];
//    [self test];
    [self test2];
    // Do any additional setup after loading the view, typically from a nib.
}
//动态创建一个类
- (void)runtimeCreateNewClass{
    //创建新的类
    Class newClass = objc_allocateClassPair([UIView class], "CustomView", 0);
    //给类增加新的方法
    class_addMethod(newClass, @selector(report), (IMP)ReportFuntion, "v@:");
    //注册该类
    objc_registerClassPair(newClass);
    //创建实例
    id instanceOfNewClass = [newClass new];
    //调用方法
    [instanceOfNewClass performSelector:@selector(report)];
}
void ReportFuntion(id self , SEL _cmd){
    NSLog(@"This object is %p" , self);
    NSLog(@"Class is %@ , and super is %@",[self class] , [self superclass]);
    Class currentClass = [self class];
    
    for (int i = 0; i < 10 ; i++) {
        NSLog(@"Following the isa pointer %d times gives %p" , i , currentClass);
        currentClass = object_getClass(currentClass);
    }
    
    NSLog(@"NSObject's class is %p" , [NSObject class]);
    NSLog(@"NSObject's meta class is %p" , object_getClass([NSObject class]));
    
}
#pragma mark **获取一个类的所有属性**
- (void)getOneClassAllProperties{
    unsigned int count = 0;
    //返回一个指针数组,里面装有一个类的所有成员变量,这个数组必须手动释放
    Ivar *ivars = class_copyIvarList([Girlfriend class], &count);
    for (int i = 0; i < count;  i++) {
        Ivar ivar = ivars[i];
        //获取成员变量的名字 , 返回的为C语言字符串
        const char *name = ivar_getName(ivar);
        //转为oc的字符串
        NSString *key = [NSString stringWithUTF8String:name];
        //获取成员变量的类型
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSLog(@"type:%@ , key : %@",type,key);
    }
    //手动释放数组
    free(ivars);

}
- (void)arrayCanAddNil{
    NSMutableArray *testArray = [NSMutableArray new];
    [testArray addObject:@"Object-C"];
    [testArray addObject:@"swift"];
    [testArray addObject:nil];
    NSLog(@"%@",testArray);
}
- (void)runtimeDictToModel{
    
    NSDictionary *jsonData = @{@"name" : @"夏晗熙",
                               @"nickname" : @"挚爱一生",
                               @"birthday" : @"20160906"};
    
    Girlfriend *newGirlfriend = [Girlfriend new];
    [newGirlfriend setValuesForKeysWithDictionary:jsonData];
    NSLog(@"%@",newGirlfriend);
}
- (void)testArchiver{
    NSDictionary *jsonData = @{@"name" : @"夏晗熙",
                               @"nickname" : @"挚爱一生",
                               @"birthday" : @"20160906"};
    
    Girlfriend *newGirlfriend = [Girlfriend new];
    [newGirlfriend setValuesForKeysWithDictionary:jsonData];
    
    
    NSString *home = NSHomeDirectory();//获取沙盒路径
    //拼接Documents路径
    //NSString *docPath = [home stringByAppendingStringt:@"/Documents"];
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"myGirlfriend.data"];

     BOOL success =  [NSKeyedArchiver archiveRootObject:newGirlfriend toFile:filePath];
    if (success == NO) {
        NSAssert(NO, @"归档失败,路径为:%@",filePath);
    }
  Girlfriend *myGirlfriend = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",myGirlfriend);
}
//二级字典转模型,字典里包含字典
- (void)test{
    NSDictionary *jsonData = @{@"name" : @"夏晗熙",
                               @"nickname" : @"挚爱一生",
                               @"birthday" : @"20160906",
                               @"boyfriend": @{@"name" : @"肖奈",
                                               @"nickname" : @"沉淀繁华",
                                               @"birthday" : @"20160926"}};
    Girlfriend *newGirlfriend = [Girlfriend modelWithDict:jsonData];
    NSLog(@"%@",newGirlfriend);
}
//三级字典转模型,字典包含数组,数组里包含字典
- (void)test2{
    NSDictionary *jsonData = @{@"name" : @"肖奈",
                               @"nickname" : @"沉淀繁华",
                               @"birthday" : @"20160906",
                               @"girlfriends":@[@{@"name" : @"夏晗熙",
                                                  @"nickname" : @"挚爱一生",
                                                  @"birthday" : @"20160906"},
                                                @{@"name" : @"林志玲",
                                                                               @"nickname" : @"宅男偶像",
                                                                               @"birthday" : @"20161314"}],
                               @"simplefriends":@[@{@"name" : @"路人甲",
                                                   @"gender" : @"男",
                                                   @"name" : @"路人乙" ,
                                                   @"gender" : @"女"}]};
    Boyfriend *newBoyfriend = [Boyfriend modelWithDict:jsonData];
    NSLog(@"%@",newBoyfriend);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
