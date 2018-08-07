//
//  JCNavigationBar.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCNavigationBarDelegate <NSObject>

@optional
- (void)backItem;
- (void)rightItem;
@end

@interface JCNavigationBar : UINavigationBar<UINavigationBarDelegate>

@property (nonatomic, strong) UINavigationItem *navigationItem;
@property (nonatomic, weak) id<JCNavigationBarDelegate> jcDelegate;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setShowBackItem:(BOOL)bShow title:(NSString *)title;

- (void)setNaviBackgroundColor:(UIColor *)color;

- (void)showSearch:(BOOL)bShow;

- (void)showRightNavi:(BOOL)bShow title:(NSString *)title;

@end
