//
//  ViewController.swift
//  HealthFood
//
//  Created by Apple on 2018/10/17.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController ,XMLParserDelegate{
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    private var typeSegue:TypeSegue?
    let message = "目前認可的保健功效評估方法共有十三項.本App將衛福部審核通過之健康食品資訊分類提供參考.\n\n資料來源政府公開資訊平台.\n資料更新日期2018/09/28"
    override func viewDidLoad() {
        super.viewDidLoad()
        //判斷user是否首次進入app
        if (!(UserDefaults.standard.bool(forKey: "first"))) {
            UserDefaults.standard.set(true, forKey:"first")
            
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        let request = GADRequest()
        bannerView.adUnitID = "ca-app-pub-2042437931802449/5573228523"
        bannerView.rootViewController = self
        bannerView.load(request)
        
    }
    
    
    @IBAction func infoBtn(_ sender: Any) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HealthNote" {
            return
        }
        let resultsViewController = segue.destination as!
        ProductsItemTableViewController
        resultsViewController.segueType.segue = segue.identifier!
    }
    
}


