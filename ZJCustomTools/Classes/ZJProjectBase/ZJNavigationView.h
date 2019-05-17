//
//  ZJNavigationView.h
//  CustomNav
//
//  Created by admin on 2018/9/29.
//  Copyright © 2018年 com. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class ZJNavigationView;

@protocol ZJNavigationViewDelegate <NSObject>
@optional
- (void)backClickinView:(ZJNavigationView *)ZJNavigationView;

@end


@interface BackBarButton : UIButton

@end


@interface ZJNavigationView : UIView

@property(nonatomic, copy) NSString * title;

/*
 简单设置中间 标题 大小
 */

@property(nonatomic, strong) UIFont *titleFont;
/*
 设置中间标题更多属性，使用attr
 */

@property(nonatomic, copy) NSDictionary *titleAttr;

@property(nonatomic, weak) id<ZJNavigationViewDelegate>  delegate;

@property(nonatomic, strong) UIButton *backButton;


/*
    weak 当前导航视图的controller
 */

@property(nonatomic, weak) UIViewController  *viewController;


- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController;

/*
 自定义左边视图UIview的e坐标为相对barBackgroundView 的坐标
 */

- (void)setCustomLeftBar:(UIView *)left;

/*
 自定义中间视图UIview的e坐标为相对barBackgroundView 的坐标
 */
- (void)setCustomMiddleBar:(UIView *)middle;

/*
 自定义右边视图UIview的e坐标为相对barBackgroundView 的坐标
 */
- (void)setCustomRightBar:(UIView *)right;

/*
 自定义左边视图多个视图UIview的e坐标为相对barBackgroundView 的坐标
 */
- (void)setCustomLeftBars:(NSArray *)lefts;

/*
 自定义中间视图多个视图UIview的e坐标为相对barBackgroundView 的坐标
 */
- (void)setCustomMiddleBars:(NSArray *)middles;

/*
 自定义右边视图多个视图UIview的e坐标为相对barBackgroundView 的坐标
 */
- (void)setCustomRightBars:(NSArray *)rights;

- (void)clickBackAction:(BOOL(^)(void))backBlock;

@property (nonatomic, assign, getter = isCanBack) BOOL canBack;


@end

NS_ASSUME_NONNULL_END
