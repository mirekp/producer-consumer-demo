//
//  BlockingQueue.swift
//  producer-consumer-demo
//
//  Created by Mirek Petricek on 24/01/2017.
//  Copyright © 2017 Mirek Petricek. All rights reserved.
//

import Foundation

class BlockingQueueSwift: BlockingQueue {
    
    var storage = [NSObject]()
    let lock = NSCondition()
    
    override func dequeue() -> NSObject {
        
        lock.lock()
        
        while (storage.count == 0) {
            lock.wait()
        }
        
        let object = storage.first!
        storage.removeFirst()
        lock.unlock()
        
        return object
    }
    
    override func enqueue(_ object: NSObject) {
        lock.lock()
        storage.append(object)
        lock.signal()
        lock.unlock()
    }
}
