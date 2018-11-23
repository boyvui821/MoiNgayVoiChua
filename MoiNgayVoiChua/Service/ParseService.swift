//
//  ParseService.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/7/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import Foundation
import Parse

class ParseService{
    private init(){}
    
    static let shared = ParseService()
    var queryScroll:PFQuery<PFObject>!
    var queryTable:PFQuery<PFObject>!
    
    //Lấy dữ liệu for scrollview
    func getImageForScroll(completeHandle: @escaping (_ listImageScroll:[ImageScroll]?)->Void){
        var listImageScroll = [ImageScroll]()
        
        queryScroll = PFQuery(className: "ScrollPage")
        queryScroll.findObjectsInBackground { (objects, error) in
            if let error = error {
                // Log details of the failure
                print("Error Get Data ScrollView: " + error.localizedDescription)
            } else if let objects = objects {
                print("objects: \(objects)")
                // The find succeeded.
                for obj in objects{
                    let stt = obj["STT"] as! Int
                    let link = obj["ImageLink"] as! String
                    listImageScroll.append(ImageScroll(stt: stt,
                                                       imageLink: link))
                }
                completeHandle(listImageScroll)
            }
        }
    }
    
    //MARK: - Lấy dữ liệu cho TableView Menu
    func getLessonForTable(completeHandle: @escaping (_ listImageScroll:[Lesson]?)->Void){
        var listLesson = [Lesson]()
        
        queryTable = PFQuery(className: "BaiHoc")
        queryTable.limit = 1000;
        queryTable.findObjectsInBackground { (objects, error) in
            if let error = error {
                // Log details of the failure
                print("Error Get Data Table: " + error.localizedDescription)
            } else if let objects = objects {
                //The find succeeded.
                for obj in objects{
                    let stt = obj["STT"] as! Int
                    let lesson = obj["TenBaiHoc"] as! String
                    let godWord = obj["CauKinhThanh"] as! String
                    let content = obj["NoiDung"] as! String
                    let link = obj["ImageLinks"] as! String
                    
                    listLesson.append(Lesson(stt: stt,
                                             lesson: lesson,
                                             godWord: godWord,
                                             content: content,
                                             imageLink: link))
                }
                completeHandle(listLesson)
            }
        }
    }
}
