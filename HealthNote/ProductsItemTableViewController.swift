//
//  GastrointestinalTableViewController.swift
//  HealthFood
//
//  Created by Apple on 2018/10/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ProductsItemTableViewController: UITableViewController {
    var bannerView: GADBannerView?
    
   
    
    var parser:XMLParser!
    private let pasee = RSSDownloader()
    var segueType = DownloadType.shared
    let downType = DownloadType.shared
    static var healthNotes = [HealthFoodItem]()
    var healthNote: HealthFoodItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "iPhone 8@2x.png"))
        self.tableView.backgroundView?.alpha = 0.5
        
        //adSize有多種選擇，可以去官方文件裡面參考，這邊用的是iphone直立使用的size
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        //下面這邊unitID，請填如你自己的，或是官方給的測試ID
        bannerView?.adUnitID = "ca-app-pub-2042437931802449/6876014983"
        bannerView?.delegate = self
        bannerView?.rootViewController = self
        bannerView?.load(GADRequest())
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //註冊通知
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
        
        downType.type = segueType.segue
        download()
    }
    
    //有註冊就要解註冊 如果ViewController
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.removeObserver(self)
        save()
    }
    @objc func save(){
        HealthFoodItem.sava(ProductsItemTableViewController.healthNotes)
    }
    func download(){
        parser = XMLParser(contentsOf: NSURL(fileURLWithPath:
            Bundle.main.path(forResource: "HealthNote",ofType: "xml")!) as URL)
        
        pasee.pass(parser)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        RSSDownloader.results.removeAll()
//                print("\(#function) \(#line) \(RSSDownloader.results.count)")
    }
    
    

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RSSDownloader.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GFICell", for: indexPath) as! ProductsItemTableViewCell
        // Configure the cell...
        
        let item = RSSDownloader.results[indexPath.row]
//        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = item.applyCompany
        cell.healthNote = item
        
        let cellAudioButton = UIButton(type: .custom)
        cellAudioButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        cellAudioButton.addTarget(self, action: #selector(accessoryButtonTapped(sender:)), for: .touchUpInside)
        cellAudioButton.setImage(UIImage(named: "圖片 1.png"), for: .normal)
        cellAudioButton.contentMode = .scaleAspectFit
        cellAudioButton.tag = indexPath.row
        cell.accessoryView = cellAudioButton as UIView
            
        return cell
    }
    
    
    
    @objc
    func accessoryButtonTapped(sender : AnyObject){
   
        guard let index = sender.tag else {
            return
        }
        let item = RSSDownloader.results[index]
        let alert = UIAlertController(title: "已加入筆記", message: "\(item.name ?? "")", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        ProductsItemTableViewController.healthNotes.append(item)
//        print("HealthNoteAppend = \(ProductsItemTableViewController.healthNotes.count)")
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let productsDetail = segue.destination as! ProductsDetailTableViewController
                productsDetail.index = indexPath
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //這邊會讓你的banner固定在Footer，而且使用在滑動的時候他都一直會在
        //你把Footer改成header，也是一樣會成功。
        return bannerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return bannerView!.frame.height
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.9,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
}

extension UITableViewController :GADBannerViewDelegate{
    
    private func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            bannerView.transform = CGAffineTransform.identity
        }
        //如果有印出這一行，表示你成功從AdMod那邊下載到廣告
        //        print("Banner loaded successfully")
    }
    
    private func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        //這邊就是我提到會印出"no ad to show"的地方，可以用我上面提到的兩個部分去修改看看
        //                print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        
    }
}
