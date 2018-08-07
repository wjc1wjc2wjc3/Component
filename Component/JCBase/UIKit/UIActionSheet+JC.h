//
//  UIActionSheet+JC.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (JC)<UIActionSheetDelegate>

- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx,NSString* buttonTitle))block;

@end
