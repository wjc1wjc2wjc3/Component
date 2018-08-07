//
//  UIImage+JC.m
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "UIImage+JC.h"

@implementation UIImage (JC)

- (UIImage *)drawCircleImage {
    CGFloat side = MIN(self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side),false, [UIScreen mainScreen].scale);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     
                     [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0, side, side)].CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    CGFloat marginX = -(self.size.width - side) /2.f;
    CGFloat marginY = -(self.size.height - side) /2.f;
    [self drawInRect:CGRectMake(marginX, marginY, self.size.width, self.size.height)];
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}

+ (UIImage*) createImageWithColor: (UIColor*) color
{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

@end
