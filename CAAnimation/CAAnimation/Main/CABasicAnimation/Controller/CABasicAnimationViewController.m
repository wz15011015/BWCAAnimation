//
//  CABasicAnimationViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2018/2/27.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "CABasicAnimationViewController.h"

@interface CABasicAnimationViewController () <CAAnimationDelegate>

@end

@implementation CABasicAnimationViewController

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


#pragma mark - 不同KeyPath的图层动画

- (void)animationTransformScale {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画的持续时间,默认为0.25秒
    animation.duration = 0.5;
    
    // 动画的时间,在该时间内动画一直执行,不计次数
    animation.repeatDuration = 4;
    
    // 动画的重复次数
//    animation.repeatCount = 4;
    
    // 速度 speed = 1.0 / duration = 1.0 的动画效果 和 speed = 2.0 / duration = 2.0 的动画效果是一模一样的，我们设置的duration可能和动画进行的真实duration不一样，这个还依赖于speed。
    // 如果同时设置了动画的speed和layer的speed，则实际的speed为两者相乘.
//    animation.speed = 1.0;
    
    // 动画的速度变化,一般使用kCAMediaTimingFunctionEaseInEaseOut即可
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // 动画结束时是否执行逆动画,默认为NO
    animation.autoreverses = YES;
    
    // 动画的开始时间,如果需要延迟几秒的话,则设置为:CACurrentMediaTime() + 秒数 即可.
//    animation.beginTime = CACurrentMediaTime() + 1;
    
    /**
           timeOffset 设置动画线的起始结束时间点
           假定一个3s的动画，它的状态为t0,t1,t2,t3，当没有timeOffset的时候，正常的状态序列应该为：
           t0->t1->t2->t3
           当设置timeOffset为1的时候状态序列就变为
           t1->t2->t3->t0
           同理当timeOffset为2的时候状态序列就变为：
           t2->t3->t0->t1
           */
//    animation.timeOffset = 0;
    
    // 动画在开始和结束时的动作,默认值是kCAFillModeRemoved
//    animation.fillMode = kCAFillModeRemoved;
    
    // 动画执行完毕后是否从图层上移除，默认为YES. 若移除,则图形会恢复到动画执行前的状态。
    // 如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode属性为kCAFillModeForwards
//    animation.removedOnCompletion = YES;
    
    /**
           fromValue = 1.0  toValue = 1.5  byValue = 0.6;
     
           1> fromValue和toValue非空时,所改变属性的值的变化为:1.0 --> 1.5
           2> fromValue和byValue非空时,所改变属性的值的变化为:1.0 --> (1.0 + 0.6)
           3> byValue和toValue非空时,所改变属性的值的变化为:(1.0 - 0.6) --> 1.5
           4> fromValue非空时,所改变属性的值的变化为:1.0 --> 当前该属性的值
           5> toValue非空时,所改变属性的值的变化为:当前该属性的值 --> 1.5
           6> byValue非空时,所改变属性的值的变化为:当前该属性的值 --> (当前该属性的值 + 0.6)
           */
    // 所改变属性的起始值
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    
    // 所改变属性的结束值
    animation.toValue = [NSNumber numberWithFloat:1.4];
    
    // 所改变属性相同起始值的改变量
//    animation.byValue = [NSNumber numberWithFloat:0.5];
    
    // 代理
    animation.delegate = self;
    
    // 为了在动画结束时,区分不同的动画而设置
    [animation setValue:@"TransformScale" forKey:@"AnimationKey"];
    
    // 1. 一个CABasicAniamtion的实例对象只是一个数据模型，和他绑定到哪一个layer上是没有关系的;
    // 2. 方法addAnimation:forKey:是将 CABasicAniamtion 对象进行了 copy 操作的。
    // 所以在将其添加到一个layer上之后，我们还是可以将其再次添加到另一个layer上的。
    [self.animationImageView.layer addAnimation:animation forKey:@"TransformScale"];
}

- (void)animationTransformScaleX {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:1.8];
    animation.delegate = self;
    [animation setValue:@"TransformScaleX" forKey:@"AnimationKey"];
    
    [self.animationImageView.layer addAnimation:animation forKey:@"TransformScaleX"];
}

- (void)animationTransformScaleY {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:1.4];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformRotationX {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.duration = 1.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
    animation.toValue = [NSNumber numberWithFloat:0.4 * M_PI];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformRotationY {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.duration = 1.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
    animation.toValue = [NSNumber numberWithFloat:0.4 * M_PI];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformRotationZ {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
    animation.toValue = [NSNumber numberWithFloat:0.4 * M_PI];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformTranslation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(20, 80)];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformTranslationX {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:-60];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationTransformTranslationY {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:-60];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationContentsRectSizeWidth {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contentsRect.size.width"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0.2];
    animation.toValue = [NSNumber numberWithFloat:0.7];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationContentsRectSizeHeight {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contentsRect.size.height"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:0.7];
    animation.toValue = [NSNumber numberWithFloat:0.4];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationBounds {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
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
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX + 60, centerY + 120)];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationBackgroundColor {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.autoreverses = YES;
    animation.fromValue = (id)[UIColor colorWithRed:71 / 255.0 green:183 / 255.0 blue:251 / 255.0 alpha:1.0].CGColor;
    animation.toValue = (id)[UIColor colorWithRed:133 / 255.0 green:219 / 255.0 blue:70 / 255.0 alpha:1.0].CGColor;
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationOpacity {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.4];
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationContents {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = (id)[UIImage imageNamed:@"Xcode_icon"].CGImage;
    animation.toValue = (id)[UIImage imageNamed:@"Siri_icon"].CGImage;
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationCornerRadius {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = @(0);
    animation.toValue = @(20);

    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationBorderWidth {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = @(0.0);
    animation.toValue = @(4.0);
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}

- (void)animationBorderColor {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.fromValue = (id)[UIColor blackColor].CGColor;
    animation.toValue = (id)[UIColor colorWithRed:133 / 255.0 green:219 / 255.0 blue:70 / 255.0 alpha:1.0].CGColor;
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    // Note:把动画存储为一个属性然后再回调中比较，用来判定是哪个动画的方法是不可行的,
    // 因为委托传入的动画参数是原始值的一个深拷贝，不是同一个值.
    
    NSString *animationTypeStr = @"";
    // 区分不同的动画
    CAAnimation *transformScaleAnim = [self.animationImageView.layer animationForKey:@"TransformScale"];
    CAAnimation *transformScaleYAnim = [self.animationImageView.layer animationForKey:@"TransformScaleX"];
    
    if ([anim isEqual:transformScaleAnim]) {
        animationTypeStr = @"transfrom.scale";
    } else if ([anim isEqual:transformScaleYAnim]) {
        animationTypeStr = @"transfrom.scale.x";
    }
    NSLog(@"%@ 动画开始了", animationTypeStr);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    // flag参数表明了动画是自然结束还是被打断的,比如调用了removeAnimationForKey:方法
    // 或removeAnimationForKey方法，flag为NO，如果是正常结束，flag为YES。
    
    // 此时,不能再使用[self.animationImageView.layer animationForKey:@"TransformScale"]
    // 来区分不同的动画了,因为动画完成时已经把CAAnimation从layer上移除了,
    // 所以[ animationForKey:]方法获取到的CAAnimation会一直为nil,不能用于判断.
    
    NSString *animationTypeStr = @"";
    NSString *animationKey = [anim valueForKey:@"AnimationKey"];
    if ([animationKey isEqualToString:@"TransformScale"]) {
        animationTypeStr = @"transfrom.scale";
    } else if ([animationKey isEqualToString:@"TransformScaleX"]) {
        animationTypeStr = @"transfrom.scale.x";
    }
    if (flag) {
        NSLog(@"%@ 动画正常结束了", animationTypeStr);
    } else {
        NSLog(@"%@ 动画被打断结束了", animationTypeStr);
    }
}


#pragma mark - Event

- (void)showAnimation {
    [super showAnimation];
    
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
