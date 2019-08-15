//
//  Const.h
//  CAAnimation
//
//  Created by hadlinks on 2019/8/9.
//  Copyright © 2019 BTStudio. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 动画类型

 - AnimationKeyPathTransformScale: 比例缩放
 - AnimationKeyPathTransformScaleX: 宽度比例缩放
 - AnimationKeyPathTransformScaleY: 高度比例缩放
 - AnimationKeyPathTransformRotationX: 绕x轴旋转
 - AnimationKeyPathTransformRotationY: 绕y轴旋转
 - AnimationKeyPathTransformRotationZ: 绕z轴旋转
 - AnimationKeyPathTransformTranslation: 中心点移动
 - AnimationKeyPathTransformTranslationX: x轴方向移动
 - AnimationKeyPathTransformTranslationY: y轴方向移动
 - AnimationKeyPathContentsRectSizeWidth: 横向拉伸
 - AnimationKeyPathContentsRectSizeHeight: 纵向拉伸
 - AnimationKeyPathBounds: 大小缩放,中心位置不变
 - AnimationKeyPathPosition: 中心位置变化
 - AnimationKeyPathBackgroundColor: 背景颜色变化
 - AnimationKeyPathOpacity: 透明度变化
 - AnimationKeyPathContents: 内容变化
 - AnimationKeyPathCornerRadius: 圆角变化
 - AnimationKeyPathBorderWidth: 边框线宽度变化
 - AnimationKeyPathBorderColor: 边框线颜色变化
 */
typedef NS_ENUM(NSUInteger, AnimationKeyPath) {
    AnimationKeyPathTransformScale,
    AnimationKeyPathTransformScaleX,
    AnimationKeyPathTransformScaleY,
    AnimationKeyPathTransformRotationX,
    AnimationKeyPathTransformRotationY,
    AnimationKeyPathTransformRotationZ,
    AnimationKeyPathTransformTranslation,
    AnimationKeyPathTransformTranslationX,
    AnimationKeyPathTransformTranslationY,
    AnimationKeyPathContentsRectSizeWidth,
    AnimationKeyPathContentsRectSizeHeight,
    AnimationKeyPathBounds,
    AnimationKeyPathPosition,
    AnimationKeyPathBackgroundColor,
    AnimationKeyPathOpacity,
    AnimationKeyPathContents,
    AnimationKeyPathCornerRadius,
    AnimationKeyPathBorderWidth,
    AnimationKeyPathBorderColor,
};


/**
 转场动画效果

 - TransitionAnimationkCATransitionFade: kCATransitionFade
 - TransitionAnimationkCATransitionMoveIn: kCATransitionMoveIn
 - TransitionAnimationkCATransitionPush: kCATransitionPush
 - TransitionAnimationkCATransitionReveal: kCATransitionReveal
 - TransitionAnimationCube: cube
 - TransitionAnimationSuckEffect: suckEffect
 - TransitionAnimationRippleEffect: rippleEffect
 - TransitionAnimationPageCurl: pageCurl
 - TransitionAnimationPageUnCurl: pageUnCurl
 - TransitionAnimationOglFlip: oglFlip
 - TransitionAnimationCameraIrisHollowOpen: cameraIrisHollowOpen
 - TransitionAnimationCameraIrisHollowClose: cameraIrisHollowClose
 - TransitionAnimationSpewEffect: spewEffect
 - TransitionAnimationGenieEffect: genieEffect
 - TransitionAnimationUnGenieEffect: unGenieEffect
 - TransitionAnimationTwist: twist
 - TransitionAnimationTubey: tubey
 - TransitionAnimationSwirl: swirl
 - TransitionAnimationCharminUltra: charminUltra
 - TransitionAnimationZoomyIn: zoomyIn
 - TransitionAnimationZoomyOut: zoomyOut
 - TransitionAnimationOglApplicationSuspend: oglApplicationSuspend
 */
typedef NS_ENUM(NSUInteger, TransitionAnimationType) {
    TransitionAnimationkCATransitionFade,
    TransitionAnimationkCATransitionMoveIn,
    TransitionAnimationkCATransitionPush,
    TransitionAnimationkCATransitionReveal,
    TransitionAnimationCube,
    TransitionAnimationSuckEffect,
    TransitionAnimationRippleEffect,
    TransitionAnimationPageCurl,
    TransitionAnimationPageUnCurl,
    TransitionAnimationOglFlip,
    TransitionAnimationCameraIrisHollowOpen,
    TransitionAnimationCameraIrisHollowClose,
    TransitionAnimationSpewEffect,
    TransitionAnimationGenieEffect,
    TransitionAnimationUnGenieEffect,
    TransitionAnimationTwist,
    TransitionAnimationTubey,
    TransitionAnimationSwirl,
    TransitionAnimationCharminUltra,
    TransitionAnimationZoomyIn,
    TransitionAnimationZoomyOut,
    TransitionAnimationOglApplicationSuspend,
};
