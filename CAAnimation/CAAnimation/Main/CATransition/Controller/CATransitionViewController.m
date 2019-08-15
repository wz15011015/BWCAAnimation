//
//  CATransitionViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2018/3/5.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "CATransitionViewController.h"
#import "Macro.h"

@interface CATransitionViewController ()

@property (nonatomic, strong) UIImageView *sceneImageView;

@end

@implementation CATransitionViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 场景的背景图片
    self.sceneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    self.sceneImageView.image = [UIImage imageNamed:@"Mojave"];
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
        self.sceneImageView.image = [UIImage imageNamed:@"Mojave"];
    }
    
    /**
          * 系统公开的动画效果:
          * kCATransitionFade  淡出效果
          * kCATransitionMoveIn  新视图移动到旧视图上
          * kCATransitionPush  新视图推出旧视图
          * kCATransitionReveal  移开旧视图显示新视图
          *
          * 一些系统未公开的动画效果:
          * 1. cube
          * 2. suckEffect
          * 3. rippleEffect
          * 4. pageCurl
          * 5. pageUnCurl
          * 6. oglFlip
          * 7. cameraIrisHollowOpen
          * 8. cameraIrisHollowClose
          * 9. spewEffect
          * 10. genieEffect
          * 11. unGenieEffect
          * 12. twist
          * 13. tubey
          * 14. swirl
          * 15. charminUltra
          * 16. zoomyIn
          * 17. zoomyOut
          * 18. oglApplicationSuspend
          */
    NSString *transitionType = @"cube";
    if (self.type == TransitionAnimationkCATransitionFade) {
        transitionType = kCATransitionFade;
    } else if (self.type == TransitionAnimationkCATransitionMoveIn) {
        transitionType = kCATransitionMoveIn;
    } else if (self.type == TransitionAnimationkCATransitionPush) {
        transitionType = kCATransitionPush;
    } else if (self.type == TransitionAnimationkCATransitionReveal) {
        transitionType = kCATransitionReveal;
    } else if (self.type == TransitionAnimationCube) {
        transitionType = @"cube";
    } else if (self.type == TransitionAnimationSuckEffect) {
        transitionType = @"suckEffect";
    } else if (self.type == TransitionAnimationRippleEffect) {
        transitionType = @"rippleEffect";
    } else if (self.type == TransitionAnimationPageCurl) {
        transitionType = @"pageCurl";
    } else if (self.type == TransitionAnimationPageUnCurl) {
        transitionType = @"pageUnCurl";
    } else if (self.type == TransitionAnimationOglFlip) {
        transitionType = @"oglFlip";
    } else if (self.type == TransitionAnimationCameraIrisHollowOpen) {
        transitionType = @"cameraIrisHollowOpen";
    } else if (self.type == TransitionAnimationCameraIrisHollowClose) {
        transitionType = @"cameraIrisHollowClose";
    } else if (self.type == TransitionAnimationSpewEffect) {
        transitionType = @"spewEffect";
    } else if (self.type == TransitionAnimationGenieEffect) {
        transitionType = @"genieEffect";
    } else if (self.type == TransitionAnimationUnGenieEffect) {
        transitionType = @"unGenieEffect";
    } else if (self.type == TransitionAnimationTwist) {
        transitionType = @"twist";
    } else if (self.type == TransitionAnimationTubey) {
        transitionType = @"tubey";
    } else if (self.type == TransitionAnimationSwirl) {
        transitionType = @"swirl";
    } else if (self.type == TransitionAnimationCharminUltra) {
        transitionType = @"charminUltra";
    } else if (self.type == TransitionAnimationZoomyIn) {
        transitionType = @"zoomyIn";
    } else if (self.type == TransitionAnimationZoomyOut) {
        transitionType = @"zoomyOut";
    } else if (self.type == TransitionAnimationOglApplicationSuspend) {
        transitionType = @"oglApplicationSuspend";
    }
    
    // 创建转场动画
    CATransition *transitionAnimation = [[CATransition alloc] init];
    // 设置动画类型
    transitionAnimation.type = transitionType;
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
