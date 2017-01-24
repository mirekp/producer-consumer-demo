//
//  BlockingQueue-objc.m
//  producer-consumer-demo
//
//  Created by Mirek Petricek on 24/01/2017.
//  Copyright © 2017 Mirek Petricek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockingQueue.h"
#import "BlockingQueue-objc.h"

@implementation BlockingQueueObjc {
    NSMutableArray<NSObject*>* storage;
    NSCondition* lock;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        storage = [[NSMutableArray alloc] init];
        lock = [[NSCondition alloc] init];
    }
    return self;
}

- (NSObject*) dequeue
{
    __block id object;
    [lock lock];
    while (storage.count == 0) {
        [lock wait];
    }
    object = storage.firstObject;
    [storage removeObjectAtIndex:0];
    [lock unlock];
    
    return object;
}

- (void) enqueue:(NSObject*)object
{
    [lock lock];
    [storage addObject:object];
    [lock signal];
    [lock unlock];
}

@end
