//
//  JCCountButton.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCCountButton;
typedef NSString* (^CountDownChanging)(JCCountButton *button,NSUInteger second);
typedef NSString* (^CountDownFinished)(JCCountButton *button,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(JCCountButton *button,NSInteger tag);

@interface JCCountButton : UIButton

@property(nonatomic,strong) id userInfo;
///倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
//倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;
//倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
///停止倒计时
- (void)stopCountDown;

@end
