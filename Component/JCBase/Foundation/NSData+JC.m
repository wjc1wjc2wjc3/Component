//
//  NSData+JC.m
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "NSData+JC.h"
#import <CommonCrypto/CommonCrypto.h>

const NSUInteger kAlgorithmKeySize = kCCKeySizeAES128;
const NSUInteger kPBKDFRounds = 100;

NSString *const salt = @"4BDD60B281D31F1B70EC3AAA81F282BC";
NSString *const iv = @"1269571869323221";
NSString *const aescrypt_secret= @"GM56771314";

@implementation NSData (JC)

- (NSString *)hexString {
    NSUInteger length = self.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02x", *byte];
    }
    return result;
}

+ (NSData *)hexToBytes:(NSString *)hexString {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx < hexString.length; idx++) {
        NSRange range = NSMakeRange(idx, 1);
        NSString* hexStr = [hexString substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    
    return data;
}

+ (NSData *)dataWithHexString:(NSString *)hexStr {
    hexStr = [hexStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    hexStr = [hexStr lowercaseString];
    NSUInteger len = hexStr.length;
    if (!len) return nil;
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [hexStr getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableData *result = [NSMutableData data];
    unsigned char bytes;
    char str[3] = { '\0', '\0', '\0' };
    int i;
    for (i = 0; i < len / 2; i++) {
        str[0] = buf[i * 2];
        str[1] = buf[i * 2 + 1];
        bytes = strtol(str, NULL, 16);
        [result appendBytes:&bytes length:1];
    }
    free(buf);
    return result;
}

+ (NSString *)md5_32bit:(NSString *)input {
    
    const char * str = [input UTF8String];
    unsigned char md[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (int)strlen(str), md);
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",md[i]];
    }
    
    return ret;
}

+ (NSData *)AESKeyForPassword:(NSString *)password {                  //Derive a key from a text password/passphrase
    
    NSMutableData *derivedKey = [NSMutableData dataWithLength:kAlgorithmKeySize];
    
    NSData *saltData = [salt dataUsingEncoding:NSUTF8StringEncoding];
    
    
    int result = CCKeyDerivationPBKDF(kCCPBKDF2,        // algorithm算法
                                      password.UTF8String,  // password密码
                                      password.length,      // passwordLength密码的长度
                                      saltData.bytes,           // salt内容
                                      saltData.length,          // saltLen长度
                                      kCCPRFHmacAlgSHA1,    // PRF
                                      kPBKDFRounds,         // rounds循环次数
                                      derivedKey.mutableBytes, // derivedKey
                                      derivedKey.length);   // derivedKeyLen derive:出自
    
    NSAssert(result == kCCSuccess,
             @"Unable to create AES key for spassword: %d", result);
    return derivedKey;
}

- (NSData *)AESCryptWithOperation:(CCOperation)operation key:(NSData *)key iv:(NSData *)iv
{
    CCCryptorRef cryptorRef = NULL;
    CCCryptorStatus status = CCCryptorCreate(operation,
                                             kCCAlgorithmAES,
                                             kCCOptionPKCS7Padding,
                                             [key bytes],
                                             [key length],
                                             [iv bytes],
                                             &cryptorRef);
    if ( status==kCCSuccess ) {
        NSUInteger bufferSize = CCCryptorGetOutputLength(cryptorRef, [self length], true);
        NSMutableData *result = [[NSMutableData alloc] initWithLength:bufferSize];
        void *buffer = [result mutableBytes];
        NSUInteger totalLength = 0;
        size_t writtenLength = 0;
        status = CCCryptorUpdate(cryptorRef,
                                 [self bytes],
                                 [self length],
                                 buffer,
                                 bufferSize,
                                 &writtenLength);
        if ( status==kCCSuccess ) {
            totalLength += writtenLength;
            status = CCCryptorFinal(cryptorRef,
                                    buffer+writtenLength,
                                    bufferSize-writtenLength,
                                    &writtenLength);
            if ( status==kCCSuccess ) {
                totalLength += writtenLength;
                [result setLength:totalLength];
                CCCryptorRelease(cryptorRef);
                return result;
            }
        }
        CCCryptorRelease(cryptorRef);
    }
    return nil;
}



@end
