//
//  ZJBaseViewController+NavigationView.h
//  CustomNav
//
//  Created by admin on 2018/9/29.
//  Copyright © 2018年 com. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NavigationView)

//导航视图

@property(nonatomic, strong) UIView *nagationView;

//controller 标题
@property(nonatomic, copy) NSString * vcTitle;

/*
 设置默认导航视图
 */
- (void)zj_setDefaultNavigationView;

/*
 自定义导航视图
 */
- (void)zj_setCustomNavigationView:(nullable UIView *)navigationView;

/*
 自定义导航左视图
 */
- (void)zj_setLeftBarView:(nullable UIView *)leftBarView;

/*
 自定义导航中视图
 */
- (void)zj_setMiddleBarView:(nullable UIView *)middleBarView;

/*
 自定义导航右视图
 */
- (void)zj_setRightBarView:(nullable UIView *)rightBarView;

/*
 自定义导航左视图组
 */
- (void)zj_setLeftBarViews:(nullable NSArray *)leftBarViews;

/*
 自定义导航中视图组
 */
- (void)zj_setMiddleTitleFont:(UIFont *)font;

/*
 自定义导航右视图组
 */
- (void)zj_setRightBarViews:(nullable NSArray *)rightBarViews;

// 修改返回事件
- (void)zj_changedBackAction:(SEL)sel;

@end

NS_ASSUME_NONNULL_END
