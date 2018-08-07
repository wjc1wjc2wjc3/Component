//
//  UIAlertView+JC.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (JC)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showWithBlock:(void(^)(NSInteger buttonIndex)) block;

@end
