//
//  MPQueue.h
//  producer-consumer-demo
//
//  Created by Mirek Petricek on 23/01/2017.
//  Copyright © 2017 Mirek Petricek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ProdCustQueueDelegate
- (void) didEnqueueElement;
- (void) didDequeueElement;
@end

@interface BlockingQueue: NSObject

- (void) start;
- (NSObject *) dequeue;
- (void) enqueue:(NSObject*)object;

@property (nonatomic, weak)  __nullable id <ProdCustQueueDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
