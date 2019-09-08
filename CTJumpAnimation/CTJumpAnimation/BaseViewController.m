//
//  BaseViewController.m
//  CTJumpAnimation
//
//  Created by HQ on 15/8/22.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "BaseViewController.h"
#import "MainViewController.h"

#import "AppDelegate.h"

@interface BaseViewController ()
{
    CTPercentDrivenInteractiveTransition * interactive;
}

@end

@implementation BaseViewController

- (void)dealloc
{
    NSLog(@" %@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    self.navigationBarView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    [self.view addSubview:self.navigationBarView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@" %@ WillAppear", NSStringFromClass([self class]));
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@" %@ DidAppear", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@" %@ WillDisappear", NSStringFromClass([self class]));
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@" %@ DidDisappear", NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 
#pragma mark - push视图控制器
- (void)pushViewController:(UIViewController *)viewCtrl animated:(BOOL)animated
{
    if (animated) {
        //添加页面的百分比推动互动过渡识别 设置导航器代理
        interactive = [CTPercentDrivenInteractiveTransition new];
        [interactive addGestureRecognizer:viewCtrl];
        [CTInteractiveTransition sharedInstance].percentInteractive = interactive;
        self.navigationController.delegate = [CTInteractiveTransition sharedInstance];
    } else {
        //不使用动画
        [CTInteractiveTransition sharedInstance].percentInteractive = nil;
        self.navigationController.delegate = nil;
    }
    [self.navigationController pushViewController:viewCtrl animated:animated];
}

@end
