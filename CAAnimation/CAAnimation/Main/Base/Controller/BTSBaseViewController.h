//
//  BTSBaseViewController.h
//  CAAnimation
//
//  Created by wangzhi on 2018/2/27.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 基控制器
 */
@interface BTSBaseViewController : UIViewController

@property (nonatomic, strong) UIImageView *animationImageView;

@property (nonatomic, strong) UIButton *startAnimationButton;


/**
 界面初始化
 */
- (void)setupUI;


#pragma mark - Event

/**
 点击事件 - 开始动画
 */
- (void)showAnimation;

@end
