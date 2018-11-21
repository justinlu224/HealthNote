//
//  HealthNoteTableViewController.swift
//  HealthFood
//
//  Created by Apple on 2018/11/6.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class HealthNoteTableViewController: UITableViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    var save = ProductsItemTableViewController()
    var indexPath: Int?
    var healthNotes = ProductsItemTableViewController.healthNotes
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定tableview背景圖
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "iPhone 8@2x.png"))
        self.tableView.backgroundView?.alpha = 0.5

        guard let index = indexPath else {
            return
        }
        titleTextField.text = healthNotes[index].title
        noteTextView.text = healthNotes[index].note
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        guard let index = indexPath else {
            return
        }
        healthNotes[index].title = titleTextField.text ?? ""
        healthNotes[index].note = noteTextView.text ?? ""
        save.save()
    }
    

}
