//
//  JCQueue.h
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

//先进先出队列

@interface JCNode : NSObject

@property (strong,nonatomic) NSString *value;

@property (strong,nonatomic) JCNode *next;

@end

@interface JCQueue : NSObject


//最先入列的元素
@property (strong,nonatomic) JCNode *first;

//最后入列的元素
@property (strong,nonatomic) JCNode *last;

@property (assign,nonatomic) NSInteger count;

- (BOOL)isEmpty;

- (NSInteger)size;

- (void)enqueue:(NSString *)value;

- (NSString *)dequeue;

- (void)remove:(NSString *)value;

@end
