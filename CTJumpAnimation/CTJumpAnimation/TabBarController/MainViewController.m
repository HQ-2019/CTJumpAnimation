//
//  MainViewController.m
//  loanStore
//
//  Created by huangqun on 15/2/10.
//  Copyright (c) 2015年 普惠金融. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

#define TAG 10000      //tabBar上button的tag基础值
#define TabBarCount 3  //tabBar上button的个数

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏系统的导航栏
    self.navigationController.navigationBarHidden = YES;
    
    //创建tabBar
    [self initTabBar];
    //初始化子视图控制器
    [self initViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    self.navigationController.delegate = appDelegate;
//    self.navigationController.transitioningDelegate = appDelegate;
//    self.navigationController.delegate = [CTInteractiveTransition sharedInstance];

}

#pragma mark -
#pragma mark - 自定义tabBar样式
- (void)initTabBar
{
    self.tabView = [[TabView alloc] initWithFrame:CGRectMake(0, self.view.height - 49, self.view.width, 49)];
    self.tabView.bottom = self.view.bottom;
    self.tabView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.tabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tabView];
    
    //tabBar点击回调事件
    __weak MainViewController * bself = self;
    self.tabView.tabViewClick = ^(void){
        //先移除上次显示的视图
        [bself removeLastView:bself.tabView.lastIndex];

        //添加当前选中的视图
        [bself showSeletcedView:bself.tabView.selectedIndex];
    };
}

#pragma mark -
#pragma mark - 加载控制器
- (void)initViewController
{
    _firstView  = [[FViewController alloc] init];
    _secondView = [[SViewController alloc] init];
    _thirdView  = [[TViewController alloc] init];
    
    self.viewContorllers = [[NSMutableArray alloc] initWithObjects:_firstView, _secondView, _thirdView, nil];
    
    //默认显示第一个视图
    [self showSeletcedView:0];
}

#pragma mark -
#pragma mark - 移除上次点击tabBar对应的视图
- (void)removeLastView:(NSInteger)index {
    UIViewController * cotrl = [self.viewContorllers objectAtIndex:index];
    [cotrl removeFromParentViewController];
    [cotrl.view removeFromSuperview];
}

#pragma mark -
#pragma mark - 显示当前点击tabBar对应的视图
- (void)showSeletcedView:(NSInteger)index
{
    UIViewController * cotrl = [self.viewContorllers objectAtIndex:index];
    cotrl.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - 49);
    [self addChildViewController:cotrl];
    [self.view insertSubview:cotrl.view belowSubview:self.tabView];
    self.tabView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
}


@end
