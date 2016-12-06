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
    var skinsDictionary: Dictionary<Int,String>!
    var skinsScores: Dictionary<Int,Int>!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        holePrizesArray = globals.globalEvent.holePrizes
        self.skinsDictionary = SkinsCalculator.updateSkins()
        self.skinsScores = SkinsCalculator.getMinScores()

        self.tableView.reloadData()
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if(globals.globalEvent.skins == false){
            return 0
        }
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if (segmentedControl.selectedSegmentIndex == 0) {
            return holePrizesArray.count
        }
        else{
            return skinsDictionary.count
        }
        
        /*
        if (section == 0) {
            return holePrizesArray.count
        }
        else{
            return skinsDictionary.count
        }
        */
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNum:Int = indexPath.row
        var cellName:String = "holePrizeReuseID"

        if (segmentedControl.selectedSegmentIndex == 1) {
            //cellName = "skinsReuseID"
            cellName = "skinsCustomCell"
        }



        if(cellName == "holePrizeReuseID"){
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
            // Configure the cell...
            print("prize table: \(holePrizesArray[cellNum].prize)")
            cell.textLabel!.text = holePrizesArray[cellNum].prize
            cell.detailTextLabel!.text = holePrizesArray[cellNum].currentWinner
            return cell
        }
        //else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! SkinsCustomCell
            let skinsHoles = skinsDictionary.keys.sorted()
            /*
            cell.textLabel!.text = "\(skinsHoles[cellNum])"
            cell.detailTextLabel!.text = skinsDictionary[skinsHoles[cellNum]]
            */
            cell.holeLabel!.text = "\(skinsHoles[cellNum])"
            cell.nameLabel!.text = skinsDictionary[skinsHoles[cellNum]]
        let score:String = String.init(stringInterpolationSegment: skinsScores[skinsHoles[cellNum]]!)
            cell.scoreLabel!.text = score
        //}
        
        
        
        
        /*
        let section:Int = indexPath.section
        let cellNum:Int = indexPath.row
        var cellName:String = "holePrizeReuseID"
        if section == 1{
            cellName = "skinsReuseID"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        
        print("cellnum: \(cellNum) section: \(section)")
        if(cellName == "holePrizeReuseID"){
        // Configure the cell...
            print("prize table: \(holePrizesArray[cellNum].prize)")
            cell.textLabel!.text = holePrizesArray[cellNum].prize
            cell.detailTextLabel!.text = holePrizesArray[cellNum].currentWinner
        }
        else{
            let skinsHoles = skinsDictionary.keys.sorted()
            cell.textLabel!.text = "Hole \(skinsHoles[cellNum])"
            cell.detailTextLabel!.text = skinsDictionary[skinsHoles[cellNum]]
        }
        */
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (segmentedControl.selectedSegmentIndex == 0) {
            return "Hole Prizes"
        }
        else{
            return "Skins"
        }
        
        /*
        if section == 0 {
            return "Hole Prizes"
        }
        else {
            return "Skins"
        }
        */
    }
     */
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        

        
        if (segmentedControl.selectedSegmentIndex == 1) {
            
            
            let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 20))
            
            let hole: UILabel = UILabel()
            let name: UILabel = UILabel()
            let score: UILabel = UILabel()
            hole.text = "Hole"
            name.text = "Name"
            score.text = "Score"
            
            
            
            let horizontalStack: UIStackView = UIStackView(arrangedSubviews: [hole, name, score])
            
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
            horizontalStack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5).isActive = true
            
            hole.textColor = UIColor.black
            name.textColor = UIColor.black
            score.textColor = UIColor.black
            
            /*
             rank.backgroundColor = UIColor.magenta
             name.backgroundColor = UIColor.cyan
             score.backgroundColor = UIColor.orange
             thru.backgroundColor = UIColor.yellow
             */
            
            headerView.backgroundColor = UIColor.groupTableViewBackground
            
            return headerView
        }
        
        let headerView2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 0))
        return headerView2
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(segmentedControl.selectedSegmentIndex == 1){
            return CGFloat(30)
        }
        return CGFloat(0)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        holePrizesArray = globals.globalEvent.holePrizes
        self.skinsDictionary = SkinsCalculator.updateSkins()
        self.skinsScores = SkinsCalculator.getMinScores()
        print("hp count \(holePrizesArray.count)")
        holePrizesArray = globals.globalEvent.holePrizes
        
        
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HolePrizeTabViewController Did Load")
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.groupTableViewBackground
        
        holePrizesArray = globals.globalEvent.holePrizes
        for aPrize in holePrizesArray{
            print("Aprize: \(aPrize.prize)")
        }
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        self.skinsDictionary = SkinsCalculator.updateSkins()
        self.skinsScores = SkinsCalculator.getMinScores()

        //self.navigationController?.setNavigationBarHidden(true, animated: false)
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
