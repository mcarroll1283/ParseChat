//
//  ChatViewController.swift
//  Parse
//
//  Created by Matthew Carroll on 4/30/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendClicked(sender: AnyObject) {
        var message = PFObject(className: "Message")
        message["text"] = chatTextField.text
        message.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                println("chat worked")
            } else {
                println("chat didn't work")
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as ChatMessageCell
        
        cell.messageLabel.text = messages![indexPath.row]["text"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        } else {
            return 0
        }
    }
    
    func onTimer() {
        var messages = PFQuery(className: "Message")
        
        messages.findObjectsInBackgroundWithBlock() {
            (objects, error) in
            if error == nil {
                self.messages = objects as? [PFObject]
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                    self.tableView.reloadData()
                }
                println("\(objects.count)")
            } else {
                println("\(error!.description)")
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
