//
//  OtherViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2018/3/1.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "OtherViewController.h"
#import "Macro.h"

#define TOUCH_POINT_W (30)
#define IMAGE_LAYER_W (100)


@interface OtherViewController () <CALayerDelegate>

// 触摸点图层
@property (nonatomic, strong) CALayer *touchPointLayer;

@end

@implementation OtherViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad]; 
    
    if (self.type == 0) {
        [self addTapGestureRecognizer];
        [self drawTouchPointLayer];
    } else if (self.type == 1) {
        // CALayer绘图
        [self drawShadowLayer];
        [self drawCustomLayer];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"self = %@", self);
}


#pragma mark - 0
/**
 在iOS中CALayer的设计主要是了为了内容展示和动画操作，CALayer本身并不包含在UIKit中，它不能响应事件。由于CALayer在设计之初就考虑它的动画操作功能，CALayer很多属性在修改时都能形成动画效果，这种属性称为“隐式动画属性”。
 但是对于UIView的根图层而言属性的修改并不形成动画效果，因为很多情况下根图层更多的充当容器作用，如果它的属性变动形成动画效果,会直接影响子图层。另外，UIView的根图层创建工作完全由iOS负责完成，无法重新创建，但是可以往根图层中添加子图层或移除子图层。
 */

- (void)addTapGestureRecognizer {
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [self.view addGestureRecognizer:tapGR];
}

- (void)drawTouchPointLayer {
    self.touchPointLayer = [[CALayer alloc] init];
    // 设置背景颜色,由于QuartzCore是跨平台框架,无法直接使用UIColor
    self.touchPointLayer.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:146 / 255.0 blue:255.0 / 255.0 alpha:1.0].CGColor;
    // 设置中心点
    self.touchPointLayer.position = CGPointMake(80, 200);
    // 设置大小
    self.touchPointLayer.bounds = CGRectMake(0, 0, TOUCH_POINT_W, TOUCH_POINT_W);
    // 设置圆角
    self.touchPointLayer.cornerRadius = TOUCH_POINT_W / 2.0;
    // 设置阴影效果
    self.touchPointLayer.shadowColor = [UIColor grayColor].CGColor;
    self.touchPointLayer.shadowOffset = CGSizeMake(2, 2);
    self.touchPointLayer.shadowOpacity = 0.9;
    
    [self.view.layer addSublayer:self.touchPointLayer];
}


#pragma mark - 1
// 阴影图层,用来显示阴影效果
- (void)drawShadowLayer {
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, IMAGE_LAYER_W, IMAGE_LAYER_W);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.position = self.view.center;
    layer.cornerRadius = IMAGE_LAYER_W / 2.0;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 1;
    
    [self.view.layer addSublayer:layer];
}

// 图片图层
- (void)drawCustomLayer {
    // 自定义图层
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, IMAGE_LAYER_W, IMAGE_LAYER_W);
    layer.position = self.view.center;
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.cornerRadius = IMAGE_LAYER_W / 2.0;
    
    // 注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    // 原因就是当绘制一张图片到图层上的时候会重新创建一个图层添加到当前图层，这样一来如果设置了圆角之后虽然底图层有圆角效果，但是子图层还是矩形，只有设置了masksToBounds为YES让子图层按底图层剪切才能显示圆角效果。
    // 如果想要正确显示则必须设置masksToBounds = YES，剪切子图层
    layer.masksToBounds = YES;
    // 阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    // 而阴影效果刚好在外边框
//    layer.shadowColor = [UIColor grayColor].CGColor;
//    layer.shadowOffset = CGSizeMake(2, 2);
//    layer.shadowOpacity = 1;
    // 设置边框
//    layer.borderColor = [UIColor lightGrayColor].CGColor;
//    layer.borderWidth = 2;
    
//    layer.delegate = self;
    
    [self.view.layer addSublayer:layer];
    
    // 调用图层setNeedsDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
}


// MARK: CALayerDelegate
// 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    // 图行上下文形变,解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -IMAGE_LAYER_W);
    
    UIImage *image = [UIImage imageNamed:@"Xcode_icon"];
    // 注意:这里的位置是相对于图层而言,不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, IMAGE_LAYER_W, IMAGE_LAYER_W), image.CGImage);
    
    CGContextRestoreGState(ctx);
}


#pragma mark - Event

- (void)viewTap:(UITapGestureRecognizer *)gestureRecognizer {
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view];
    
    CGFloat width = CGRectGetWidth(self.touchPointLayer.bounds);
    if (width == TOUCH_POINT_W) {
        width = TOUCH_POINT_W * 4;
    } else {
        width = TOUCH_POINT_W;
    }
    self.touchPointLayer.bounds = CGRectMake(0, 0, width, width);
    self.touchPointLayer.position = touchPoint;
    self.touchPointLayer.cornerRadius = width / 2.0;
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
