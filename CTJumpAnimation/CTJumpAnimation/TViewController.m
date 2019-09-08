//
//  TViewController.m
//  CTJumpAnimation
//
//  Created by HQ on 15/8/22.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "TViewController.h"
#import "MViewController.h"

@interface TViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation TViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 250, 100, 50);
    [button setTitle:@"pop" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor redColor];
    button1.frame = CGRectMake(100, 150, 100, 50);
    [button1 setTitle:@"model" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(modal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)modal
{
    MViewController * m = [[MViewController alloc] init];
    UINavigationController * na = [[UINavigationController alloc] initWithRootViewController:m];
    na.transitioningDelegate = [CTInteractiveTransition sharedInstance];
    [self presentViewController:na animated:YES completion:nil];
}

- (void)pop
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
