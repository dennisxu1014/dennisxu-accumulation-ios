//
//  OCMessageViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/4/8.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "OCMessageViewController.h"
#import <objc/objc-runtime.h>
@interface OCMessageViewController ()

@end

@implementation OCMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //OC消息传递
    [self testMethod];
    
    //OC消息转发
    [self performSelectorOnMainThread:@selector(test:) withObject:nil waitUntilDone:NO];
}

-(void)testMethod{
    NSLog(@"testMethod");
    
    NSLog(@"object:%p",self);
    NSLog(@"Class is %@, and super is %@.",[self class],[self superclass]);
    Class currentClass = [self class];
    //i=1类对象，i=2元类，i=3根元类
    for( int i = 1; i < 10; ++i )
    {
        NSLog(@"Following the isa pointer %d times gives %p name %@",i,currentClass,[currentClass description]);
        currentClass = object_getClass(currentClass);
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p",object_getClass([NSObject class]));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"resolveInstanceMethod sel:");
    
    return NO;
}

-(id)forwardingTargetForSelector:(SEL)aSelector{
        NSLog(@"forwardingTargetForSelector sel:");
    return nil;
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"methodSignatureForSelector aSelector");
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
        NSLog(@"forwardInvocation anInvocation:%@",anInvocation);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
