//
//  JCAccount.h
//  Component
//
//  Created by Apple on 2018/7/27.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SAMKeychain.h"
#import "SAMKeychainQuery.h"


UIKIT_EXTERN NSString *const JC_Service_Account ;
UIKIT_EXTERN NSString *const JC_LastLoginAccount ;

@interface JCAccount : NSObject

/*
**
* @brief 刷新账号列表  登录账号自身不包括在内
* @param loginName 登录账号
*/
+ (NSMutableArray *)refreshAccount:(NSString *)loginName;

/**
 * @brief 保存账号
 * @param account 账号
 * @param pwd     密码
 */
+ (void)saveAccount:(NSString *)account pwd:(NSString *)pwd;

+ (void)saveAccountWithoutPWD:(NSString *)account;

/**
 * brief 获取登录账号列表
 */
+ (NSArray *)getAccountList;

/**
 * brief 获取登录账号的密码
 */
+ (NSString *)getAccountPWD:(NSString *)now_account;

/**
 * brief 获取登录账号的密码
 */
+ (NSString *)getAccountPWD;

/**
 * brief 获取当前登录的账号
 */
+ (NSString *)getAccount;

/**
 *@ brief 删除该账号相关的信息
 *@ param account
 */
+(void)deleteAccount:(NSString *)account;

@end
