//
//  InfoViewController.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/13/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import UIKit
import ActiveLabel

class InfoViewController: UIViewController {
    
    
    @IBOutlet weak var lbLink: ActiveLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbLink.numberOfLines = 0
        lbLink.enabledTypes = [.url,.hashtag]
        lbLink.handleHashtagTap { (strHastag) in
            let strUrl = "https://www.facebook.com/MNVCTHIEUNHI/"
            let url = URL(string: strUrl)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func PressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
