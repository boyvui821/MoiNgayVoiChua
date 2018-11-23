//
//  DownloadService.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/12/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import Foundation
import UIKit

class DownloadService{
    private init(){}
    static let shared = DownloadService()
    
    func downloadImage(with strURL: String, completeHandle: @escaping (URL)->Void){
        guard let url = URL(string: strURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let fileManager = FileManager.default
            guard let data = data, let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            
            //Tạo đường dẫn tới thư mục chứa file
            let fileUrl = documentUrl.appendingPathComponent("image.jpg")
            
            do{
                try data.write(to: fileUrl)
                DispatchQueue.main.async {
                    completeHandle(fileUrl)
                }
            }catch{
                print("Error Download Image: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
