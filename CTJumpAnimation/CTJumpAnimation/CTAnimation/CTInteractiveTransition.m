//
//  CTInteractiveTransition.m
//  CTJumpAnimation
//
//  Created by huangqun on 15/8/25.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "CTInteractiveTransition.h"

@interface CTInteractiveTransition ()
@property (nonatomic, strong) CTPushTransition * pushTransition;            /**< push动画 */
@property (nonatomic, strong) CTPopTransition  * popTransition;             /**< pop动画  */
@property (nonatomic, strong) CTDismissTransition * dismissTransition;      /**< present动画 */
@property (nonatomic, strong) CTPresentTransition * presentTransition;      /**< dismiss动画 */

@end

@implementation CTInteractiveTransition

+(CTInteractiveTransition *)sharedInstance
{
    static CTInteractiveTransition * sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[CTInteractiveTransition alloc] init];
    });
    
    return sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.pushTransition    = [[CTPushTransition alloc] init];
        self.popTransition     = [[CTPopTransition alloc] init];
        self.presentTransition = [[CTPresentTransition alloc] init];
        self.dismissTransition = [[CTDismissTransition alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark - UINavigationControllerDelegate  push&pop 页面过渡代理事件 自定义过渡动画
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    //返回页面过渡的动画效果
    if (operation == UINavigationControllerOperationPush) {
        return self.pushTransition;
    } else if (operation == UINavigationControllerOperationPop){
        return self.popTransition;
    } else{
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    //返回的对象配置的交互性方面过渡 返回nil时无手势百分比的互动效果
    NSLog(@"--- %@", self.percentInteractive);
    return self.percentInteractive.interacting ? self.percentInteractive : nil;
}


#pragma mark - 
#pragma mark - UIViewControllerTransitioningDelegate  present&dismiss 页面过渡代理事件 自定义过渡动画
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentTransition;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissTransition;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    //返回的对象配置的交互性方面过渡 返回nil时无手势百分比的互动效果
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    //返回的对象配置的交互性方面过渡 返回nil时无手势百分比的互动效果
    return nil;
}

@end
