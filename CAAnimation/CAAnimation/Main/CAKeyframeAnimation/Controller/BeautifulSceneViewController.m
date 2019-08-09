//
//  BeautifulSceneViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2018/3/5.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "BeautifulSceneViewController.h"
#import "Macro.h"

@interface BeautifulSceneViewController () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *sceneImageView;

@property (nonatomic, strong) CALayer *petalLayer; // 花瓣图层

@end

@implementation BeautifulSceneViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 场景的背景图片
    self.sceneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.sceneImageView.image = [UIImage imageNamed:@"beautiful_scene_background"];
    [self.view addSubview:self.sceneImageView];
    
    // 花瓣图层
    self.petalLayer = [[CALayer alloc] init];
    self.petalLayer.bounds = CGRectMake(0, 0, 18, 28);
    self.petalLayer.position = CGPointMake(60, 240);
    self.petalLayer.anchorPoint = CGPointMake(0.5, 0.6);
    self.petalLayer.contents = (id)[UIImage imageNamed:@"beautiful_petal"].CGImage;
    [self.view.layer addSublayer:self.petalLayer];
    
    
    // 开始关键帧动画
    [self translationKeyframeAnimation];
}


#pragma mark - 平移动画

- (void)translationAnimationWithLocation:(CGPoint)location {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 5.0;
    animation.toValue = [NSValue valueWithCGPoint:location];
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    // 存储终点位置,在动画结束后使用
    [animation setValue:animation.toValue forKey:@"petal_pan_location"];
    
    // 添加动画,其中key值相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [self.petalLayer addAnimation:animation forKey:@"petal_pan_animation"];
}

- (void)rotationAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 6.0;
    animation.autoreverses = YES;
    // 设置为无限循环
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.toValue = [NSNumber numberWithFloat:M_PI_2 * 3];
    [self.petalLayer addAnimation:animation forKey:@"petal_rotation_animation"];
}


#pragma mark - 动画暂停和恢复

- (void)animationPause {
    // 核心动画的运行有一个媒体时间的概念，假设将一个旋转动画设置旋转一周用时60秒的话，
    // 那么当动画旋转90度后媒体时间就是15秒。如果此时要将动画暂停只需要让媒体时间偏移量设置为15秒即可，
    // 并把动画运行速度设置为0使其停止运动。类似的，如果又过了60秒后需要恢复动画（此时媒体时间为75秒），
    // 这时只要将动画开始开始时间设置为当前媒体时间75秒减去暂停时的时间（也就是之前定格动画时的偏移量）
    // 15秒（开始时间=75-15=60秒），那么动画就会重新计算60秒后的状态再开始运行，
    // 与此同时将偏移量重新设置为0并且把运行速度设置1。这个过程中真正起到暂停动画和恢复动画的
    // 其实是动画速度的调整，媒体时间偏移量以及恢复时的开始时间设置主要为了让动画更加连贯。
    
    // 注意: 动画暂停针对的是图层而不是图层中的某个动画。
    
    // 取得指定图层动画的媒体时间,后面参数用于指定子图层,这里不需要
    CFTimeInterval interval = [self.petalLayer convertTime:CACurrentMediaTime() toLayer:nil];
    // 设置时间偏移量,保证暂停时停留在旋转的位置
    [self.petalLayer setTimeOffset:interval];
    // 动画速度设置为0,暂停动画
    self.petalLayer.speed = 0;
}

- (void)animationResume {
    // 获得暂停时间
    CFTimeInterval beginTime = CACurrentMediaTime() - self.petalLayer.timeOffset;
    // 设置偏移量
    self.petalLayer.timeOffset = 0;
    // 设置开始时间
    self.petalLayer.beginTime = beginTime;
    // 设置动画速度,开始运动
    self.petalLayer.speed = 1.0;
}


#pragma mark - 关键帧动画

- (void)translationKeyframeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 8.0;
    // 延迟2秒执行
    animation.beginTime = CACurrentMediaTime() + 2.0;
    
    animation.delegate = self;
    
    // 关键帧
//    NSValue *value1 = [NSValue valueWithCGPoint:self.petalLayer.position];
//    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(100, 320)];
//    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(85, 450)];
//    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(40, 570)];
//    animation.values = @[value1, value2, value3, value4];
    
    
    // 绘制贝塞尔曲线
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.petalLayer.position.x, self.petalLayer.position.y);
    // 绘制二次贝塞尔曲线
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 600);
    // 设置动画的路径
    animation.path = path;
    // 释放路径对象
    CGPathRelease(path);
    
    [self.petalLayer addAnimation:animation forKey:@"petal_pan_keyframe_animation"];
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    // 动画结束后,让花瓣停在动画终点的位置
    NSValue *locationValue = [anim valueForKey:@"petal_pan_location"];
    CGPoint location = [locationValue CGPointValue];
    
    // 对于非根图层，设置图层的可动画属性（在动画结束后重新设置了position，而position是可动画属性）
    // 会产生动画效果。解决这个问题有两种办法：关闭图层隐式动画、设置动画图层为根图层。
    // 这里采用动画事务CATransaction，在事务内将隐式动画关闭.
    
    // 开启事务
    [CATransaction begin];
    // 禁用隐式动画
    [CATransaction setDisableActions:YES];
    
    self.petalLayer.position = location;
    
    // 提交事务
    [CATransaction commit];
}


#pragma mark - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    // 判断动画是否已经创建,若已创建则不再创建
//    CAAnimation *animation = [self.petalLayer animationForKey:@"petal_pan_animation"];
//    if (!animation) {
//        // 开始平移动画
//        [self translationAnimationWithLocation:touchPoint];
//        // 开始旋转动画
//        [self rotationAnimation];
//    } else {
//        if (self.petalLayer.speed == 0) {
//            [self animationResume];
//        } else {
//            [self animationPause];
//        }
//    }
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
