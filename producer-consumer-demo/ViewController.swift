//
//  ViewController.swift
//  producer-consumer-demo
//
//  Created by Mirek Petricek on 23/01/2017.
//  Copyright © 2017 Mirek Petricek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, ProdCustQueueDelegate, UITableViewDelegate {

    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!

    var queue: BlockingQueue!
    
    var leftObjects = 0
    var rightOjects = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftTableView.register(DemoCell.self, forCellReuseIdentifier: "DemoCell")
        rightTableView.register(DemoCell.self, forCellReuseIdentifier: "DemoCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        leftTableView.reloadData()
        rightTableView.reloadData()
        
        //queue = BlockingQueueSwift()

        queue = BlockingQueueObjc()
        
        queue.delegate = self
        queue.start()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "DemoCell", for: indexPath) as! DemoCell
        
        if tableView == leftTableView {
            cell.contentView.backgroundColor = UIColor.blue
        } else {
            cell.contentView.backgroundColor = UIColor.red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == leftTableView {
            return leftObjects
        } else {
            return rightOjects
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func didDequeueElement() {
        DispatchQueue.main.async {
            self.leftObjects -= 1
            self.rightOjects += 1
            
            self.leftTableView.reloadData()
            self.rightTableView.reloadData()
        }
    }
    
    func didEnqueueElement() {
        DispatchQueue.main.async {
            self.leftObjects += 1
            self.leftTableView.reloadData()
        }
    }

}

