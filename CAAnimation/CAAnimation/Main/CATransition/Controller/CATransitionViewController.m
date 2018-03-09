//
//  CATransitionViewController.m
//  CAAnimation
//
//  Created by ff on 2018/3/5.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "CATransitionViewController.h"
#import "Macro.h"

@interface CATransitionViewController ()

@property (nonatomic, strong) UIImageView *sceneImageView;

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 场景的背景图片
    self.sceneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    self.sceneImageView.image = [UIImage imageNamed:@"beautiful_scene_background"];
    self.sceneImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.sceneImageView];
    
    UISwipeGestureRecognizer *leftSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.sceneImageView addGestureRecognizer:leftSwipeGR];
    
    UISwipeGestureRecognizer *rightSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGR.direction = UISwipeGestureRecognizerDirectionRight;
    [self.sceneImageView addGestureRecognizer:rightSwipeGR];
}


#pragma mark - Event

// 向左滑动浏览下一张图片
- (void)leftSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    [self transitionAnimation:YES];
}

// 向右滑动浏览下一张图片
- (void)rightSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    [self transitionAnimation:NO];
}


#pragma mark - Transition Animation

- (void)transitionAnimation:(BOOL)isNext {
    if (isNext) {
        self.sceneImageView.image = [UIImage imageNamed:@"farmland"];
    } else {
        self.sceneImageView.image = [UIImage imageNamed:@"beautiful_scene_background"];
    }
    
    // 创建转场动画
    CATransition *transitionAnimation = [[CATransition alloc] init];
    // 设置动画类型
    transitionAnimation.type = @"cube";
    // 设置动画子类型
    if (isNext) {
        transitionAnimation.subtype = kCATransitionFromRight;
    } else {
        transitionAnimation.subtype = kCATransitionFromLeft;
    }
    transitionAnimation.duration = 1.0;
    [self.sceneImageView.layer addAnimation:transitionAnimation forKey:nil];
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
