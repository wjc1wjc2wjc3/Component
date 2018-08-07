//
//  JCAccount.m
//  Component
//
//  Created by Apple on 2018/7/27.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "JCAccount.h"

NSString *const JC_Service_Account = @"com.hzbit.app.HZBitApp.account";
NSString *const JC_LastLoginAccount = @"lastloginaccount";

@implementation JCAccount

// 刷新账号
+ (NSMutableArray *)refreshAccount:(NSString *)loginName {
    if (!loginName|| [loginName compare:@""] == NSOrderedSame) {
        return nil;
    }
    
    NSArray *array = [SAMKeychain accountsForService:JC_Service_Account];
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    for (NSDictionary * tUser in array){
        NSString *tUserAccount = [tUser objectForKey:kSAMKeychainAccountKey];
        
        if (![tUserAccount isEqualToString:loginName]){
            if (![tUserAccount isEqualToString:JC_LastLoginAccount]){
                [mArray addObject:tUserAccount];
            }
        }
    }
    return mArray;
}


+ (void)saveAccount:(NSString *)account pwd:(NSString *)pwd {
    
    //save the current password and account
    pwd = [@"" mutableCopy];
    [SAMKeychain setPassword:pwd forService:JC_Service_Account account:account];
    
    //save the current account for the last account
    [SAMKeychain setPassword:account forService:JC_Service_Account account:JC_LastLoginAccount];
}

+ (void)saveAccountWithoutPWD:(NSString *)account {
    NSArray *accountList = [self refreshAccount:@""];
    __weak typeof (self) weakSelf = self;
    __block BOOL bFound = NO;
    [accountList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *saveAccount = (NSString *)obj;
        if (saveAccount && [saveAccount compare:account] == NSOrderedSame) {
            NSString *pwd = [weakSelf getAccountPWD:account];
            if (pwd) {
                [weakSelf saveAccount:account pwd:pwd];
            }
            else
            {
                [SAMKeychain setPassword:account forService:JC_Service_Account account:JC_LastLoginAccount];
            }
            
            *stop = YES;
            bFound = YES;
        }
    }];
    
    if (!bFound) {
        [SAMKeychain setPassword:account forService:JC_Service_Account account:JC_LastLoginAccount];
    }
}

+(void)deleteAccount:(NSString *)account {
    [SAMKeychain deletePasswordForService:JC_Service_Account account:JC_LastLoginAccount];
    NSError *error = nil;
    [SAMKeychain deletePasswordForService:JC_Service_Account account:JC_LastLoginAccount error:&error];
}

+ (NSArray *)getAccountList {
    NSArray *accountArray = [SAMKeychain accountsForService:JC_Service_Account];
    if (accountArray != nil) {
        NSString *now_pwd = @"";
        NSString *now_account = [SAMKeychain passwordForService:JC_Service_Account account:JC_LastLoginAccount];
        for (NSDictionary *tUser in accountArray) {
            NSString *tUserAccount = [tUser objectForKey:kSAMKeychainAccountKey];
            if ([tUserAccount isEqualToString:now_account]) {
                now_pwd = [SAMKeychain passwordForService:JC_Service_Account account:now_account];
            }
        }
    }
    
    return accountArray;
}

+ (NSString *)getAccountPWD {
    NSString *now_account = [JCAccount getAccount];
    return [JCAccount getAccountPWD:now_account];
}

+ (NSString *)getAccountPWD:(NSString *)now_account {
    NSString *now_pwd = @"";
    NSArray *accountArray = [SAMKeychain accountsForService:JC_Service_Account];
    if (accountArray != nil) {
        for (NSDictionary *tUser in accountArray) {
            NSString *tUserAccount = [tUser objectForKey:kSAMKeychainAccountKey];
            if ([tUserAccount isEqualToString:now_account]) {
                now_pwd = [SAMKeychain passwordForService:JC_Service_Account account:now_account];
                break;
            }
        }
    }
    
    return now_pwd;
}


+ (NSString *)getAccount {
    return [SAMKeychain passwordForService:JC_Service_Account account:JC_LastLoginAccount];;
}

@end
