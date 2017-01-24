//
//  MPQueue.m
//  producer-consumer-demo
//
//  Created by Mirek Petricek on 23/01/2017.
//  Copyright © 2017 Mirek Petricek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockingQueue.h"


// abstract class 
@implementation BlockingQueue

- (void) start {
    
    dispatch_queue_t producerThread = dispatch_queue_create("producer", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t consumerThread = dispatch_queue_create("consumer", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(producerThread, ^{
        
        while(true) {
            [self enqueue:@"something"];
            [self.delegate didEnqueueElement];
            [NSThread sleepForTimeInterval:arc4random() % 2];
        }
        
    });
    
    dispatch_async(consumerThread, ^{
        
        while(true) {
            [self dequeue];
            [self.delegate didDequeueElement];
            [NSThread sleepForTimeInterval:arc4random() % 2];
        }
        
    });
    
}

- (NSObject*) dequeue
{
     return @"";
}

- (void) enqueue:(NSObject*)object
{

}

@end


