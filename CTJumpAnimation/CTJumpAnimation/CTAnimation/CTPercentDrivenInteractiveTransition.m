//
//  PercentDrivenInteractiveTransition.m
//  CTJumpAnimation
//
//  Created by HQ on 15/8/22.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "CTPercentDrivenInteractiveTransition.h"

@interface CTPercentDrivenInteractiveTransition ()
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer * gesture;   /**< 屏幕的手势 */
@end

@implementation CTPercentDrivenInteractiveTransition

#pragma mark - 
#pragma mark - 给新退出的视图添加手势识别
- (void)addGestureRecognizer:(UIViewController *)viewController
{
    
    //手势识别为屏幕左侧边缘 如需全屏幕识别侧使用UIPanGestureRecognizer手势
    _presentedVC = viewController;
    if (self.gesture) {
        [_presentedVC.view removeGestureRecognizer:self.gesture];
    }
    self.gesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureRecognizerAction:)];
    self.gesture.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:self.gesture];
}

#pragma mark - 
#pragma mark -  手势识别事件
- (void)gestureRecognizerAction:(UIScreenEdgePanGestureRecognizer *)edgePanGesture
{
    
    CGFloat translation =[edgePanGesture translationInView:_presentedVC.view].x;
    CGFloat percent = translation / (_presentedVC.view.bounds.size.width);
    
    //percent的值保持在0~1的范围内
    percent = MIN(1, MAX(0.0, percent));
    
    NSLog(@"%f  %f",percent, translation / (_presentedVC.view.bounds.size.width/10*13));
    
    switch (edgePanGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.interacting =  YES;
            //是navigationController控制时
            [_presentedVC.navigationController popViewControllerAnimated:YES];
            
            //如果对应模态视图 则使用
//            [_presentedVC dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            
            [self updateInteractiveTransition:percent];
            break;
        }
            
        case UIGestureRecognizerStateEnded:{
            
            self.interacting = NO;
            if (percent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
            
        default:
            break;
    }
}

@end
