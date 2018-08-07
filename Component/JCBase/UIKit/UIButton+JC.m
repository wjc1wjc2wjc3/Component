//
//  UIButton+JC.m
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "UIButton+JC.h"

@implementation UIButton (JC)

- (void)setEdgeInset{
    CGRect frame = self.frame;
    CGRect imageRect = self.imageView.frame;
    CGRect titleRect = self.titleLabel.frame;
    CGFloat heightSpace = 20.0f;
    [self setImageEdgeInsets:UIEdgeInsetsMake(heightSpace, 0, frame.size.height - imageRect.size.height - heightSpace, -titleRect.size.width)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageRect.size.height + heightSpace, -imageRect.size.width, 0, 0)];
    
}


@end
