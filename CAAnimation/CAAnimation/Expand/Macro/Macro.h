//
//  Macro.h
//
//  Created by WangZhi on 2018/02/27.
//

#ifndef Macro_h
#define Macro_h


#pragma mark - 设备屏幕宽高/类型/屏幕类型/适配比例
// 屏幕宽高
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREEN_MAX_LENGTH (MAX(WIDTH, HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(WIDTH, HEIGHT))

// 设备类型
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

// 屏幕类型
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X  (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

// 适配比例 (UI效果图以 iPhone 6 Plus(414x736)屏幕像素大小为尺寸基础时)
#define WIDTH_SCALE (IS_IPHONE_4_OR_LESS ? (320.0 / 414.0) : (WIDTH / 414.0))
#define HEIGHT_SCALE (IS_IPHONE_4_OR_LESS ? (568.0 / 736.0) : (HEIGHT / 736.0))

#define NAVIGATION_BAR_HEIGHT (IS_IPHONE_X ? 88.0 : 64.0)
#define TAB_BAR_HEIGHT (IS_IPHONE_X ? 82.0 : 49.0)


#pragma mark - 弱引用
#define BRIAN_WEAK_SELF __weak typeof(self) weakSelf = self;


#pragma mark - 颜色
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]
#define RGB(red, green, blue) RGBA(red, green, blue, 1.0f)


#endif /* Macro_h */
