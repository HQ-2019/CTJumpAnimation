//
//  MViewController.m
//  CTJumpAnimation
//
//  Created by huangqun on 15/8/24.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "MViewController.h"
#import "MMViewController.h"

#import "AppDelegate.h"

@interface MViewController ()

@end

@implementation MViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    //本页面有模态推出 需要重新设置导航栏的代理
    self.navigationController.navigationBarHidden = YES;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 150, 100, 50);
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor redColor];
    button1.frame = CGRectMake(100, 250, 100, 50);
    [button1 setTitle:@"dismiss" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)push
{
    [self pushViewController:[MMViewController new] animated:YES];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
