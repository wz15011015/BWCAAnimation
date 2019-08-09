//
//  CAKeyframeAnimationViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2018/2/28.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "CAKeyframeAnimationViewController.h"

@interface CAKeyframeAnimationViewController () <CAAnimationDelegate>

@end

@implementation CAKeyframeAnimationViewController

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


#pragma mark - 不同KeyPath的图层动画

- (void)animation1 {
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.delegate = self;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // values是许多值组成的数组用来进行动画的。这个属性比较特别，只有在path属性值为nil的时候才起作用.
    animation.values = values;
    
    // path路径,可以指定一个路径,让动画沿着这个指定的路径执行。
//    animation.path = ;
    
    /**
           在关键帧动画中还有一个非常重要的参数,那便是calculationMode,计算模式.
           其主要针对的是每一帧的内容为一个座标点的情况,也就是对anchorPoint 和 position 进行的动画.
           当在平面座标系中有多个离散的点的时候,可以是离散的,也可以直线相连后进行插值计算,也可以
           使用圆滑的曲线将他们相连后进行插值计算.
     
           1）kCAAnimationLinear calculationMode的默认值,r自定义控制动画的时间（线性）
                可以设置keyTimes,表示当关键帧为座标点的时候,关键帧之间直接直线相连进行插值计算;
     
           2）kCAAnimationDiscrete 离散的,就是不进行插值计算,所有关键帧直接逐个进行显示;
     
           3）kCAAnimationPaced 节奏动画自动计算动画的运动时间,使得动画均匀进行,
                而不是按keyTimes设置的或者按关键帧平分时间,此时keyTimes和timingFunctions无效;
     
           4）kCAAnimationCubic 对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算,
                对于曲线的形状还可以通过tensionValues,continuityValues,biasValues来进行调整自定义,
                这里的数学原理是Kochanek–Bartels spline,这里的主要目的是使得运行的轨迹变得圆滑,
                曲线动画需要设置timingFunctions
     
           5）kCAAnimationCubicPaced 看这个名字就知道和kCAAnimationCubic有一定联系,
                其实就是在kCAAnimationCubic的基础上使得动画运行变得均匀,就是系统时间内运动的距离相同,
                此时keyTimes以及timingFunctions也是无效的.
           */
    
//    animation.calculationMode = ;
    
    // 为了在动画结束时,区分不同的动画而设置
    [animation setValue:@"transform1" forKey:@"AnimationKey"];
    
    [self.animationImageView.layer addAnimation:animation forKey:@"transform1"];
}

- (void)animation2 {
    // 路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 200, 200, 500)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 3.0;
    
    /**
          旋转样式:
             kCAAnimationRotateAuto 根据路径自动旋转
             kCAAnimationRotateAutoReverse 根据路径自动翻转
          */
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    animation.path = bezierPath.CGPath;
    
    [self.animationImageView.layer addAnimation:animation forKey:nil];
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    NSString *animationTypeStr = @"";
    // 区分不同的动画
    CAAnimation *transform1Anim = [self.animationImageView.layer animationForKey:@"transform1"];
    if ([anim isEqual:transform1Anim]) {
        animationTypeStr = @"transform1";
    }
    NSLog(@"%@ 动画开始了", animationTypeStr);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *animationTypeStr = @"";
    NSString *animationKey = [anim valueForKey:@"AnimationKey"];
    if ([animationKey isEqualToString:@"transform1"]) {
        animationTypeStr = @"transform1";
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
    
    if (self.type == 0) {
        [self animation1];
    } else if (self.type == 1) {
        [self animation2];
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
