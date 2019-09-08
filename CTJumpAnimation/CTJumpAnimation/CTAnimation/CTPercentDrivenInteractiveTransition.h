//
//  PercentDrivenInteractiveTransition.h
//  CTJumpAnimation
//
//  Created by HQ on 15/8/22.
//  Copyright (c) 2015年 HQ. All rights reserved.
//
//  百分比推动互动过渡
//

#import <UIKit/UIKit.h>

@interface CTPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
{
    UIViewController * _presentedVC;
}

@property(nonatomic, assign) BOOL interacting;              /**< 当前的手势是否作用到视图交互效果上 */

/**
 *  给推出的视图控制器添加侧滑返回上一级的手势识别
 *  viewController: 需要呈现的视图控制器
 */
- (void)addGestureRecognizer:(UIViewController *)viewController;

@end
