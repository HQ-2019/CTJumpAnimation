//
//  CTPresentTransition.m
//  CTJumpAnimation
//
//  Created by huangqun on 15/8/25.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "CTPresentTransition.h"

@implementation CTPresentTransition

#pragma mark -
#pragma mark - 设置自定义present跳转动效的持续时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

#pragma mark -
#pragma mark - 自定义present跳转的动效
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    //present实现效果
    //视图先缩放完成 在推出新视图 新视图到顶部后有
    UIViewController * fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC   = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * fromView = fromVC.view;
    UIView * toView  = toVC.view;
    
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    //给fromVC和toVC分别设置相同的起始frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = CGRectMake(0, initialFrame.size.height, initialFrame.size.width, initialFrame.size.height);
    
    //增加黑色透明层在fromView上
    UIView * shadow = [[UIView alloc]initWithFrame:fromView.bounds];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.0;
    [fromView addSubview:shadow];
    
    //设置过渡动画效果
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        shadow.alpha = 0.5;
        //fromView缩放
        fromView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toView.frame = CGRectMake(0, -10, initialFrame.size.width, initialFrame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                toView.frame = CGRectMake(0, 10, initialFrame.size.width, initialFrame.size.height);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    toView.frame = initialFrame;
                } completion:^(BOOL finished) {
                    [shadow removeFromSuperview];
                    //恢复视图的缩放
                    fromView.transform = CGAffineTransformIdentity;
                    //通知页面跳转动画已完成
                    [transitionContext completeTransition:YES];
                }];
            }];
        }];
    }];
}

@end
