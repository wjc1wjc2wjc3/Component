//
//  JCQueue.m
//  Component
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "JCQueue.h"

@implementation JCNode

@end

@implementation JCQueue

- (BOOL)isEmpty{
    return self.count == 0;
}

- (NSInteger)size {
    return self.count;
}

- (void)enqueue:(NSString *)value {
    
    JCNode *oldLast = self.last;
    self.last = [[JCNode alloc]init];
    self.last.value = value;
    self.last.next = NULL;
    oldLast.next = self.last;
    if ([self isEmpty]) {
        self.first = self.last;
    }else{
        oldLast.next = self.last;
    }
    self.count = self.count + 1;
}

-(NSString *)dequeue {
    if ([self isEmpty]) {
        return [NSString stringWithFormat:@"-1"];
    }
    NSString  *result = self.first.value;
    self.first = self.first.next;
    self.count = self.count-1;
    return result;
}

-(void)remove:(NSString *)value {
    //判断是不是头部节点
    if ([self.first.value isEqualToString:value]) {
        self.first = self.first.next;
        self.count = self.count-1;
    }else{
        JCNode *node = self.first;
        while (node!=NULL) {
            if ([node.next.value isEqualToString:value]) {
                node.next = node.next.next;
                self.count = self.count-1;
                break;
            }
            node = node.next;
        }
    }
}


@end
