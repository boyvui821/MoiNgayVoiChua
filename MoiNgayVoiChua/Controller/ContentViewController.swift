//
//  ContentViewController.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/7/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import UIKit
import SDWebImage
import FBSDKShareKit
import Social
import Toaster
import ProgressHUD



class ContentViewController: UIViewController {
    
    @IBOutlet weak var imgContent: ShadowContentImage!
    
    @IBOutlet weak var txtContent: UITextView!
    
    var currentLesson:Lesson!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: currentLesson.imageLink)
        imgContent.sd_setImage(with: url)
        txtContent.text = currentLesson.content
        txtContent.scrollsToTop = true;
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.txtContent.setContentOffset(.zero, animated: false)
    }
    
    @IBAction func PressBack(_ sender: Any) {
        print("PressBack")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PressShareFB(_ sender: Any) {
        print("PressShareFaceBook")
        AlertService.shared.ShowActionSheet(with: self) {
            print("Chia sẻ ngay")
            let myContent = FBSDKShareLinkContent();
            myContent.hashtag = FBSDKHashtag(string: "#Mỗi Ngày Với Chúa")
            myContent.quote = "Cỏ khô, hoa rụng nhưng lời Đức Chúa Trời chúng ta còn mãi đời đởi. (Ê sai 40:8)"
            myContent.contentURL = URL(string: ITUNE_APP_URL);
            let shareDialog = FBSDKShareDialog();
            shareDialog.fromViewController = self;
            shareDialog.mode = .native;
            shareDialog.shareContent = myContent;
            shareDialog.show();
            
        }
    }
    
    @IBAction func PressCopyContent(_ sender: Any) {
        let allLesson = currentLesson.lesson + " \n " + currentLesson.content
        
        UIPasteboard.general.string = allLesson
        //        Toast(text: "Nội dung đã được sao chép \n Hãy dán lên Facebook và chia sẻ với mọi người!",
        //              duration: Delay.long).show()
        
        ProgressHUD.showSuccess("Nội dung đã được sao chép \n Hãy dán lên Facebook và chia sẻ với mọi người!")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


