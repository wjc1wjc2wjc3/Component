//
//  UIWindow+JC.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (JC)

/**
 Returns the current Top Most ViewController in hierarchy.
 */
@property (nullable, nonatomic, readonly, strong) UIViewController *topMostController;

/**
 Returns the topViewController in stack of topMostController.
 */
@property (nullable, nonatomic, readonly, strong) UIViewController *currentViewController;

@end
