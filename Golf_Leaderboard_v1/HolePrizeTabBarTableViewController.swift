//
//  HolePrizeTabBarTableViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/4/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class HolePrizeTabBarTableViewController: UITableViewController {

    
    let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData // access to global event
    
    var holePrizesArray: [HolePrize]!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "holePrizeReuseID", for: indexPath)
        let cellNum:Int = indexPath.row
        
        // Configure the cell...
        print("prize table: \(holePrizesArray[cellNum].prize)")
        cell.textLabel!.text = holePrizesArray[cellNum].prize
        cell.detailTextLabel!.text = holePrizesArray[cellNum].currentWinner
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        holePrizesArray = globals.globalEvent.holePrizes

        print("hp count \(holePrizesArray.count)")
        holePrizesArray = globals.globalEvent.holePrizes
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HolePrizeTabViewController Did Load")
        holePrizesArray = globals.globalEvent.holePrizes
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //self.navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destVC:UpdateHolePrizeViewController = segue.destination as! UpdateHolePrizeViewController
        let prizeIndex = self.tableView.indexPathForSelectedRow
        
        destVC.selectedPrize = globals.globalEvent.holePrizes[(prizeIndex?.row)!]
    }
    
    


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
