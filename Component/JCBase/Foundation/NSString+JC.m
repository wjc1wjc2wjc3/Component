//
//  NSString+JC.m
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "NSString+JC.h"

@implementation NSString (JC)

- (NSString *)md5_32bit {
    
    const char * str = [self UTF8String];
    unsigned char md[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (int)strlen(str), md);
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",md[i]];
    }
    
    return ret;
}

- (NSString *)numberToStr:(NSUInteger)hexNumber {
    char hexChar[6];
    sprintf(hexChar, "%x", (int)hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}

- (NSString *)numberToStrFour:(NSUInteger)hexNumber {
    char hexChar[8];
    sprintf(hexChar, "%x", (int)hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}

- (NSString *)numberToStrTwo:(NSUInteger)hexNumber {
    char hexChar[4];
    sprintf(hexChar, "%0lx", hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}

- (NSString *)numberToByte:(NSUInteger)hexNumber {
    char hexChar[4];
    sprintf(hexChar, "%02lx", hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}

- (NSInteger)strToHex {
    
    const char *hexChar = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}

- (NSInteger)longStrToHex {
    
    const char *hexChar = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSInteger hexNumber;
    
    sscanf(hexChar, "%lx", &hexNumber);
    
    return (NSInteger)hexNumber;
}

- (NSString *)hexToDecimalStr {
    unsigned long long result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner scanHexLongLong:&result];
    return [NSString stringWithFormat:@"%lld", result];
}

+ (NSMutableArray *)littleEndianArray:(NSString *)src ; {
    if(!src || [@"" isEqualToString:src]) return nil;
    
    NSUInteger count = src.length / 4;
    NSMutableArray *timeArray = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = count - 1; i >= 0; i--) {
        NSString *sub = [src substringWithRange:NSMakeRange(i * 4, 4)];
        NSString *high = [sub substringFromIndex:2];
        NSString *low = [sub substringToIndex:2];
        [timeArray addObject:high];
        [timeArray addObject:low];
    }
    return timeArray;
}

+ (NSString *)littleEndian:(NSString *)src {
    NSArray *array = [self littleEndianArray:src];
    NSMutableString *value = [@"" mutableCopy];// @"";
    for (NSString *sub in array) {
        [value appendFormat:@"%@", sub];
    }
    
    return value;
}


+ (NSString *)createUUID:(NSString *)name {
    
    if (!name || name.length == 0) {
        return name;
    }
    
    NSInteger length = name.length;
    if (length < 32) {
        NSInteger patchesLength = 32 - length;
        for (NSInteger i = 0; i < patchesLength; i++) {
            name = [name stringByAppendingString:@"0"];
        }
    }
    
    length = name.length;
    NSMutableString *uuidName = [[NSMutableString alloc] initWithString:name];
    if(length > 24) {
        
        [uuidName insertString:@"-" atIndex:8];
        [uuidName insertString:@"-" atIndex:13];
        [uuidName insertString:@"-" atIndex:18];
        [uuidName insertString:@"-" atIndex:23];
    }
    else
        if(length > 20) {
            
            [uuidName insertString:@"-" atIndex:8];
            [uuidName insertString:@"-" atIndex:13];
            [uuidName insertString:@"-" atIndex:18];
            [uuidName insertString:@"-" atIndex:23];
        }
        else if(length > 16)
        {
            [uuidName insertString:@"-" atIndex:8];
            [uuidName insertString:@"-" atIndex:13];
            [uuidName insertString:@"-" atIndex:18];
        }
        else if(length > 12)
        {
            [uuidName insertString:@"-" atIndex:8];
            [uuidName insertString:@"-" atIndex:13];
        }
        else if(length > 8)
        {
            [uuidName insertString:@"-" atIndex:8];
        }
    
    return uuidName;
}

@end
