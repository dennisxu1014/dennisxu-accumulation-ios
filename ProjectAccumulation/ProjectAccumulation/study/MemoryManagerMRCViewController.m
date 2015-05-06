//
//  MemoryManagerMRCViewController.m
//  ProjectAccumulation
//  内存管理，mrc
//  Created by XuYang on 15/4/27.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "MemoryManagerMRCViewController.h"

@interface MemoryManagerMRCViewController ()

@end

@implementation MemoryManagerMRCViewController

//该文件使用mrc手动管理内存方式
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //retain,copy,assign 区别
    //retain：释放旧的对象，将旧对象的值赋予输入对象，再提高输入对象的索引计数为1
    //copy： 建立一个索引计数为1的对象，然后释放旧对象
    //assign：为简单数据类型准备的
    
    //测试对象
    [self testObject];
    
    //测试string
//    [self testString];

}

-(void)testObject{
    Person *person1 = [[Person alloc]init];
    NSLog("person alloc init retainCount %li",[person1 retainCount]);
    [person1 retain];
    NSLog("person after retain retainCount %li",[person1 retainCount]);
    [person1 release];
    NSLog("person after relase retainCount %li",person1.retainCount);
    [person1 release];
    person1 = nil;
    NSLog("person after relase retainCount %li",person1.retainCount);
    
}

-(void)testString{
    // （1）NSString对象Objective-C中是一种非常特殊的对象，其引用系数不受引用计数规则的控制。NSString对象不管是alloc、retain还是release，其引用计数都是-1
    NSString *aStr = [[NSString alloc] initWithString:@"abc"];
    NSLog(@"aStr address = %p", aStr);
    NSLog(@"aStr retainCount after alloc = %li", [aStr retainCount]);
    NSString *bStr = [aStr copy];
    NSLog(@"aStr retainCount after copy = %li", [aStr retainCount]);
    NSLog(@"bStr address = %p", bStr);
    NSLog(@"bStr retainCount = %li", [bStr retainCount]);
    NSString *cStr = [aStr retain];
    aStr = @"efg";
    NSLog(@"aStr retainCount after retain = %li", [aStr retainCount]);
    NSLog(@"cStr address = %p", cStr);
    NSLog(@"cStr retainCount = %li", [cStr retainCount]);
    NSLog(@"cStr str after changed = %@", cStr);
    [aStr release];
    NSLog(@"aStrretainCount after release = %li", [aStr retainCount]);
    
    //  （2）对于NSMutableString，看下面一段代码
    NSMutableString *str1 = [[NSMutableString alloc] initWithString:@"abc"];
    NSLog(@"str1 address = %p", str1);
    NSLog(@"str1 retaincount after alloc = %li", [str1 retainCount]);
    NSString *str2 = [str1 copy];
    NSLog(@"str1retaincount after copy = %li", [str1 retainCount]);
    NSLog(@"str2 address = %p", str2);
    NSLog(@"str2 retaincount = %li", [str2 retainCount]);
    NSString *str3 = [str1 retain];
    NSLog(@"str1 retaincount after retain = %li", [str1 retainCount]);
    NSLog(@"str3 address = %p", str3);
    NSLog(@"str3 retaincount = %li", [str3 retainCount]);
    [str1 setString:@"edf"];
    NSLog(@"str1 address = %p", str1);
    NSLog(@"after str1 changed, str2 = %@", str2);
    NSLog(@"afterstr1 changed, str3 = %@", str3);
    
    //从（1）中的结果可以看出，对于NSString来说，用alloc和用retain都是指向同一块内存，区别不大
    //但从（2）中来看，对于NSMutableString来说，alloc实际上就是开辟了一块新内存，再把内容复制进来，而retain内存不变引用计数+1。如果NSMutableString中的内容被改变了的话，用retain之后的str3内容也被改变。这是写程序过程中所不想要的结果。所以这种情况下，用copy比较安全。
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end

@implementation Person


@end