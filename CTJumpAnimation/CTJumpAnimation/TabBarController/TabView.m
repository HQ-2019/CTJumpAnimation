//
//  TabView.m
//  loanStore
//
//  Created by huangqun on 15/2/10.
//  Copyright (c) 2015年 普惠金融. All rights reserved.
//

#import "TabView.h"

#define TAG 10000      //tabBar上button的tag基础值
#define UnreadTag 2000 //未读提示标记的tag基础值
#define TabBarCount 3  //tabBar上button的个数

@implementation TabView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

#pragma mark -
#pragma mark - 创建子视图
- (void)initSubviews
{
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    lineLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:lineLabel];
    
    for (int i = 0; i < TabBarCount; i++) {
        //创建按钮
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString * NormalImage   = [NSString stringWithFormat:@"tab_normal_%d.png", i];
        NSString * SelectedImage = [NSString stringWithFormat:@"tab_selected_%d.png", i];
        [button setImage:[UIImage imageNamed:NormalImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:SelectedImage] forState:UIControlStateSelected];
        button.tag = TAG+i;
        button.frame = CGRectMake((self.width/TabBarCount)*i, 0, self.width/TabBarCount, 49);
        [button addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (i == 0) {
            //启动时默认选中第一个
            button.selected = YES;
            self.lastButton = button;
        }
        
//        //创建未读消息提示
//        if (i == 0 || i == 2) {
//            UILabel * unreadMark = [[UILabel alloc] initWithFrame:CGRectMake(button.width/3*2, 8, 6, 6)];
//            unreadMark.backgroundColor = [UIColor getText_HighEmphasizeColor];
//            unreadMark.layer.masksToBounds = YES;
//            unreadMark.layer.cornerRadius = 3;
//            unreadMark.tag = UnreadTag + i;
//            unreadMark.hidden = YES;
//            [button addSubview:unreadMark];
//        }
    }
}

#pragma mark -
#pragma mark - tabBar 点击事件
- (void)tabBarButtonAction:(UIButton *)button
{
    //当前点击的按钮不是上次点击的
    if (self.lastButton != button) {
        //取消上次按钮的选中效果
        self.lastButton.selected = NO;
        self.lastIndex = self.lastButton.tag - TAG;
        //记录当前点击的按钮
        self.lastButton = button;
        button.selected = YES;
        
        //通过修改索引来切换tab控制器中的子控制器
        self.selectedIndex = button.tag - TAG;
        
        if ( self.tabViewClick ) {
            self.tabViewClick();
        }
    }
}

#pragma mark - 
#pragma mark - 显示或隐藏未读信息标记
- (void)changeUnreadMarkState:(BOOL)hidden forTag:(NSInteger)index
{
    UILabel * unreadMark = (UILabel *)[self viewWithTag:(index+UnreadTag)];
    if (unreadMark) {
        unreadMark.hidden = hidden;
    }
}

@end
