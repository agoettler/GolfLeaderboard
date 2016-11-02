//
//  HolePrizeTabViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/1/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class HolePrizeTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData // access to global event

    var holePrizesArray: [HolePrize]!
    // MARK: - Table view data source
    
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return holePrizesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        holePrizesArray = globals.globalEvent.holePrizes
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
