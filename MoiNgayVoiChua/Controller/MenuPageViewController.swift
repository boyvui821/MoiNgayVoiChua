//
//  MenuPageViewController.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/7/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import UIKit
import Parse
import SDWebImage
import SnapKit
import GoogleMobileAds
import ProgressHUD

class MenuPageViewController: UIViewController {
    
    @IBOutlet weak var scrollViewImage: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableLesson: UITableView!
    
    var listImageScroll = [ImageScroll]()
    var listImage = [ShadowImage]();
    var lastContentOffSet:CGFloat = 0;
    
    var listLesson = [Lesson]();
    
    //quảng cáo interstitial
    var interstitial: GADInterstitial!
    
    var currIndexPath:IndexPath!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ADMOB
        interstitial = createAndLoadInterstitial()
        
        //        print("--SIZECLASS--")
        //        print(UIScreen.main.traitCollection.horizontalSizeClass.rawValue)
        //        print(UIScreen.main.traitCollection.verticalSizeClass.rawValue)
        
        scrollViewImage.delegate = self;
        tableLesson.delegate = self;
        tableLesson.dataSource = self;
        
        scrollViewImage.isPagingEnabled = true
        scrollViewImage.showsHorizontalScrollIndicator = false
        ParseService.shared.getImageForScroll { (imagesScroll) in
            
            self.listImageScroll = imagesScroll!
            self.pageControl.numberOfPages = (imagesScroll?.count)!
            self.pageControl.currentPage = 0;
            
            self.setupSlideForScrollView();
        }
        
        ParseService.shared.getLessonForTable { (lessons) in
            self.listLesson = lessons!;
            self.tableLesson.reloadData();
        }
        
        //Bắt sự kiện qua notification khi search
        NotificationCenter.default.addObserver(self, selector: #selector(handleSearch(_:)), name: NSNotification.Name("searchNotification"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Request review khi đủ sổ lần mở app
        StoreReviewHelper.checkAndAskForReview()
    }
    
    //MARK: - ADMOB
    func createAndLoadInterstitial() -> GADInterstitial {
        //ADMOB
        //Sample uinit id: ca-app-pub-3940256099942544/4411468910
        //My uinit id: ca-app-pub-3167518105754283/7007433383
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3167518105754283/7007433383")
        interstitial.delegate = self
        
        let request = GADRequest()
        //Chỉ dùng dòng này khi test device, khi add app thì xoá
        request.testDevices = [ "43744b22b205846017e49d0314e591e4", kGADSimulatorID];
        interstitial.load(request)
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen");
        interstitial = createAndLoadInterstitial()
        
        //Nhảy tới trang nội dung
        gotoContentVC()
    }
    
    func setupSlideForScrollView(){
        let numImg = listImageScroll.count
        scrollViewImage.contentSize = CGSize(width: view.frame.width * CGFloat(numImg), height: scrollViewImage.frame.height)
        scrollViewImage.isPagingEnabled = true
        
        for i in 0..<numImg{
            //Tạo uiView để add Image vào uiview sau đó add vào scrollview
            let uiView = UIView();
            uiView.backgroundColor = UIColor.white
            uiView.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: self.view.frame.width, height: scrollViewImage.frame.height)
            scrollViewImage.addSubview(uiView)
            
            
            let imgView = ShadowImage();
            imgView.setupview()
            imgView.backgroundColor = UIColor.yellow
            uiView.addSubview(imgView)
            
            let sizeclassW = UIScreen.main.traitCollection.horizontalSizeClass.rawValue
            let sizeclassH = UIScreen.main.traitCollection.verticalSizeClass.rawValue
            
            if sizeclassW == 1 && sizeclassH == 2 {
                imgView.snp.makeConstraints { (make) in
                    //size class wC hR
                    make.width.equalTo(250)
                    make.height.equalTo(170)
                    make.centerY.equalTo(uiView)
                    make.centerX.equalTo(uiView)
                }
            }else if sizeclassW == 2 && sizeclassH == 2{ //wR hR
                imgView.snp.makeConstraints { (make) in
                    //size class wR hR
                    make.width.equalTo(400)
                    make.height.equalTo(240)
                    make.centerY.equalTo(uiView)
                    make.centerX.equalTo(uiView)
                }
            }
            
            imgView.sd_setImage(with: URL(string: listImageScroll[i].imageLink))
            listImage.append(imgView)
        }
    }
    
    @IBAction func PressBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func PressSearch(_ sender: Any) {
        print("You press search")
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchViewController
        searchVC.modalPresentationStyle = .overCurrentContext
        searchVC.totalLesson = listLesson.count
        self.present(searchVC, animated: true, completion: nil)
    }
    
    //Scroll tableview to indexpath
    @objc func handleSearch(_ sender:Notification){
        guard let index = sender.object as? Int else {return }
        let indexPath = IndexPath(row: index - 1, section: 0)
        tableLesson.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: true)
    }
    
}


extension MenuPageViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / self.view.frame.width)
        self.pageControl.currentPage = Int(pageIndex)
        
        if scrollViewImage.contentOffset.x > lastContentOffSet{
            print("Scroll Right")
            UIView.animate(withDuration: 0.7) {
                if Int(pageIndex) != self.listImage.count - 1{
                    self.listImage[Int(pageIndex)].transform = CGAffineTransform(scaleX:1, y: 1)
                    self.listImage[Int(pageIndex)+1].transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                }else{
                    self.listImage[Int(pageIndex)].transform = CGAffineTransform(scaleX:1, y: 1)
                }
            }
        }else if scrollViewImage.contentOffset.x < lastContentOffSet{
            print("Scroll Left")
            UIView.animate(withDuration: 0.7) {
                if Int(pageIndex) != 0{
                    self.listImage[Int(pageIndex)].transform = CGAffineTransform(scaleX:1, y: 1)
                    self.listImage[Int(pageIndex)-1].transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                }else{
                    self.listImage[Int(pageIndex)].transform = CGAffineTransform(scaleX:1, y: 1)
                }
            }
        }
        lastContentOffSet = scrollView.contentOffset.x
    }
}

extension MenuPageViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLesson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseCell", for: indexPath) as! BaiHocCell
        let lesson = listLesson[indexPath.row];
        cell.configure(lesson: lesson)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currIndexPath = indexPath
        
        //Khi có QC và khi ko có QC
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
            gotoContentVC()
        }
        
        gotoContentVC();
    }
    
    func gotoContentVC(){
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        contentVC.currentLesson = listLesson[currIndexPath.row]
        
        self.present(contentVC, animated: true, completion: nil)
    }
}

extension MenuPageViewController:GADInterstitialDelegate{
    
}
