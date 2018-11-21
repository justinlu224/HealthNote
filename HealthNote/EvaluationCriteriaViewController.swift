//
//  EvaluationCriteriaViewController.swift
//  HealthFood
//
//  Created by Apple on 2018/10/19.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class EvaluationCriteriaViewController: UIViewController {
    
    @IBOutlet weak var showLabel: UILabel!
    
    let healthFood = EvaluationCriteria()
    var segueType = DownloadType.shared.segue
    
    override func viewDidLoad() {
        super.viewDidLoad()
updateUI()
    
    }
    
    func updateUI() {
            showLabel.text = healthFood.evaluationCriteria[segueType]
        
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
