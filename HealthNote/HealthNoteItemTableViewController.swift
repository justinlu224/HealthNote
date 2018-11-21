//
//  HealthNoteTableViewController.swift
//  HealthFood
///Users/apple/Desktop/xcode/practice/HealthNote/HealthNote
//  Created by Apple on 2018/11/6.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class HealthNoteItemTableViewController: UITableViewController  {

    @IBOutlet var myTableView: UITableView!
    let selectedBackgroundView = UIView()
    var save = ProductsItemTableViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let healthFoodItem = HealthFoodItem.load() {
            self.tableView.backgroundView = UIImageView(image: UIImage(named: "iPhone 8@2x.png"))
            self.tableView.backgroundView?.alpha = 0.5
            ProductsItemTableViewController.healthNotes = healthFoodItem
//            print("viewDidLoad = \(ProductsItemTableViewController.healthNotes.count)")
            
            selectedBackgroundView.backgroundColor = #colorLiteral(red: 0.9446463954, green: 1, blue: 0.8722370393, alpha: 1)
            tableView.reloadData()
            

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        save.save()
    }

    // MARK: - Table view data source

    @IBAction func addNoteBtn(_ sender: Any) {
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProductsItemTableViewController.healthNotes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let item = ProductsItemTableViewController.healthNotes[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.applyCompany
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ProductsItemTableViewController.healthNotes.remove(at: indexPath.row)
                      tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        guard let indexPath = tableView.indexPathForSelectedRow else{
            return
        }
        let healthNoteTVC = segue.destination as! HealthNoteTableViewController
        healthNoteTVC.indexPath = indexPath.row
    }
}


