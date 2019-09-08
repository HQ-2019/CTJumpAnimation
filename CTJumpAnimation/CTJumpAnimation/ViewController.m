//
//  ViewController.m
//  CTJumpAnimation
//
//  Created by HQ on 15/8/22.
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"

#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(resetRootView) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)resetRootView
{
    UINavigationController * nv = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.window.rootViewController = nv;
    
}

@end
