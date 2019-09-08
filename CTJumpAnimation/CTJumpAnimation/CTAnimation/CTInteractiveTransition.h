//
//  CTInteractiveTransition.h
//  CTJumpAnimation
//
//  Created by huangqun on 15/8/25.
//  Copyright (c) 2015年 HQ. All rights reserved.
//
//  分发处理页面过渡代理事件类
//
//  页面过渡类 统一以CT开头 代表Custom自定义
//

#import <Foundation/Foundation.h>

@interface CTInteractiveTransition : NSObject <UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

+(CTInteractiveTransition *)sharedInstance; /**< 自定义页面动画 单利 */

/**< 百分比推动互动过渡 */
@property (nonatomic, strong) CTPercentDrivenInteractiveTransition * percentInteractive;

@end
