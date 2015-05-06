//
//  RuntimeCreateClassViewController.m
//  ProjectAccumulation
//  运行时创建类、添加变量、方法等
//  Created by XuYang on 15/4/8.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "RuntimeCreateClassViewController.h"
#import <objc/objc-runtime.h>
@interface RuntimeCreateClassViewController ()

@end

@implementation RuntimeCreateClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createClass];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createClass
{
    Class testClass = objc_allocateClassPair([NSObject class], "testClass", 0);
    //添加一个NSString的变量，第四个参数是对其方式，第五个参数是参数类型
    if (class_addIvar(testClass, "testI", sizeof(NSString *), 0, "@")) {
        NSLog(@"add ivar success");
    }
    //myclasstest是已经实现的函数，"v@:"这种写法见参数类型连接
    class_addMethod(testClass, @selector(myclasstest:), (IMP)myclasstest, "v@:");
    //注册这个类到runtime系统中就可以使用他了
    objc_registerClassPair(testClass);
    //生成了一个实例化对象
    id myobj = [[testClass alloc] init];
    NSString *str = @"测试string变量";
    //给刚刚添加的变量赋值
    //    object_setInstanceVariable(myobj, "myTest", (void *)&str);在ARC下不允许使用
    [myobj setValue:str forKey:@"testI"];
    //调用myclasstest方法，也就是给myobj这个接受者发送myclasstest这个消息
//    [myobj myclasstest:[NSNumber numberWithInt:10]];

    [myobj performSelectorOnMainThread:@selector(myclasstest:) withObject:[NSNumber numberWithInt:10]  waitUntilDone:NO];
}

//这个方法实际上没有被调用,但是必须实现否则不会调用下面的方法
//- (void)myclasstest:(NSNumber*)a
//{
//
//}
//调用的是这个方法
static void myclasstest(id self, SEL _cmd, NSNumber *a) //self和_cmd是必须的，在之后可以随意添加其他参数
{
    
    Ivar v = class_getInstanceVariable([self class], "testI");
    //返回名为itest的ivar的变量的值
    id o = object_getIvar(self, v);
    //成功打印出结果
    NSLog(@"%@", o);
    NSLog(@"nsnumber a is %@", a);
}

@end
