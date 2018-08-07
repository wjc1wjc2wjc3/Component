//
//  UIImage+JC.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JC)

- (UIImage *)drawCircleImage;

+ (UIImage*) createImageWithColor: (UIColor*) color;


+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
@end
