//
//  BTSBaseViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2018/2/27.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "BTSBaseViewController.h"
#import "Macro.h"

@interface BTSBaseViewController ()

@end

@implementation BTSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    } else {
        // Fallback on earlier versions
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 界面初始化
 */
- (void)setupUI {
    [self.view addSubview:self.animationImageView];
    [self.view addSubview:self.startAnimationButton];
}


#pragma mark - Event

/**
 点击事件 - 开始动画
 */
- (void)showAnimation {
    
}


#pragma mark - Getters

- (UIImageView *)animationImageView {
    if (!_animationImageView) {
        CGFloat w = 100;
        CGFloat x = (WIDTH - w) / 2.0;
        CGFloat y = (HEIGHT - w) / 2.0;
        _animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, w)];
        _animationImageView.backgroundColor = [UIColor colorWithRed:71 / 255.0 green:183 / 255.0 blue:251 / 255.0 alpha:1.0];
    }
    return _animationImageView;
}

- (UIButton *)startAnimationButton {
    if (!_startAnimationButton) {
        _startAnimationButton = [UIButton buttonWithType:UIButtonTypeSystem];
        CGFloat w = 200;
        CGFloat x = (WIDTH - w) / 2.0;
        CGFloat y = HEIGHT - 44 - 44;
        _startAnimationButton.frame = CGRectMake(x, y, w, 44);
        [_startAnimationButton setTitle:@"Start Animation" forState:UIControlStateNormal];
        [_startAnimationButton addTarget:self action:@selector(showAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startAnimationButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
