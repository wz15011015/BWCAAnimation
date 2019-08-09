//
//  CAAnimationHintViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2018/2/27.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "CAAnimationHintViewController.h"

@interface CAAnimationHintViewController () <CAAnimationDelegate>

@property (nonatomic, strong) UILabel *hintLabel1;
@property (nonatomic, strong) UILabel *hintLabel2;

@end

@implementation CAAnimationHintViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.hintLabel1.text = [NSString stringWithFormat:@"动画开始前,动画视图的frame:  %@", NSStringFromCGRect(self.animationImageView.frame)];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.animationImageView.layer removeAllAnimations];
}

- (void)setupUI {
    [super setupUI];
    
    CGFloat x = 10;
    CGFloat w = CGRectGetWidth(self.view.frame) - 2 * x;
    CGFloat h = 50;
    CGFloat y = CGRectGetMaxY(self.animationImageView.frame) + 20;
    self.hintLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.hintLabel1.numberOfLines = 0;
    self.hintLabel1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.hintLabel1];
    
    y = CGRectGetMaxY(self.hintLabel1.frame) + 5;
    self.hintLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.hintLabel2.numberOfLines = 0;
    self.hintLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.hintLabel2];
}

- (void)animationTransformScaleX {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.duration = 4.0;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:1.8];
    animation.delegate = self;
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    // 注意核心动画有个缺点:
    // Core Animation是直接作用在CALayer上的,并非UIView.
    //
    // 你所看到的view的变化都是假象，实际上view的属性根本没有发生改变,这就对实际开发造成不必要的麻烦。
    // 如:view上有几个按钮，在旋转时你想要点击的按钮(你看到view旋转，以为frame改变了)
    // 和view响应的按钮(实际上view.frame没变)可能就不是同一个。
    // 所以,这时尽量不用核心动画，可以用UIView封装的动画来实现类似的效果。
    
    NSLog(@"transfrom.scale.x 动画开始了");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        NSLog(@"transfrom.scale.x 动画正常结束了");
    } else {
        NSLog(@"transfrom.scale.x 动画被打断结束了");
    }
    self.hintLabel2.text = [NSString stringWithFormat:@"动画结束时,动画视图的frame:  %@", NSStringFromCGRect(self.animationImageView.frame)];
}


#pragma mark - Event

- (void)showAnimation {
    [super showAnimation];
    
    [self animationTransformScaleX];
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
