//
//  PopTransition.m
//  CTJumpAnimation
//
//  Created by HQ on 15/8/23.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "CTPopTransition.h"

@implementation CTPopTransition

#pragma mark -
#pragma mark - 设置自定义pop跳转动效的持续时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.4f;
}

#pragma mark -
#pragma mark - 自定义pop跳转的动效
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * fromView = fromVC.view;
    UIView * toView   = toVC.view;
    
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    //增加透视的transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    //给fromVC和toVC分别设置相同的起始frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = initialFrame;
    
    //将toview先左移
//    CGRect toviewLeftMove = initialFrame;
//    toviewLeftMove.origin.x = -280;//initialFrame.size.width*(4/5);
//    toView.frame = toviewLeftMove;
    
    //增加黑色透明层在toview上
    UIView * shadow = [[UIView alloc]initWithFrame:toView.bounds];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.9;
    [toView addSubview:shadow];
    
    //改变View的锚点
    [self updateAnchorPointAndOffset:CGPointMake(0.8, 0.5) view:toView];
    
    //toView旋转45度
    toView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0.0, 1.0, 0.0);
    
    //将fromView在Z轴上往前移动 避免fromView和toview旋转时有交叉的部分视图被toview覆盖
    fromView.layer.zPosition = 50;
    //zPosition每50对应0.1的缩放量 如:50-->(1-0.1)、100-->(1-0.2)  确保zPosition改变后视图在视觉上不会出现变大或变小的现象
    fromView.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.9, 0.9, 0);
    
    //设置过渡动画效果
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        shadow.alpha = 0.2;
        
        //旋转toView45度 到平面效果
        toView.layer.transform = CATransform3DMakeRotation(0, 0, 1.0, 0);
        //pop时 fromView旋转1度 恢复到平面
        fromView.layer.transform = CATransform3DMakeRotation(-M_PI/18, 0, 1.0, 0.0);
        
        //toview向右移动
        CGRect toviewRightMove = initialFrame;
        toviewRightMove.origin.x = 0;
        toView.frame = toviewRightMove;
        
        //fromView向右移动
        CGRect fromviewRightMove = initialFrame;
        fromviewRightMove.origin.x = initialFrame.size.width;
        fromView.frame = fromviewRightMove;
        
    } completion:^(BOOL finished) {
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position    = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        
        //还原fromView的layer改动
        fromView.layer.zPosition = 0;
        fromView.layer.transform = CATransform3DIdentity;
        
//        shadow.alpha = 0.0;
        [shadow removeFromSuperview];
        

        //通知页面跳转动画已完成
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

//给传入的View改变锚点
-(void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView *)view{
    NSLog(@"1111::%f", CGRectGetMidY([UIScreen mainScreen].bounds));
    view.layer.anchorPoint = anchorPoint;
    view.layer.position    = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
}

@end
