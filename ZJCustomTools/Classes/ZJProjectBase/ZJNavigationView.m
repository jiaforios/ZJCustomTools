//
//  ZJNavigationView.m
//  CustomNav
//
//  Created by admin on 2018/9/29.
//  Copyright © 2018年 com. All rights reserved.
/*
  将ZJNavigationView 分成left + middle + right
 初始状态均分
 根据三个控件的大小，自动分配，但保证middle 一直居中
 三个控件均支持自定义
 */


#import "ZJNavigationView.h"
#import "ZJUtilities.h"

#define kNavLeftBackWidth 50 // 默认左侧返回控件宽带
#define kNavViewWidth (kZJScreenWidth - 20) / 3
#define kNavLeftMargin (kZJScreenWidth - kNavViewWidth)/2
#define kNavRightMargin kNavLeftMargin

@interface ZJNavigationView ()
@property(nonatomic, strong) UIView *leftBar;
@property(nonatomic, strong) UIView *middleBar;
@property(nonatomic, strong) UIView *rightBar;
@property(nonatomic, strong) UIView *barBackgroundView;
@property(nonatomic, copy) BOOL(^clickBackBlock)(void);

@end


@implementation ZJNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.canBack = YES;
        [self addSubview:self.barBackgroundView];
        [self setLeftDefaultView];
        [self setMiddleDefaultView];
        [self setRightDefaultView];
        [self uiConstraint];
        [self observeBars];

    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    _barBackgroundView.backgroundColor = backgroundColor;
}

- (void)uiConstraint{
    
    self.leftBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.middleBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *hvfl = @"H:|-0-[leftView(viewWidth)]";
    NSArray *hcons = [NSLayoutConstraint constraintsWithVisualFormat:hvfl options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:@{@"viewWidth":@(kNavLeftBackWidth)} views:@{@"leftView":self.leftBar}];
    [self.barBackgroundView addConstraints:hcons];
    
    NSString *hvfl2 = @"H:[rightView(viewWidth)]-0-|";
    NSArray *hcons2 = [NSLayoutConstraint constraintsWithVisualFormat:hvfl2 options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:@{@"viewWidth":@(kNavViewWidth)} views:@{@"rightView":self.rightBar}];
    [self.barBackgroundView addConstraints:hcons2];
    
    NSString *hvfl3 = @"H:|-leftMargin-[middleView(viewWidth)]-rightMargin-|";
    NSArray *hcons3 = [NSLayoutConstraint constraintsWithVisualFormat:hvfl3 options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:@{@"viewWidth":@(kNavViewWidth),@"leftMargin":@(kNavLeftMargin),@"rightMargin":@(kNavRightMargin)} views:@{@"middleView":self.middleBar}];
    [self.barBackgroundView addConstraints:hcons3];
    
    
    NSString *vvfl = @"V:[leftView(middleHeight)]-0-|";
    NSArray *vcons = [NSLayoutConstraint constraintsWithVisualFormat:vvfl options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:@{@"middleHeight":@(kBarHeight)} views:@{@"leftView":self.leftBar}];
    [self.barBackgroundView addConstraints:vcons];

    NSString *vvfl1 = @"V:[rightView(middleHeight)]-0-|";
    NSArray *vcons1 = [NSLayoutConstraint constraintsWithVisualFormat:vvfl1 options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:@{@"middleHeight":@(kBarHeight)} views:@{@"rightView":self.rightBar}];
    [self.barBackgroundView addConstraints:vcons1];

    NSString *vvfl2 = @"V:[middleView(middleHeight)]-0-|";
    NSArray *vcons2 = [NSLayoutConstraint constraintsWithVisualFormat:vvfl2 options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:@{@"middleHeight":@(kBarHeight)} views:@{@"middleView":self.middleBar}];
    [self.barBackgroundView addConstraints:vcons2];

}


- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController{
    self.viewController = viewController;
    return [self initWithFrame:frame];
}


- (void) setLeftDefaultView{
    
    if (self.viewController.navigationController.viewControllers.count == 1) {
         self.leftBar = [UIView new];
    }else{
        BackBarButton *btn = [[BackBarButton alloc] init];
        self.backButton = btn;
        [btn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
         self.leftBar = btn;
    }
    
    [self.barBackgroundView addSubview:self.leftBar];

}

- (void) setMiddleDefaultView{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.middleBar = titleLabel;
    [self.barBackgroundView addSubview:self.middleBar];
}

- (void) setRightDefaultView{
    
    UIView * right = [[UIView alloc] init];
    right.backgroundColor = self.backgroundColor;
    self.rightBar = right;
    [self.barBackgroundView addSubview:self.rightBar];
}


// 观察控件变化
- (void)observeBars{

}

- (void)setTitle:(NSString *)title{
    // 设置中间控件的 title
    if (self.titleAttr) {
        UILabel *label =(UILabel *)self.middleBar;
        label.attributedText = [[NSAttributedString alloc] initWithString:title attributes:self.titleAttr];
    }else{
        ((UILabel *)self.middleBar).text = title;
    }
}

- (void)setTitleFont:(UIFont *)titleFont{
    ((UILabel *)self.middleBar).font = titleFont;
}

- (void)setTitleAttr:(NSDictionary *)titleAttr{
    _titleAttr = titleAttr;
    UILabel *label =(UILabel *)self.middleBar;
    label.attributedText = [[NSAttributedString alloc] initWithString:label.text attributes:titleAttr];
}

- (UIView *)barBackgroundView{
    if (_barBackgroundView == nil) {
        _barBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(kBarBackgroundViewEdgeLeft, kBarBackgroundViewEdgeTop, CGRectGetWidth(self.frame)-kBarBackgroundViewEdgeLeft*2, CGRectGetHeight(self.frame)-kBarBackgroundViewEdgeTop)];
        
        _barBackgroundView.backgroundColor = self.backgroundColor;
    }
    return _barBackgroundView;
}

- (void)clickBack{
    if (self.isCanBack) {
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }
}

- (void)clickBackAction:(BOOL (^)(void))backBlock{
    self.clickBackBlock = backBlock;
}

- (void)setCustomLeftBar:(UIView *)left{
    // 移除当前，替换新的
    [self.leftBar removeFromSuperview];
    self.leftBar = left;
    [self.barBackgroundView addSubview:self.leftBar];
}

- (void)setCustomMiddleBar:(UIView *)middle{
    [self.middleBar removeFromSuperview];
    self.middleBar = middle;
    [self.barBackgroundView addSubview:self.middleBar];
}

- (void)setCustomRightBar:(UIView *)right{
    [self.rightBar removeFromSuperview];
    self.rightBar = right;
    [self.barBackgroundView addSubview:right];
}

- (void)setCustomLeftBars:(NSArray *)lefts{
    [self.leftBar removeFromSuperview];

    for (UIView *view in lefts) {
        [self.barBackgroundView addSubview:view];
    }
    
}

- (void)setCustomMiddleBars:(NSArray *)middles{
    [self.middleBar removeFromSuperview];
    
    for (UIView *view in middles) {
        [self.barBackgroundView addSubview:view];
    }
}

- (void)setCustomRightBars:(NSArray *)rights{
    [self.rightBar removeFromSuperview];
    
    for (UIView *view in rights) {
        [self.barBackgroundView addSubview:view];
    }
}


@end


@implementation BackBarButton

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path =  CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 24, 15);
    CGPathAddLineToPoint(path, NULL, 15,23);
    CGPathAddLineToPoint(path, NULL, 24, 31);
    [[UIColor whiteColor] setStroke];
    
    CGContextSetLineWidth(ctx, 2);
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
//    CGContextRelease(ctx);
}


@end
