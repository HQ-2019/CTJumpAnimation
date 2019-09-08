//
//  CTDismissTransition.m
//  CTJumpAnimation
//
//  Created by huangqun on 15/8/25.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "CTDismissTransition.h"

@implementation CTDismissTransition

#pragma mark -
#pragma mark - 设置自定义dismiss跳转动效的持续时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.8f;
}

#pragma mark -
#pragma mark - 自定义dismiss跳转的动效
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    //dismiss实现效果
    //视图先下移视图 后面视图放大显示
    UIViewController * fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC   = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * fromView = fromVC.view;
    UIView * toView  = toVC.view;
    
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    //给fromVC和toVC分别设置相同的起始frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = CGRectMake(0, 0, initialFrame.size.width, initialFrame.size.height);
    
    //增加黑色透明层在toView上
    UIView * shadow = [[UIView alloc]initWithFrame:fromView.bounds];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.5;
    [toView addSubview:shadow];
    
    //toView缩放
    toView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    
    //设置过渡动画效果
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        fromView.frame = CGRectMake(0, -5, initialFrame.size.width, initialFrame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            fromView.frame = CGRectMake(0, 5, initialFrame.size.width, initialFrame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                fromView.frame = CGRectMake(0, -5, initialFrame.size.width, initialFrame.size.height);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    fromView.frame = CGRectMake(0, 0, initialFrame.size.width, initialFrame.size.height);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        fromView.frame = CGRectMake(0, initialFrame.size.height, initialFrame.size.width, initialFrame.size.height);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                            shadow.alpha = 0.0;
                            //fromView缩放
                            toView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                        } completion:^(BOOL finished) {
                            [shadow removeFromSuperview];
                            toView.transform = CGAffineTransformIdentity;
                            //通知页面跳转动画已完成
                            [transitionContext completeTransition:YES];
                        }];
                    }];
                }];
            }];
        }];
    }];
//    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        fromView.frame = CGRectMake(0, initialFrame.size.height, initialFrame.size.width, initialFrame.size.height);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
//            shadow.alpha = 0.0;
//            //fromView缩放
//            toView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
//        } completion:^(BOOL finished) {
//            [shadow removeFromSuperview];
//            toView.transform = CGAffineTransformIdentity;
//            //通知页面跳转动画已完成
//            [transitionContext completeTransition:YES];
//        }];
//    }];
}

@end
