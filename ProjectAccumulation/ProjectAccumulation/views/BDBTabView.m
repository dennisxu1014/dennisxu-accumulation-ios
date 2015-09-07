//
//  BDBTabTableViewCell.m
//  band
//
//  Created by XuYang on 15/8/21.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "BDBTabView.h"

#define TAB_HEIGHT 40.0f

#define LINE_TAG 100
#define TAB_BACKGROUND_NORMAL ([UIColor whiteColor])
#define TAB_BACKGROUND_SELECTED (UIColorFromRGB(0xF8F8F8))
#define TAB_TITLE_COLOR_NORMAL (UIColorFromRGB(0x55555D))
#define TAB_TITLE_COLOR_SELECTED (UIColorFromRGB(0xFE638B))
#define TAB_TITLE_SIZE 13.0f

#define UIColorFromRGB(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])
@interface BDBTabView ()

@property(nonatomic,strong)NSArray* currentTabArray;
@property(nonatomic,strong)NSMutableArray *buttonArray;
@property(nonatomic,strong)NSMutableArray *barViewArray;

@property(nonatomic,assign)NSInteger currentSelect;
@end

@implementation BDBTabView

- (instancetype)initWithTabData:(NSArray*)tabArray
{
    self = [super init];
    if (self) {
        [self customerInit];
        if(tabArray != nil){
            _currentTabArray = tabArray;
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customerInit];
    }
    return self;
}

-(void)customerInit{
    _currentSelect = 0;
    self.backgroundColor = [UIColor whiteColor];
    UIView* line0 = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                             TAB_HEIGHT-0.5f,
                                                             SCREEN_WIDTH,
                                                             0.5f)];
    line0.backgroundColor = UIColorFromRGB(0xd8d8d8);
    line0.tag= LINE_TAG;
    [self addSubview:line0];
}
//更新tab
- (void)updateTab:(NSArray*)tabArray{
    if(tabArray==nil){
        NSLog(@"tabArray is Null !!!!");
        return ;
    }
    
    _currentTabArray = tabArray;
    if(_buttonArray!=nil && _buttonArray.count == tabArray.count){
        if(_buttonArray.count == tabArray.count){
            for(int i = 0 ;i<tabArray.count;i++){
                //仅更新title
                [((UIButton*)[_buttonArray objectAtIndex:i]) setTitle:((BDBTabViewModel*)[tabArray objectAtIndex:i]).title forState:UIControlStateNormal];
            }
        }else{
            for(UIButton *btn in _buttonArray){
                [btn removeFromSuperview];
                _buttonArray = nil;
                [self updateTab:tabArray];
            }
        }
    }else{
        //还未创建Button，创建button,并加载到界面上
        _buttonArray = [[NSMutableArray alloc]init];
        _barViewArray = [[NSMutableArray alloc]init];
        for(NSInteger i=0 ; i<tabArray.count ; i++){
            CGFloat modelWidth = SCREEN_WIDTH / tabArray.count;
            UIButton *currentButton = [UIButton buttonWithType:UIButtonTypeCustom];
            currentButton.frame = CGRectMake(modelWidth*i, 0, modelWidth, TAB_HEIGHT);
            currentButton.tag = i;
            [currentButton setTitle:((BDBTabViewModel*)[tabArray objectAtIndex:i]).title forState:UIControlStateNormal];
            [currentButton setTitleColor:TAB_TITLE_COLOR_NORMAL forState:UIControlStateNormal];
            currentButton.backgroundColor = [UIColor whiteColor];
            currentButton.titleLabel.font = [UIFont systemFontOfSize:TAB_TITLE_SIZE];
            [currentButton addTarget:self action:@selector(buttonHighlighted:) forControlEvents:UIControlEventTouchDown];
            [currentButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [currentButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchCancel];
            [currentButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpOutside];
            [self addSubview:currentButton];
            [_buttonArray addObject:currentButton];
            CGFloat barWidth = SCREEN_WIDTH / tabArray.count * 0.7;
            UIView *bar = [[UIView alloc]init];
            bar.frame = CGRectMake( modelWidth*i + (modelWidth-barWidth)/2, TAB_HEIGHT - 2, barWidth, 2);
            bar.backgroundColor = [UIColor redColor];
            bar.hidden = YES;
            [self addSubview:bar];
            [_barViewArray addObject:bar];
            
            
        }
        if(tabArray.count>1){
            for(NSInteger i = 0 ; i<tabArray.count ; i++){
                if(i != tabArray.count-1){
                    CGFloat modelWidth = SCREEN_WIDTH / tabArray.count;
                    UIView *vLine = [[UIView alloc]initWithFrame:CGRectMake(i*modelWidth+modelWidth-0.5, 10, 0.5f, 22)];
                    vLine.backgroundColor = UIColorFromRGB(0xd8d8d8);
                    [self addSubview:vLine];
                }
                
            }
        }
        [self setSelect:0];
    }
    
    [self bringSubviewToFront:[self viewWithTag:LINE_TAG]];
}

-(void)setSelect:(NSInteger)index{
    for(NSInteger i = 0;i<_buttonArray.count;i++){
        if(index == i){
            UIButton *button = [_buttonArray objectAtIndex:i];
            
            button.backgroundColor = TAB_BACKGROUND_SELECTED;
            [button setTitleColor:TAB_TITLE_COLOR_SELECTED forState:UIControlStateNormal];
            
            if(_currentTabArray.count ==1){
                button.backgroundColor = TAB_BACKGROUND_NORMAL;
                [button setTitleColor:TAB_TITLE_COLOR_SELECTED forState:UIControlStateNormal];
            }
            
            UIView *bar = [_barViewArray objectAtIndex:i];
            bar.hidden = NO;
        }else{
            UIButton *button = [_buttonArray objectAtIndex:i];
            button.backgroundColor = TAB_BACKGROUND_NORMAL;
            [button setTitleColor:TAB_TITLE_COLOR_NORMAL forState:UIControlStateNormal];
            
            UIView *bar = [_barViewArray objectAtIndex:i];
            bar.hidden = YES;
        }
    }
}

-(void)buttonHighlighted:(id)button{
    if(_currentTabArray.count ==1){
        return;
    }
    
    ((UIButton*)button).backgroundColor = TAB_BACKGROUND_SELECTED;
}

-(void)buttonNormal:(id)button{
     ((UIButton*)button).backgroundColor = [UIColor whiteColor];
}

-(void)buttonClick:(id)button{
    if(_currentTabArray.count ==1){
        return;
    }
    [self setSelect:((UIButton*)button).tag];
    if(_delegate !=nil){
        if([_delegate respondsToSelector:@selector(onTabClick:Model:)]){
            [_delegate onTabClick:[button tag] Model:[_currentTabArray objectAtIndex:[button tag]]];
        }
    }
}

@end
