//
//  LeaderboardTableViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/4/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    let globals:CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    var leaderboard:[[String]]!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        leaderboard = LeaderboardCalculator.updateLeaderboard()
        
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        leaderboard = LeaderboardCalculator.updateLeaderboard()

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
        // return globals.globalEvent.getPlayerNames().count
        return leaderboard.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCellReuseID", for: indexPath) as! LeaderboardCustomCellTableViewCell
        var currentPerson = leaderboard[indexPath.row]
        
        cell.rankLabel?.text = currentPerson[0]
        cell.nameLabel?.text = currentPerson[1]
        cell.scoreLabel?.text = currentPerson[3]
        cell.thruLabel?.text = currentPerson[2]

        //cell.textLabel?.text = "\(indexPath.row+1) \(leaderboard[indexPath.row])"
        /*
        cell.textLabel?.text = "\(indexPath.row+1) "
        cell.detailTextLabel?.text = " \(leaderboard[indexPath.row])"
         */
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(64.0)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Rank        Name        Score       Thru"
    }
 
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 64))
        
        let rank: UILabel = UILabel()
        let name: UILabel = UILabel()
        let score: UILabel = UILabel()
        let thru: UILabel = UILabel()
        rank.text = "Rank"
        name.text = "Name"
        score.text = "Score"
        thru.text = "Thru"
        
        
        
        let horizontalStack: UIStackView = UIStackView(arrangedSubviews: [rank, name, score, thru])
        
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = UILayoutConstraintAxis.horizontal
        horizontalStack.distribution = UIStackViewDistribution.equalCentering
        horizontalStack.alignment = UIStackViewAlignment.center
        //horizontalStack.spacing = 58
        
        headerView.addSubview(horizontalStack)
        
        horizontalStack.center = headerView.center
        horizontalStack.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        horizontalStack.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        //horizontalStack.topAnchor.constraint(equalTo: headerView.topAnchor)
        horizontalStack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12).isActive = true
        
        rank.textColor = UIColor.black
        name.textColor = UIColor.black
        score.textColor = UIColor.black
        thru.textColor = UIColor.black
        
        /*
         rank.backgroundColor = UIColor.magenta
         name.backgroundColor = UIColor.cyan
         score.backgroundColor = UIColor.orange
         thru.backgroundColor = UIColor.yellow
         
         rank.addConstraint(NSLayoutConstraint(item: rank, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 36))
         name.addConstraint(NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 50))
         score.addConstraint(NSLayoutConstraint(item: score, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 36))
         thru.addConstraint(NSLayoutConstraint(item: thru, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 36))
         */
        headerView.backgroundColor = UIColor.groupTableViewBackground
        
        
        return headerView
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
