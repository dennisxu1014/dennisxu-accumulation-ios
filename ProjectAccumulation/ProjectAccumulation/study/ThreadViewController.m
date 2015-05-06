//
//  ThreadViewController.m
//  ProjectAccumulation
//  多线程学习
//  Created by XuYang on 15/4/27.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

//iOS的三种多线程技术特点:
//1.NSThread:
//1> 使用NSThread对象建立一个线程非常方便;
//2> 但是!要使用NSThread管理多个线程非常困难,不推荐使用;
//3> 技巧!使用[NSThread currentThread]跟踪任务所在线程,适用于这三种技术.
//2.NSOperation/NSOperationQueue:
//1> 是使用GCD实现的一套Objective-C的API;
//2> 是面向对象的多线程技术;
//3> 提供了一些在GCD中不容易实现的特性,如:限制最大并发数量,操作之间的依赖关系.
//3.GCD---Grand Central Dispatch:
//1> 是基于C语言的底层API;
//2> 用Block定义任务,使用起来非常灵活便捷;
//3> 提供了更多的控制能力以及操作队列中所不能使用的底层函数.

#import "ThreadViewController.h"

@interface ThreadViewController ()
@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"线程学习";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testNSThread];
    
    [self testOperation];

    [self testDispatch];
    
}

-(void)testNSThread{
    //类方法
    [NSThread detachNewThreadSelector:@selector(operationAction:) toTarget:self withObject:self];
    //实例方法
    NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(operationAction:)
                                                   object:self];
    [myThread start];
}

-(void)testOperation{
    //队列处理的任务是NSOperation的子类:NSInvocationOperation 和 NSBlockOperation.
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];  //主队列  主线程执行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init]; //自定义队列  异步线程执行
    queue.maxConcurrentOperationCount = 3;//控制核心数量
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        //任务执行
    }];
    [queue addOperation:operation];
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operationAction:) object:self];
    //<NSThread: 0x7fbfdb711830>{number = 1, name = main}
    [mainQueue addOperation:op];
    //<NSThread: 0x7fbfdb711830>{number = 2, name = <null>}
//    [queue addOperation:op];
}
-(void)operationAction:(id)obj{
    NSLog(@"%@----obj : %@ ",[NSThread currentThread], obj);
};
-(void)testDispatch{
    //队列分为两种：串行队列，并行队列
    //系统默认创建的4个全局队列   并发队列
    dispatch_queue_t q1= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q2= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t q3= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_queue_t q4= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);//最低优先级
    
    //系统默认创建的主线程队列   串行队列
    dispatch_queue_t main = dispatch_get_main_queue();//主线程
    
    //创建用户级自定义队列  串行队列
    dispatch_queue_t queue = dispatch_queue_create("test_queue", DISPATCH_QUEUE_SERIAL);
    
    //获得队列名字
    NSLog(@"queueName %s",dispatch_queue_get_label(queue));
    
//    dispatch_queue_attr_make_with_qos_class(<#dispatch_queue_attr_t attr#>, <#dispatch_qos_class_t qos_class#>, <#int relative_priority#>)
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC)), queue , ^(void ){
        NSLog(@"test queue");
        // 合并汇总结果
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
            // 并行执行的线程一
        });
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
            // 并行执行的线程二
        });
        dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
            // 汇总结果
        });
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
