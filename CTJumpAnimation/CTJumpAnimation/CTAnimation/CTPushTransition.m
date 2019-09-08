//
//  PushTransition.m
//  CTJumpAnimation
//
//  Created by HQ on 15/8/23.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "CTPushTransition.h"

@implementation CTPushTransition

#pragma mark - 
#pragma mark - 设置自定义push跳转动效的持续时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.4f;
}

#pragma mark - 
#pragma mark - 自定义push跳转的动效
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    //把toView加到containerView上
    UIViewController * fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC   = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * fromView = fromVC.view;
    UIView * toView  = toVC.view;
    
    UIView * containerView = [transitionContext containerView];
    
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    //增加透视的transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    //给fromVC和toVC分别设置相同的起始frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = initialFrame;
    
    //增加黑色透明层在fromView上
    UIView * shadow = [[UIView alloc]initWithFrame:fromView.bounds];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.0;
    [fromView addSubview:shadow];
    
    //将toview从定位到右边 在从右向左移动
    CGRect toviewLeftMove = toView.frame;
    toviewLeftMove.origin.x = toviewLeftMove.size.width+50;
    toView.frame = toviewLeftMove;
    
    //push时 toview先旋转1度 在恢复到平面效果
    toView.layer.transform = CATransform3DMakeRotation(-M_PI/18, 0, 1.0, 0);
    
    //设置过渡动画效果
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        shadow.alpha = 0.9;
        
        //旋转fromView 45度
        fromView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1.0, 0);
        //将toview旋转到平面效果
        toView.layer.transform = CATransform3DMakeRotation(0, 0, 1.0, 0);
        
        //toview左移动
        CGRect toviewRightMove = toviewLeftMove;
        toviewRightMove.origin.x = 0;
        toView.frame = toviewRightMove;
        
        //fromView左移动
        CGRect fromviewLeftMove = initialFrame;
        fromviewLeftMove.origin.x = -200;
        fromView.frame = fromviewLeftMove;
        
    } completion:^(BOOL finished) {
        
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromView.layer.position    = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        fromView.layer.transform = CATransform3DIdentity;
        
        [shadow removeFromSuperview];
        
        //通知页面跳转动画已完成
        [transitionContext completeTransition:YES];
    }];
}

@end
