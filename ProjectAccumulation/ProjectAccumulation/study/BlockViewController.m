//
//  BlockViewController.m
//  ProjectAccumulation
//  block学习
//  Created by XuYang on 15/4/13.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()

@end

@implementation BlockViewController
typedef long (^BlkTest)(int, int);

-(instancetype)init{
    if(self ==[super init]){
        _instanceObj = [[NSObject alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//Block内存
    [self blockMemoney];
//Block基础语法
//    [self blockTest1];
//block做函数参数
//    [self blockTest2];
//block做返回值
//    BlkTest3 testB3 = [self blockTest3];
//    NSLog(@"testB3:%ld",testB3(2,3));
//block变量、对象捕获相关
//    [self blockTest4];
//    [self blockTest5];
//    [self clangTestCode];
}
-(void)clangTestCode{
    int(^block1)(int a)  = ^ int (int a){
        return 1;
    };
    block1(1);
    NSLog(@"%block1:%@",block1);
}

#pragma mark block做函数参数
typedef int (^BlkTest2)(int, int);
-(void)blockTest2{
    BlkTest2 testB2 = ^ int (int a,int b){
        return a+b;
    };
    [self func1:testB2];
}

-(void)func1:(BlkTest2)block2{
    int a = 2;
    int b = 3;
    NSLog(@"a+b=%d",block2(a,b));
}

#pragma mark block做返回值
typedef long (^BlkTest3)(int, int);
- (BlkTest3) blockTest3 {
    int base = 100;
    BlkTest3 blk = ^ long (int a, int b) {
        return base + a + b;
    };
    return [blk copy];
}


//__block说明符
//前面讲过block所在函数中的，捕获自动变量。但是不能修改它，不然就是编译错误。但是可以改变全局变量、静态变量、全局静态变量。其实这两个特点不难理解：
//● 不能修改自动变量的值是因为：block捕获的是自动变量的副本，名字一样。如果可以赋值，就造成不对称给的效果
//● 可以修改静态变量的值：静态变量属于类的，不是某一个变量。由于block内部不用调用self指针。所以block可以调用。

#pragma mark block变量、对象捕获相关
typedef int (^BlkTest4)(int, int);
- (void) blockTest4 {
    int base = 100;
    BlkTest4 blk = ^ int (int a, int b) {
        //base++ base对于block来说是只读的，所以如果不在base前面加 __block 则编译不通过
        return base + a + b;
    };
    NSLog(@"blk:%d",blk(base,base));
    NSLog(@"blk:%d",base);
    
    __block int base2 = 100;
    BlkTest4 blk2 = ^ int (int a, int b) {
        base2++;
        return base2 + a + b;
    };
    NSLog(@"blk:%d",blk2(base2,base2));
    NSLog(@"blk:%d",base2);
}

#pragma mark block变量、对象捕获相关
NSObject* __globalObj = nil;
typedef void (^BlkTest5)(void);
- (void) blockTest5 {
    static NSObject* __staticObj = nil;
    __globalObj = [[NSObject alloc] init];
    __staticObj = [[NSObject alloc] init];
    
    NSObject* localObj = [[NSObject alloc] init];
    __block NSObject* blockObj = [[NSObject alloc] init];
    
    NSLog(@"outer __globalObj：%@", __globalObj);
    NSLog(@"outer __staticObj：%@", __staticObj);
    NSLog(@"outer _instanceObj：%@", _instanceObj);
    NSLog(@"outer localObj：%@", localObj);
    NSLog(@"outer blockObj：%@", blockObj);
    NSLog(@"---------以下是相同对象在block中的情况--------");
    BlkTest5 blk = ^ void {
        NSLog(@"inner __globalObj：%@", __globalObj);
        NSLog(@"inner __staticObj：%@", __staticObj);
        NSLog(@"inner _instanceObj：%@", _instanceObj);
        NSLog(@"inner localObj：%@", localObj);//MRC下 retainCount+1
        NSLog(@"inner blockObj：%@", blockObj);
    };
    blk();
}

#pragma mark block在内存中的位置
-(void)blockMemoney{
//    Block在内存中的位置
//    根据Block在内存中的位置分为三种类型NSGlobalBlock，NSStackBlock, NSMallocBlock。
//    NSGlobalBlock：类似函数，位于text段；
//    NSStackBlock：位于栈内存，函数返回后Block将无效；
//    NSMallocBlock：位于堆内存。

    BlkTest blk1 = ^ long (int a, int b) {
        return a + b;
    };
    NSLog(@"blk1 = %@", blk1);// blk1 = <__NSGlobalBlock__: 0x1033c5190>
    //
    
    __block int base = 100;
    BlkTest blk2 = ^ long (int a, int b) {
        base = a + b;
        return base;
    };
    NSLog(@"blk2 = %@", blk2);
    // blk2 = MRC --> <__NSStackBlock__: 0x7fff53002a60>
    // ARC--> <__NSMallocBlock__: 0x7ffe02527980>
    
    //    NSLog(@"blk2(base,base) = %ld",blk2(base,base));
    //    NSLog(@"base = %d",base);
    
    BlkTest blk3 = [blk2 copy];
    NSLog(@"blk3 = %@", blk3);
    // blk3 = <__NSMallocBlock__: 0x7ffe02527980>
}

#pragma mark 基础语法
-(void)blockTest1{
    //block主体
    int result1 = ^(int a){return a * a;}(2);
    NSLog(@"block pointer:%d",result1);
    
    //block 指针
    int (^testBlock)(int);
    testBlock = ^(int a ){
        return a+a ;
    };
    int result2 = testBlock(1);
    NSLog(@"block pointer:%d",result2);
    
    //block变量
    __block int num = 0;
    void (^block1)(int)= ^(int a ){num++;};
    block1(0);
    NSLog(@"block result3: %d",num);
    num += 1;
    NSLog(@"block result3: %d",num);
    void (^block2)(int)= ^(int a ){num++;};
    block2(0);
    NSLog(@"block result3: %d",num);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
