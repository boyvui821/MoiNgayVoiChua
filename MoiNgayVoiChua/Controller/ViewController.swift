//
//  ViewController.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/6/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        print("--SIZECLASS--")
        //        print(self.traitCollection.horizontalSizeClass.rawValue)
        //        print(self.traitCollection.verticalSizeClass.rawValue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let internetState = CheckInternetService.Connection()
        if internetState == false{
            AlertService.shared.ShowRequestInternet(with: self)
        }
    }
    
    @IBAction func TapToView(_ sender: Any) {
        let internetState = CheckInternetService.Connection()
        if internetState == false{
            AlertService.shared.ShowRequestInternet(with: self)
        }else{
            let menuVC = storyboard?.instantiateViewController(withIdentifier: "MenuPage") as! MenuPageViewController
            self.present(menuVC, animated: true, completion: nil)
        }
    }
    
}

