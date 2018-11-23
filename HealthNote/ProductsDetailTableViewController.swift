//
//  ProductsDetailTableViewController.swift
//  HealthFood
//
//  Created by Apple on 2018/10/27.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ProductsDetailTableViewController: UITableViewController {
    var bannerView: GADBannerView?
    
    @IBOutlet weak var licenseNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passTimeLabel: UILabel!
    @IBOutlet weak var applyCompanyLabel: UILabel!
    @IBOutlet weak var licenseStatusLabel: UILabel!
    @IBOutlet weak var compositionLabel: UILabel!
    @IBOutlet weak var effectLabel: UILabel!
    @IBOutlet weak var effectDetailLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    

    var healthFood: HealthFoodItem?
    var index:IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "iPhone 8@2x.png"))
        self.tableView.backgroundView?.alpha = 0.5
        
        //adSize有多種選擇，可以去官方文件裡面參考，這邊用的是iphone直立使用的size
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        //下面這邊unitID，請填如你自己的，或是官方給的測試ID
        bannerView?.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView?.delegate = self
        bannerView?.rootViewController = self
        bannerView?.load(GADRequest())
        
        guard let index = index else {
            print("index is nil")
            return
        }
        licenseNumberLabel.text = RSSDownloader.results[index.row].licenseNumber
        nameLabel.text = RSSDownloader.results[index.row].name
        passTimeLabel.text = RSSDownloader.results[index.row].passTime
        applyCompanyLabel.text = RSSDownloader.results[index.row].applyCompany
        licenseStatusLabel.text = RSSDownloader.results[index.row].licenseStatus
        compositionLabel.text = RSSDownloader.results[index.row].composition
        effectLabel.text = RSSDownloader.results[index.row].effect
        effectDetailLabel.text = RSSDownloader.results[index.row].effectDetail
        warningLabel.text = RSSDownloader.results[index.row].warning
        noticeLabel.text = RSSDownloader.results[index.row].notice
        
        warningLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        noticeLabel.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        
        
        
    }
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            bannerView.transform = CGAffineTransform.identity
        }
        //如果有印出這一行，表示你成功從AdMod那邊下載到廣告
//        print("Banner loaded successfully")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        //這邊就是我提到會印出"no ad to show"的地方，可以用我上面提到的兩個部分去修改看看
//        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //這邊會讓你的banner固定在Footer，而且使用在滑動的時候他都一直會在
        //你把Footer改成header，也是一樣會成功。
        return bannerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return bannerView!.frame.height
    }
    

}
