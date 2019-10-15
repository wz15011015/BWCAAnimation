//
//  CASpringAnimationViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2019/08/09.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "CASpringAnimationViewController.h"

@interface CASpringAnimationViewController () <CAAnimationDelegate>

@end

@implementation CASpringAnimationViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     Core Animation是直接作用在CALayer上的,并非UIView.
     */
    
    [self setupUI];
    
    if (self.animationType == AnimationKeyPathTransformRotationX ||
        self.animationType == AnimationKeyPathTransformRotationY ||
        self.animationType == AnimationKeyPathTransformRotationZ ||
        self.animationType == AnimationKeyPathContents) {
        self.animationImageView.image = [UIImage imageNamed:@"Xcode_icon"];
        self.animationImageView.backgroundColor = [UIColor clearColor];
    } else if (self.animationType == AnimationKeyPathBorderColor) {
        self.animationImageView.layer.borderWidth = 4.0;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.animationImageView.layer removeAllAnimations];
}

- (void)setupUI {
    [super setupUI];
    
    [self.startAnimationButton setTitle:@"Start Spring Animation" forState:UIControlStateNormal];
}


#pragma mark - 不同KeyPath的图层动画

- (void)animationTransformScale {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    animation.delegate = self;
    animation.duration = 0.5;
    animation.repeatCount = 4;
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:1.4];
    
    // 弹性动画特有属性:
    
    // mass模拟的是质量,它会影响图层运动时的弹簧惯性,质量越大,弹簧拉伸和压缩的
    // 幅度越大,默认值为1,但必须比0大.
    animation.mass = 1;
    
    // 刚度系数(弹性系数/劲度系数),刚度系数越大,形变产生的力就越大,运动越快
    // 默认值为100,但必须比0大.
    animation.stiffness = 100;
    
    // 阻尼系数,阻止弹簧伸缩的系数,阻尼系数越大,停止的越快,默认值为10,但必须>=0.
    animation.damping = 10;
    
    // 初始速率,动画视图的初始速度大小,默认值为0.
    // 速率为正数时,速度方向与运动方向一致;为负数时,速度方向与运动方向相反.
    animation.initialVelocity = 10;
    
    // 估算时间, 弹簧动画开始到停止时的时间,根据当前的动画参数进行估算.
    NSLog(@"settlingDuration = %f", animation.settlingDuration);
    
    [animation setValue:@"TransformScaleKey" forKey:@"AnimationKey"];
    
    [self.animationImageView.layer addAnimation:animation forKey:@"TransformScale"];
}

- (void)animationTransformScaleX {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:1.8];
    [animation setValue:@"TransformScaleXKey" forKey:@"AnimationKey"];
    
    [self.animationImageView.layer addAnimation:animation forKey:@"TransformScaleX"];
}

- (void)animationTransformScaleY {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.scale.y"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:1.4];
    [animation setValue:@"TransformScaleYKey" forKey:@"AnimationKey"];
    
    [self.animationImageView.layer addAnimation:animation forKey:@"TransformScaleY"];
}

- (void)animationTransformRotationX {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.delegate = self;
    animation.duration = 1.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
    animation.toValue = [NSNumber numberWithFloat:0.4 * M_PI];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformRotationY {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.delegate = self;
    animation.duration = 1.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
    animation.toValue = [NSNumber numberWithFloat:0.4 * M_PI];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformRotationZ {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
    animation.toValue = [NSNumber numberWithFloat:0.4 * M_PI];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformTranslation {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.translation"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(20, 80)];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformTranslationX {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:-60];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformTranslationY {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:-60];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationContentsRectSizeWidth {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"contentsRect.size.width"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0.2];
    animation.toValue = [NSNumber numberWithFloat:0.7];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationContentsRectSizeHeight {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"contentsRect.size.height"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0.7];
    animation.toValue = [NSNumber numberWithFloat:0.4];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationBounds {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"bounds"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 160, 110)];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationPosition {
    CGFloat centerX = CGRectGetMidX(self.animationImageView.frame);
    CGFloat centerY = CGRectGetMidY(self.animationImageView.frame);
    
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX + 60, centerY + 120)];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationBackgroundColor {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"backgroundColor"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.autoreverses = YES;
    animation.fromValue = (id)[UIColor colorWithRed:71 / 255.0 green:183 / 255.0 blue:251 / 255.0 alpha:1.0].CGColor;
    animation.toValue = (id)[UIColor colorWithRed:133 / 255.0 green:219 / 255.0 blue:70 / 255.0 alpha:1.0].CGColor;
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationOpacity {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"opacity"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.4];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationContents {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"contents"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = (id)[UIImage imageNamed:@"Xcode_icon"].CGImage;
    animation.toValue = (id)[UIImage imageNamed:@"Siri_icon"].CGImage;
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationCornerRadius {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"cornerRadius"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = @(0);
    animation.toValue = @(20);

    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationBorderWidth {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"borderWidth"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = @(0.0);
    animation.toValue = @(4.0);
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationBorderColor {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"borderColor"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = (id)[UIColor blackColor].CGColor;
    animation.toValue = (id)[UIColor colorWithRed:133 / 255.0 green:219 / 255.0 blue:70 / 255.0 alpha:1.0].CGColor;
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    // 注意:
    // 把动画存储为一个属性,然后在代理方法中通过比较来判定是哪个动画的方法是不可行的.
    // 因为执行方法addAnimation:forKey:实际上是将CABasicAniamtion对象进行了
    // copy(深拷贝)操作的,所以代理方法中传回来的动画参数 anim 是原始值的一个深拷贝，不是同一个值.
    
    // 区分不同动画的方法
    NSString *animationTypeStr = @"";
    CAAnimation *transformScaleAnim = [self.animationImageView.layer animationForKey:@"TransformScale"];
    CAAnimation *transformScaleXAnim = [self.animationImageView.layer animationForKey:@"TransformScaleX"];
    CAAnimation *transformScaleYAnim = [self.animationImageView.layer animationForKey:@"TransformScaleY"];
    if ([anim isEqual:transformScaleAnim]) {
        animationTypeStr = @"transfrom.scale";
    } else if ([anim isEqual:transformScaleXAnim]) {
        animationTypeStr = @"transfrom.scale.x";
    } else if ([anim isEqual:transformScaleYAnim]) {
        animationTypeStr = @"transfrom.scale.y";
    }
    if (![animationTypeStr isEqualToString:@""]) {
        NSLog(@"%@ 弹性动画开始了", animationTypeStr);
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.startAnimationButton.enabled = YES;
    
    // flag参数表明了动画是自然结束还是被打断的,比如调用了removeAnimationForKey:方法
    // 或removeAnimationForKey方法，则flag为NO; 如果是正常结束的，则flag为YES。
    
    // 此时,不能再使用[self.animationImageView.layer animationForKey:@"TransformScale"]
    // 来区分不同的动画了,因为动画完成时已经把CAAnimation从layer上移除了,所以animationForKey:
    // 方法获取到的CAAnimation会一直为nil,不能用于判断.
    
    NSString *animationTypeStr = @"";
    NSString *animationKey = [anim valueForKey:@"AnimationKey"];
    if ([animationKey isEqualToString:@"TransformScaleKey"]) {
        animationTypeStr = @"transfrom.scale";
    } else if ([animationKey isEqualToString:@"TransformScaleXKey"]) {
        animationTypeStr = @"transfrom.scale.x";
    } else if ([animationKey isEqualToString:@"TransformScaleYKey"]) {
        animationTypeStr = @"transfrom.scale.y";
    }
    if (![animationTypeStr isEqualToString:@""]) {
        if (flag) {
            NSLog(@"%@ 弹性动画正常结束了", animationTypeStr);
        } else {
            NSLog(@"%@ 弹性动画被打断结束了", animationTypeStr);
        }
    }
}


#pragma mark - Event

- (void)showAnimation {
    [super showAnimation];
    
    self.startAnimationButton.enabled = NO;
    
    if (self.animationType == AnimationKeyPathTransformScale) {
        [self animationTransformScale];
    } else if (self.animationType == AnimationKeyPathTransformScaleX) {
        [self animationTransformScaleX];
    } else if (self.animationType == AnimationKeyPathTransformScaleY) {
        [self animationTransformScaleY];
    } else if (self.animationType == AnimationKeyPathTransformRotationX) {
        [self animationTransformRotationX];
    } else if (self.animationType == AnimationKeyPathTransformRotationY) {
        [self animationTransformRotationY];
    } else if (self.animationType == AnimationKeyPathTransformRotationZ) {
        [self animationTransformRotationZ];
    } else if (self.animationType == AnimationKeyPathTransformTranslation) {
        [self animationTransformTranslation];
    } else if (self.animationType == AnimationKeyPathTransformTranslationX) {
        [self animationTransformTranslationX];
    } else if (self.animationType == AnimationKeyPathTransformTranslationY) {
        [self animationTransformTranslationY];
    } else if (self.animationType == AnimationKeyPathContentsRectSizeWidth) {
        [self animationContentsRectSizeWidth];
    } else if (self.animationType == AnimationKeyPathContentsRectSizeHeight) {
        [self animationContentsRectSizeHeight];
    } else if (self.animationType == AnimationKeyPathBounds) {
        [self animationBounds];
    } else if (self.animationType == AnimationKeyPathPosition) {
        [self animationPosition];
    } else if (self.animationType == AnimationKeyPathBackgroundColor) {
        [self animationBackgroundColor];
    } else if (self.animationType == AnimationKeyPathOpacity) {
        [self animationOpacity];
    } else if (self.animationType == AnimationKeyPathContents) {
        [self animationContents];
    } else if (self.animationType == AnimationKeyPathCornerRadius) {
        [self animationCornerRadius];
    } else if (self.animationType == AnimationKeyPathBorderWidth) {
        [self animationBorderWidth];
    } else if (self.animationType == AnimationKeyPathBorderColor) {
        [self animationBorderColor];
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
