//
//  BDBTabTableViewCell.h
//  band
//
//  Created by XuYang on 15/8/21.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBTabViewModel.h"
@protocol BDBTabViewDelegate <NSObject>

@required
-(void)onTabClick:(NSInteger)index Model:(BDBTabViewModel*)model;

@end

@interface BDBTabView : UIView

@property (nonatomic, weak) id<BDBTabViewDelegate> delegate;


- (instancetype)initWithTabData:(NSArray*)tabArray;
- (void)updateTab:(NSArray*)tabArray;

@end
