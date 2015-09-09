//
//  BDLCustomerWebView.m
//  bainuolite
//
//  Created by XuYang on 15/6/26.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "BDLCustomerWebView.h"
typedef enum {
    BDLCustomerWebControlStateNormal=0,
    BDLCustomerWebControlStatePullingLeft,
    BDLCustomerWebControlStatePullingRight,
    BDLCustomerWebControlStateReloadLeft,
    BDLCustomerWebControlStateReloadRight,
} BDLCustomerWebControlState;

#define tempSin 0.5

@interface BDLCustomerWebView()
@property (nonatomic,strong)UIImageView* leftTips;
@property (nonatomic,strong)UIImageView* rightTips;
@property (nonatomic,assign)CGPoint beginPoint;
@property (nonatomic,assign)CGPoint nowPoint;
@property (nonatomic,assign)CGPoint oldPoint;
//状态
@property (nonatomic,assign)NSInteger controlState;


@end

@implementation BDLCustomerWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //加入返回图片
        _leftTips = [[UIImageView alloc]initWithFrame:CGRectZero];
        [_leftTips setImage:[UIImage imageNamed:@"icon_backtips_left"]];
        [self addSubview:_leftTips];
        //加入前进图片
        _rightTips = [[UIImageView alloc]initWithFrame:CGRectZero];
        [_rightTips setImage:[UIImage imageNamed:@"icon_backtips_right"]];
        [self addSubview:_rightTips];
        _controlState = BDLCustomerWebControlStateNormal;
        _leftTips.hidden = YES;
        _rightTips.hidden = YES;
        
        UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEvent:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

-(void)layoutSubviews{
    _leftTips.frame = CGRectMake(0-52, self.center.y-10, 52, 64);
    _rightTips.frame = CGRectMake(self.frame.size.width, self.center.y-10, 52, 64);
}


- (void)panEvent:(UIPanGestureRecognizer*)pan
{
    UIGestureRecognizerState state = pan.state;
    
    switch (state) {
        case UIGestureRecognizerStateBegan:
        {
            _beginPoint = [pan translationInView:self];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
       
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if(!_isSwipeBackEnable){
                return;
            }
            
            _nowPoint = [pan translationInView:self];
            
            float offsetX = _nowPoint.x - _beginPoint.x;
            float offsetY = _nowPoint.y - _beginPoint.y;
            float dertaX = _nowPoint.x - _oldPoint.x;
            //    float dertaY = _nowPoint.y - _oldPoint.y;
            float absOffsetX = fabsf(offsetX);
            float absOffsetY = fabsf(offsetY);
            
            //是横向滑动
            NSLog(@"横向滑动 offsetX=%f",offsetX);
            _leftTips.hidden = NO;
            _rightTips.hidden = NO;
            if(_controlState == BDLCustomerWebControlStateNormal){
                if((absOffsetY/absOffsetX)<=tempSin){
                    if(offsetX >0){
                        //向右滑动
                        _controlState = BDLCustomerWebControlStatePullingRight;
                    }else{
                        //向左滑动
                        _controlState = BDLCustomerWebControlStatePullingLeft;
                    }
                }
            }else if(_controlState == BDLCustomerWebControlStatePullingRight||_controlState == BDLCustomerWebControlStateReloadRight){
                if(dertaX <0){
                    if(_leftTips.frame.origin.x>-52){
                        _leftTips.center = CGPointMake(_leftTips.center.x+(dertaX*0.6), _leftTips.center.y);
                        _controlState = BDLCustomerWebControlStatePullingRight;
                    }else{
                        //返回正常值
                        _leftTips.frame = CGRectMake(0-52, self.center.y-10, 52, 64);
                        _controlState = BDLCustomerWebControlStateNormal;
                    }
                }else{
                    //向右滑动
                    _controlState = BDLCustomerWebControlStatePullingRight;
                    if([self canGoBack]){
                        if(_leftTips.center.x<(_leftTips.frame.size.width/2-4)){
                            if(dertaX>20){
                                _leftTips.center = CGPointMake((_leftTips.frame.size.width/2), _leftTips.center.y);
                            }else{
                                _leftTips.center = CGPointMake(_leftTips.center.x+(dertaX*0.6), _leftTips.center.y);
                            }
                        }else{
                            //达到刷新值
                            _leftTips.center = CGPointMake((_leftTips.frame.size.width/2), _leftTips.center.y);
                            _controlState = BDLCustomerWebControlStateReloadRight;
                        }
                    }
                }
            }else if(_controlState == BDLCustomerWebControlStatePullingLeft||_controlState == BDLCustomerWebControlStateReloadLeft){
                if(dertaX > 0){
                    if(_rightTips.frame.origin.x<self.frame.size.width){
                        _rightTips.center = CGPointMake(_rightTips.center.x+(dertaX*0.6), _rightTips.center.y);
                        _controlState = BDLCustomerWebControlStatePullingLeft;
                    }else{
                        //返回正常值
                        _rightTips.frame = CGRectMake(self.frame.size.width, self.center.y-10, 52, 64);
                        _controlState = BDLCustomerWebControlStateNormal;
                    }
                }else{
                    //向左滑动
                    _controlState = BDLCustomerWebControlStatePullingLeft;
                    if([self canGoForward]){
                        if(_rightTips.center.x>(self.frame.size.width - _rightTips.frame.size.width/2 + 4)){
                            if(dertaX<-20){
                                _rightTips.center = CGPointMake(self.frame.size.width - (_rightTips.frame.size.width)/2, _rightTips.center.y);
                            }else{
                                _rightTips.center = CGPointMake(_rightTips.center.x+(dertaX*0.6), _rightTips.center.y);
                            }
                        }else{
                            //达到刷新值
                            _rightTips.center = CGPointMake(self.frame.size.width - (_rightTips.frame.size.width)/2, _rightTips.center.y);
                            _controlState = BDLCustomerWebControlStateReloadLeft;
                        }
                    }
                }
            }
            
            
            _oldPoint = _nowPoint;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if(!_isSwipeBackEnable){
                return;
            }
            _leftTips.hidden = YES;
            _rightTips.hidden = YES;
            if(_controlState == BDLCustomerWebControlStateReloadRight){
                [UIView animateWithDuration:0.175 animations:^(void){
                    _leftTips.alpha = 0;
                } completion:^(BOOL completion){
                    _leftTips.frame = CGRectMake(0-52, self.center.y-10, 52, 64);
                    _leftTips.alpha = 1;
                }];
                if([self canGoBack]){
                    [self goBack];
                }
            }else if(_controlState == BDLCustomerWebControlStateReloadLeft){
                [UIView animateWithDuration:0.175 animations:^(void){
                    _rightTips.alpha = 0;
                } completion:^(BOOL completion){
                    _rightTips.frame = CGRectMake(self.frame.size.width, self.center.y-10, 52, 64);
                    _rightTips.alpha = 1;
                }];
                if([self canGoForward]){
                    [self goForward];
                }
            }
            
            if(_controlState == BDLCustomerWebControlStatePullingRight){
                //向左恢复
                [UIView animateWithDuration:0.125 animations:^(void){
                    _leftTips.frame = CGRectMake(0-52, self.center.y-10, 52, 64);
                }];
            }else if(_controlState == BDLCustomerWebControlStatePullingLeft){
                //向右恢复
                [UIView animateWithDuration:0.125 animations:^(void){
                    _rightTips.frame = CGRectMake(self.frame.size.width, self.center.y-10, 52, 64);
                }];
            }
            _controlState = BDLCustomerWebControlStateNormal;
        }
            break;
            
        default:
            break;
    }
    
}

@end

