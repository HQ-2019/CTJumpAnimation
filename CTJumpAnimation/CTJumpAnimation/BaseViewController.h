//
//  BaseViewController.h
//  CTJumpAnimation
//
//  Created by HQ on 15/8/22.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView * navigationBarView;       /**< 导航栏视图*/

/**
 *  push 新的视图控制器
 */
- (void)pushViewController:(UIViewController *)viewCtrl animated:(BOOL)animated;

@end
