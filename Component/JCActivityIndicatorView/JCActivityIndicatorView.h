//
//  JCActivityIndicatorView.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCActivityIndicatorView : UIView

+(_Nonnull instancetype)defaultIndicator;

@property(nonatomic) BOOL hidesWhenStopped;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
