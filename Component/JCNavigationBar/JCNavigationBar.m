//
//  JCNavigationBar.m
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "JCNavigationBar.h"
#import "UIImage+JC.h"

#define RGB(a,b,c) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:1.0]
#define NAVIGATIONBAR_HEIGHT 50
#define NAVIBAR_BLUE RGB(40, 146, 227)
#define LOCALIZEDSTRING(str) NSLocalizedString(str, "")

typedef NS_OPTIONS(NSUInteger, eRightType) {
    eSearchType = 0,
    eCommonType
};

@implementation JCNavigationBar {
    UIButton *_backButton;
    UIButton *_rightButton;
    UIImage *_rightItem;
    UIFont *_rightFont;
    eRightType _rightType;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *image = [UIImage createImageWithColor:NAVIBAR_BLUE];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        NSDictionary *attributeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:16.0],NSFontAttributeName, nil];
        self.titleTextAttributes = attributeDictionary;
        
        [self addBackItem];
        
    }
    return self;
}

- (void)addBackItem{
    UIImage *backImage = [UIImage imageNamed:@"back"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, NAVIGATIONBAR_HEIGHT, NAVIGATIONBAR_HEIGHT)];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backItem:) forControlEvents:UIControlEventTouchUpInside];
    _backButton = backButton;
    UIBarButtonItem *leftNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navigationItem.leftItemsSupplementBackButton = YES;
    [navigationItem setLeftBarButtonItem:leftNavigationItem];
    
    _rightItem = [UIImage imageNamed:@"icon_search"];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, NAVIGATIONBAR_HEIGHT * 1.2, NAVIGATIONBAR_HEIGHT)];
    [rightButton setTitle:LOCALIZEDSTRING(@"search") forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setImage:_rightItem forState:UIControlStateNormal];
    _rightFont = [rightButton.titleLabel font];
    [rightButton addTarget:self action:@selector(rightItem:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setHidden:YES];
    _rightButton = rightButton;
    UIBarButtonItem *rightNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [navigationItem setRightBarButtonItem:rightNavigationItem];
    
    [self pushNavigationItem:navigationItem animated:NO];
    self.navigationItem = navigationItem;
    _rightType = eSearchType;
}

- (void)setNaviBackgroundColor:(UIColor *)color {
    self.barStyle = UIBarStyleBlackTranslucent;
    UIImage *image = [UIImage createImageWithColor:color];
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)rightItem:(UIButton *)button {
    if (_jcDelegate && [_jcDelegate respondsToSelector:@selector(rightItem)]) {
        [_jcDelegate rightItem];
    }
}

- (void)backItem:(UIButton *)button {
    if (_jcDelegate && [_jcDelegate respondsToSelector:@selector(backItem)]) {
        [_jcDelegate backItem];
    }
}


- (void)setShowBackItem:(BOOL)bShow title:(NSString *)title {
    if (_backButton) {
        [_backButton setHidden:!bShow];
    }
    
    if (self.navigationItem) {
        [self.navigationItem setTitle:title];
    }
}

- (void)showSearch:(BOOL)bShow {
    if (_rightButton) {
        
        if (_rightType == eSearchType) {
            [_rightButton setHidden:bShow];
        }
        else
        {
            [_rightButton setHidden:bShow];
            CGRect rect = _rightButton.frame;
            _rightButton.frame = CGRectMake(rect.origin.x, rect.origin.y, NAVIGATIONBAR_HEIGHT * 1.2, NAVIGATIONBAR_HEIGHT);
            [_rightButton setTitle:LOCALIZEDSTRING(@"search") forState:UIControlStateNormal];
            [_rightButton setImage:_rightItem forState:UIControlStateNormal];
            [_rightButton.titleLabel setFont:_rightFont];
            
            _rightType = eSearchType;
        }
    }
}

- (void)showRightNavi:(BOOL)bShow title:(NSString *)title {
    if (_rightButton) {
        if (_rightType == eSearchType) {
            [_rightButton setHidden:!bShow];
            CGRect rect = _rightButton.frame;
            _rightButton.frame = CGRectMake(rect.origin.x, rect.origin.y, CGRectGetWidth(rect) * 2, CGRectGetHeight(rect));
            [_rightButton setTitle:title forState:UIControlStateNormal];
            [_rightButton setImage:nil forState:UIControlStateNormal];
            [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
            _rightType = eCommonType;
        }
        else
        {
            [_rightButton setHidden:!bShow];
        }
    }
}


@end
