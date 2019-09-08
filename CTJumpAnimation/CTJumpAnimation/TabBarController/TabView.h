//
//  TabView.h
//  loanStore
//
//  Created by huangqun on 15/2/10.
//  Copyright (c) 2015年 普惠金融. All rights reserved.
//
//  tabBar视图
//

#import <UIKit/UIKit.h>

typedef void(^TabViewClick)(void);

@interface TabView : UIView

@property (nonatomic, strong) UIButton * lastButton;            //记录最后点击的按钮
@property (nonatomic, assign) NSInteger lastIndex;              //记录上次点击的按钮的tag值
@property (nonatomic, assign) NSInteger selectedIndex;          //记录当前点击的按钮的tag值
@property (nonatomic, copy) TabViewClick tabViewClick;          //点击回调block

/*
 *  显示或隐藏未读信息标记
 *  hidden: 为YES则隐藏  为NO则显示
 *  index : 未读标记的tag值(不包含基础值)
 */
- (void)changeUnreadMarkState:(BOOL)hidden forTag:(NSInteger)index;

@end
