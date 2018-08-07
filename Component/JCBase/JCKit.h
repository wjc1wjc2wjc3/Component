//
//  JCKit.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<JCKit/JCKit.h>)

#import <JCKit/NSData+JC.h>
#import <JCKit/NSDate+JC.h>
#import <JCKit/NSDictionary+JC.h>
#import <JCKit/NSString+JC.h>
#import <JCKit/UIButton+JC.h>
#import <JCKit/UIActionSheet+JC.h>
#import <JCKit/UIAlertView+JC.h>
#import <JCKit/UIWindow+JC.h>
#import <JCKit/UIImage+JC.h>
#import <JCKit/UIControl+JC.h>

#else

#import "NSData+JC.h"
#import "NSDate+JC.h"
#import "NSDictionary+JC.h"
#import "NSString+JC.h"
#import "UIActionSheet+JC.h"
#import "UIAlertView+JC.h"
#import "UIWindow+JC.h"
#import "UIImage+JC.h"
#import "UIControl+JC.h"

#end
