//
//  ViewController2.swift
//  Vietcombanks
//
//  Created by Boss on 7/9/19.
//  Copyright © 2019 LuyệnĐào. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if  sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
        }else{
            firstView.alpha = 0
            secondView.alpha = 1
        }
    }
}
