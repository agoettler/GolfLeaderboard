//
//  HolePrizesTableTableViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 10/25/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit
import Firebase


class HolePrizesTableTableViewController: UITableViewController {

    

    var ref: FIRDatabaseReference!
    var holePrizesArray:[HolePrize] = [HolePrize]()
    var parentVC: CreateEventViewController!
    var holePrizesDictionary:Dictionary<Int,HolePrize> = Dictionary<Int,HolePrize>()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("HolePrizesTableViewController: viewDidLoad")
        ref = FIRDatabase.database().reference()
        //self.navigationController?.setNavigationBarHidden(false, animated: false)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return holePrizesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hpReuseID", for: indexPath)
        let cellNum:Int = indexPath.row

        // Configure the cell...
        print("prize table: \(holePrizesArray[cellNum].prize)")
        cell.textLabel!.text = holePrizesArray[cellNum].prize

        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("hp count \(holePrizesArray.count)")
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        parentVC.holePrizesArray = self.holePrizesArray
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier != "goToAddHP"){
            let destVC:CreateEventViewController = segue.destination as! CreateEventViewController
            destVC.holePrizesArray = self.holePrizesArray
        }
        else{
            let destVC:AddHolePrizeViewController = segue.destination as! AddHolePrizeViewController
            destVC.parentVC = self
        }
    }
    

}
