//
//  TodayViewController.swift
//  SpeedDialer
//
//  Created by Kireto on 3/27/15.
//  Copyright (c) 2015 Kireto. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.hideExtraButtons(true)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.hideExtraButtons(true)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        numLabel.text! = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.
        completionHandler(NCUpdateResult.NewData)
    }
    //MARK: customize left margin
    func widgetMarginInsetsForProposedMarginInsets(var defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        defaultMarginInsets.left = 0
        return defaultMarginInsets
    }
    
    //MARK: IBActions
    @IBAction func deleteBtnSelected(sender: UIButton) {
        if !numLabel.text!.isEmpty {
            numLabel.text! = numLabel.text!.substringToIndex(advance(numLabel.text!.endIndex, -1))
            self.hideExtraButtons(numLabel.text!.isEmpty)
        }
    }
    @IBAction func numBtnSelected(sender: UIButton) {
        numLabel.text! = "\(numLabel.text!)\(sender.titleLabel!.text!)"
        self.hideExtraButtons(false)
    }
    @IBAction func makeCall(sender: UIButton) {
        if !numLabel.text!.isEmpty {
            self.extensionContext?.openURL(NSURL(string: "tel:\(numLabel.text!)")!, completionHandler: { (success) -> Void in
                
            })
        }
    }
    @IBAction func sendSMS(sender: UIButton) {
        if !numLabel.text!.isEmpty {
            self.extensionContext?.openURL(NSURL(string: "sms:\(numLabel.text!)")!, completionHandler: { (success) -> Void in
                
            })
        }
    }
    //MARK: hide show extra buttons
    func hideExtraButtons(shouldHide: Bool) {
        deleteBtn.hidden = shouldHide
        callBtn.hidden = shouldHide
        messageBtn.hidden = shouldHide
    }
}
