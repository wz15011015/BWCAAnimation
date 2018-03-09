//
//  CABasicAnimationViewController.h
//  CAAnimation
//
//  Created by ff on 2018/2/27.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "BTSBaseViewController.h"

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


@interface CABasicAnimationViewController : BTSBaseViewController

@property (nonatomic, assign) AnimationKeyPath animationType;

@end
