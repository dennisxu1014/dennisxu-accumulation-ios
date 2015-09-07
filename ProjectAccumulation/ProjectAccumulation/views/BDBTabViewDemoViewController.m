//
//  BDBTabViewDemoViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/9/6.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "BDBTabViewDemoViewController.h"
#import "BDBTabView.h"
@interface BDBTabViewDemoViewController()<BDBTabViewDelegate>
@property(strong,nonatomic)BDBTabView *useTypeTabView;
@property(strong,nonatomic)NSString* currentUserType;
@end

@implementation BDBTabViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //用户类型筛选表头
    _useTypeTabView = [[BDBTabView alloc]initWithFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width, 40)];
    _useTypeTabView.delegate = self;
    BDBTabViewModel *loadingModel = [[BDBTabViewModel alloc]init];
    loadingModel.title = @"正在加载...";
    BDBTabViewModel *loadingModel1 = [[BDBTabViewModel alloc]init];
    loadingModel1.title = @"项目1";
    loadingModel1.xid = @"1";
    BDBTabViewModel *loadingModel2 = [[BDBTabViewModel alloc]init];
    loadingModel2.title = @"项目2";
    loadingModel2.xid = @"2";
    BDBTabViewModel *loadingModel3 = [[BDBTabViewModel alloc]init];
    loadingModel3.title = @"项目3";
    loadingModel3.xid = @"3";
    BDBTabViewModel *loadingModel4 = [[BDBTabViewModel alloc]init];
    loadingModel4.title = @"加载项目4";
    loadingModel4.xid = @"4";
    BDBTabViewModel *loadingModel5 = [[BDBTabViewModel alloc]init];
    loadingModel5.title = @"项目5";
    loadingModel5.xid = @"5";
    _currentUserType = @"0";
    NSArray* tabArray = [NSArray arrayWithObjects:loadingModel,loadingModel1,loadingModel2,loadingModel3,loadingModel4,loadingModel5,nil];
    [_useTypeTabView updateTab:tabArray];
    
    [self.view addSubview:_useTypeTabView];
}

-(void)onTabClick:(NSInteger)index Model:(BDBTabViewModel*)model{
    //    [self reloadViewControllerData];
    _currentUserType = model.xid;
    
}


@end
