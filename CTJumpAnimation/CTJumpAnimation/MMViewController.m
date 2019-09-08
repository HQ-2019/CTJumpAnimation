//
//  MMViewController.m
//  CTJumpAnimation
//
//  Created by huangqun on 15/8/24.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 150, 100, 50);
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor redColor];
    button1.frame = CGRectMake(100, 250, 100, 50);
    [button1 setTitle:@"pop" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
