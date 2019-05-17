//
//  UIViewController+NavigationView.m
//  CustomNav
//
//  Created by admin on 2018/9/29.
//  Copyright © 2018年 com. All rights reserved.
//

#import "UIViewController+NavigationView.h"
#import "ZJNavigationView.h"
#import <objc/runtime.h>
#import "ZJUtilities.h"


@interface UIViewController () <ZJNavigationViewDelegate>

@end

@implementation UIViewController (NavigationView)

- (void) setNagationView:(UIView *)nagationView{
    
    NSAssert(nagationView, @"when set navigationView should not nil");
    objc_setAssociatedObject(self, @selector(nagationView), nagationView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)nagationView{
    
    if (objc_getAssociatedObject(self, _cmd) == nil) {
        ZJNavigationView *view = [[ZJNavigationView alloc] initWithFrame:CGRectMake(0, 0, kZJScreenWidth,kBarTopHeight) viewController:self];
        view.backgroundColor = [UIColor whiteColor];
        view.title = self.title;
        objc_setAssociatedObject(self, @selector(nagationView), view, OBJC_ASSOCIATION_RETAIN);
    }
    return objc_getAssociatedObject(self, _cmd);
}


- (void)zj_setDefaultNavigationView{
    
    [self zj_setCustomNavigationView:nil];
}


-(void)zj_setCustomNavigationView:(UIView *)navigationView{
    // when navigationView is nil use defualt navigationView
    // else use a custom navigationView
    if (self.navigationController.navigationBar.hidden == NO) {
#ifdef DEBUG
        NSLog(@"\n\n\n UIViewController+NavigationView:\n custom navigationView replace default\n\n\n\n");
#endif
        self.navigationController.navigationBar.hidden = YES;
    }
    if (navigationView != nil) {
        self.nagationView = navigationView;
    }
        
    [self.view addSubview:self.nagationView];

}

- (void)zj_changedBackAction:(SEL)sel{
    
    UIButton *btn = ((ZJNavigationView *) self.nagationView).backButton;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [btn removeTarget:self.nagationView action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
    [((ZJNavigationView *) self.nagationView).backButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
}


// 重写 title 方法
- (void)setTitle:(NSString *)title{
    self.vcTitle = title;
}

- (NSString *)title{
    return self.vcTitle;
}

- (void)setVcTitle:(NSString *)vcTitle{
    objc_setAssociatedObject(self, @selector(vcTitle), vcTitle, OBJC_ASSOCIATION_COPY);
    if ([self.nagationView isMemberOfClass:[ZJNavigationView class]]) {        
        ((ZJNavigationView *) self.nagationView).title = vcTitle;
    }
}

- (NSString *)vcTitle{
    return objc_getAssociatedObject(self, _cmd);
}


- (void)zj_setLeftBarView:(UIView *)leftBarView{
    NSAssert([self.nagationView isMemberOfClass:[ZJNavigationView class]], @"已经自定义导航条，只有使用默认导航条时才能自定义bar视图");
    [(ZJNavigationView *)(self.nagationView) setCustomLeftBar:leftBarView];
    
}

- (void)zj_setMiddleBarView:(UIView *)middleBarView{
    NSAssert([self.nagationView isMemberOfClass:[ZJNavigationView class]], @"已经自定义导航条，只有使用默认导航条时才能自定义bar视图");
    [(ZJNavigationView *)(self.nagationView) setCustomMiddleBar:middleBarView];
}

- (void)zj_setRightBarView:(UIView *)rightBarView{
    NSAssert([self.nagationView isMemberOfClass:[ZJNavigationView class]], @"已经自定义导航条，只有使用默认导航条时才能自定义bar视图");
    [(ZJNavigationView *)(self.nagationView) setCustomRightBar:rightBarView];
}


- (void)zj_setLeftBarViews:(NSArray *)leftBarViews{
    if (leftBarViews.count == 0) {
        [self zj_setLeftBarView:[leftBarViews firstObject]];
        return;
    }
    [(ZJNavigationView *)(self.nagationView) setCustomLeftBars:leftBarViews];
}

- (void)zj_setRightBarViews:(NSArray *)rightBarViews{
    if (rightBarViews.count == 0) {
        [self zj_setRightBarView:[rightBarViews firstObject]];
        return;
    }
    [(ZJNavigationView *)(self.nagationView) setCustomRightBars:rightBarViews];
}


-(void)zj_setMiddleTitleFont:(UIFont *)font{
    NSAssert([self.nagationView isMemberOfClass:[ZJNavigationView class]], @"已经自定义导航条，只有使用默认导航条时才能自定义设置");
    ((ZJNavigationView *) self.nagationView).titleFont = font;

}

// 渐变，隐藏

@end
