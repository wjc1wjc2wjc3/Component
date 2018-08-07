//
//  NSString+JC.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (JC)

- (NSString *)md5_32bit;

- (NSString *)numberToStr:(NSUInteger)hexNumber;
- (NSString *)numberToStrFour:(NSUInteger)hexNumber;
- (NSString *)numberToStrTwo:(NSUInteger)hexNumber;
- (NSString *)numberToByte:(NSUInteger)hexNumber;
- (NSInteger)strToHex;
- (NSInteger)longStrToHex;
//十六进制字符串转成十进制字符串
- (NSString *)hexToDecimalStr;

+ (NSMutableArray *)littleEndianArray:(NSString *)src ;
+ (NSString *)littleEndian:(NSString *)src;

+ (NSString *)createUUID:(NSString *)name;

@end
