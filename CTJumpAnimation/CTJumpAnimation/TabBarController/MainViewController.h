//
//  MainViewController.h
//  loanStore
//
//  Created by huangqun on 15/2/10.
//  Copyright (c) 2015年 普惠金融. All rights reserved.
//
//  自定义tabBar控制器
//

#import <UIKit/UIKit.h>
#import "FViewController.h"
#import "SViewController.h"
#import "TViewController.h"
#import "TabView.h"

@interface MainViewController : UIViewController <UINavigationControllerDelegate>
{
@private
    FViewController * _firstView;
    SViewController * _secondView;
    TViewController * _thirdView;
}
@property (nonatomic, strong) TabView * tabView;                //自定义tabBar视图
@property (nonatomic, strong) UIButton * lastButton;            //记录最后点击的按钮
@property (nonatomic, strong) NSMutableArray * viewContorllers; //存放子控制器
@property (nonatomic, assign) NSInteger selectedIndex;          //标记当前显示控制器视图在数组中的索引

@property (nonatomic, strong) CTPercentDrivenInteractiveTransition * percentInteractive;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
