//
//  CAAnimationGroupViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2019/08/09.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "CAAnimationGroupViewController.h"

@interface CAAnimationGroupViewController () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *handImageView;

@property (nonatomic, assign) CGPoint handPoint;
@property (nonatomic, assign) CGPoint clickPoint;

@end

@implementation CAAnimationGroupViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.animationImageView.layer removeAllAnimations];
}

- (void)setupUI {
    [super setupUI];
    
    [self.startAnimationButton setTitle:@"Start Group Animation" forState:UIControlStateNormal];
    
    CGFloat handW = 48;
    CGFloat handX = CGRectGetWidth(self.view.frame) - 10 - handW;
    CGFloat handY = CGRectGetHeight(self.view.frame) - 70 - handW;
    self.handImageView = [[UIImageView alloc] initWithFrame:CGRectMake(handX, handY, handW, handW)];
    self.handImageView.image = [UIImage imageNamed:@"hand_icon"];
    [self.view addSubview:self.handImageView];
    
    // 确定手的初始位置及点击位置
    self.handPoint = self.handImageView.center;
    self.clickPoint = self.animationImageView.center;
    
    self.handImageView.hidden = YES;
}


#pragma mark - Animation

/**
 开始执行动画组
 */
- (void)animationGroup1 {
    // 动画组类CAAnimationGroup,它是CAAnimation的子类,它可以保存
    // 一组动画,将CAAnimationGroup对象添加到图层后,组内所有动画可以同时执行.
    
    // 1. 创建动画组
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.delegate = self;
    aniGroup.duration = 1.5;
    aniGroup.autoreverses = YES;
    [aniGroup setValue:@"AnimationGroup" forKey:@"AnimationKey"];
    
    // 平移动画
    CGFloat centerX = CGRectGetMidX(self.animationImageView.frame);
    CGFloat centerY = CGRectGetMidY(self.animationImageView.frame);
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.delegate = self;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX + 60, centerY + 120)];
    
    // 缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.delegate = self;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.4];
    
    // 背景颜色动画
    CABasicAnimation *backgroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColorAnimation.delegate = self;
    backgroundColorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    backgroundColorAnimation.fromValue = (id)[UIColor colorWithRed:71 / 255.0 green:183 / 255.0 blue:251 / 255.0 alpha:1.0].CGColor;
    backgroundColorAnimation.toValue = (id)[UIColor colorWithRed:133 / 255.0 green:219 / 255.0 blue:70 / 255.0 alpha:1.0].CGColor;
    
    // 2. 添加动画到动画组
    aniGroup.animations = @[ positionAnimation, scaleAnimation, backgroundColorAnimation ];
    
    // 3. 添加动画组到图层
    [self.animationImageView.layer addAnimation:aniGroup forKey:@"AnimationGroup1Key"];
}

/**
 开始执行一组动画
 */
- (void)animationGroup2 {
    self.handImageView.hidden = NO;

    // 一组动画,顺序执行一系列的动画,如:
    // 手移入动画 --> 手点击动画、响应点击动画 --> 手移出动画
    
    // 开始执行手进入动画
    [self handInAnimation];
}

/**
 手移入动画
 */
- (void)handInAnimation {
    // 1. 创建动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    animation.duration = 2.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [animation setValue:@"AnimationHandIn" forKey:@"AnimationKey"];
    
    // 2. 创建动画路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:self.handPoint];
    [path addLineToPoint:self.clickPoint];
    
    // 3. 设置动画路径
    animation.path = path.CGPath;
    
    // 4. 添加动画到图层
    [self.handImageView.layer addAnimation:animation forKey:nil];
}

/**
 手点击动画
 */
- (void)handClickAnimation {
    // 1. 创建动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.duration = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [animation setValue:@"AnimationHandClick" forKey:@"AnimationKey"];
    
    NSArray *values = @[
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                        ];
    animation.values = values;
    
    // 2. 添加动画到图层
    [self.handImageView.layer addAnimation:animation forKey:nil];
}

/**
 手点击后的响应动画 (背景颜色变化)
 */
- (void)handClickResponseAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.delegate = self;
    animation.duration = 2.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = (id)[UIColor colorWithRed:71 / 255.0 green:183 / 255.0 blue:251 / 255.0 alpha:1.0].CGColor;
    animation.toValue = (id)[UIColor colorWithRed:133 / 255.0 green:219 / 255.0 blue:70 / 255.0 alpha:1.0].CGColor;
    [animation setValue:@"AnimationHandClickResponse" forKey:@"AnimationKey"];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

/**
 手移出动画
 */
- (void)handOutAnimation {
    // 1. 创建动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    animation.duration = 2.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.beginTime = CACurrentMediaTime() + 0.5; // 0.5s后再执行移出动画
    [animation setValue:@"AnimationHandOut" forKey:@"AnimationKey"];
    
    // 2. 创建动画路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:self.clickPoint];
    [path addLineToPoint:self.handPoint];
    
    // 3. 设置动画路径
    animation.path = path.CGPath;
    
    // 4. 添加动画到图层
    [self.handImageView.layer addAnimation:animation forKey:nil];
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    NSString *animationKey = [anim valueForKey:@"AnimationKey"];
    if ([animationKey isEqualToString:@"AnimationGroup"]) {
        NSLog(@"组动画开始了");
    } else if ([animationKey isEqualToString:@"AnimationHandIn"]) {
        NSLog(@"手 开始移入...");
    } else if ([animationKey isEqualToString:@"AnimationHandClick"]) {
        NSLog(@"手 开始点击...");
    } else if ([animationKey isEqualToString:@"AnimationHandClickResponse"]) {
        NSLog(@"手 点击后响应...");
    } else if ([animationKey isEqualToString:@"AnimationHandOut"]) {
        NSLog(@"手 开始移出...");
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    // flag参数表明了动画是自然结束还是被打断的,比如调用了removeAnimationForKey:方法
    // 或removeAnimationForKey方法，flag为NO，如果是正常结束，flag为YES。
    
    // 此时,不能再使用[self.animationImageView.layer animationForKey:@"TransformScale"]
    // 来区分不同的动画了,因为动画完成时已经把CAAnimation从layer上移除了,
    // 所以[ animationForKey:]方法获取到的CAAnimation会一直为nil,不能用于判断.
    
    NSString *animationKey = [anim valueForKey:@"AnimationKey"];
    if ([animationKey isEqualToString:@"AnimationGroup"]) {
        if (flag) {
            NSLog(@"组动画正常结束了");
        } else {
            NSLog(@"组动画被打断结束了");
        }
        
    } else if ([animationKey isEqualToString:@"AnimationHandIn"]) {
        [self handClickAnimation];
        
    } else if ([animationKey isEqualToString:@"AnimationHandClick"]) {
        [self handOutAnimation];
        [self handClickResponseAnimation];
        
    } else if ([animationKey isEqualToString:@"AnimationHandOut"]) {
        // 当手的所有动画结束后,从其图层中移除所有动画,以释放动画的delegate对象
        [self.handImageView.layer removeAllAnimations];
    }
}


#pragma mark - Event

- (void)showAnimation {
    [super showAnimation];
    
    if (self.animationType == 1) {
        [self animationGroup1];
    } else if (self.animationType == 2) {
        [self animationGroup2];
    }
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
