//
//  LeaderScorecardCollectionVC.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/30/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LeaderScorecardCollectionVC: UICollectionViewController {
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet var scorecardCollectionView: UICollectionView!
    
    
    
    
    var selectedPlayer:Player!
    
    
    
    let scorecardCellIdentifier = "ScorecardCell"
    
    let globals: CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData
    
    // override this property to change which player's scorecard is displayed
    var player: Player!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.groupTableViewBackground
        //self.scorecardCollectionView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationBar.title = player.name
        self.scorecardCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        // return number of sections (rows)
        return globals.globalEvent.course.holes.count + 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let customLayout = self.collectionView!.collectionViewLayout as! CustomCollectionViewLayout
        
        // for unknown reasons, the number of "columns" or sections must be set in the CustomCollectionViewLayout
        return customLayout.numberOfColumns
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        // if cell is in top row
        if indexPath.section == 0
        {
            let labelCell : ScorecardCell = collectionView.dequeueReusableCell(withReuseIdentifier: scorecardCellIdentifier, for: indexPath) as! ScorecardCell
            labelCell.backgroundColor = UIColor.white
            
            switch indexPath.row
            {
            case 0:
                labelCell.cellLabel.text = "Hole"
            case 1:
                labelCell.cellLabel.text = "Yards"
            case 2:
                labelCell.cellLabel.text = "Par"
            case 3:
                labelCell.cellLabel.text = "Handicap"
            case 4:
                labelCell.cellLabel.text = "Score"
            default:
                labelCell.cellLabel.text = ""
            }
            
            return labelCell
        }
            
            // if cell is in any other row
        else
        {
            // if cell is in first column
            if indexPath.row == 0
            {
                let holeCell : ScorecardCell = collectionView.dequeueReusableCell(withReuseIdentifier: scorecardCellIdentifier, for: indexPath) as! ScorecardCell
                holeCell.backgroundColor = UIColor.white
                
                holeCell.cellLabel.text = "\(globals.globalEvent.course.holes[indexPath.section - 1].number)"
                
                alternateCellColors(indexPath: indexPath, cell: holeCell)
                
                return holeCell
            }
                
                // if cell is in any other column
            else
            {
                let contentCell : ScorecardCell = collectionView .dequeueReusableCell(withReuseIdentifier: scorecardCellIdentifier, for: indexPath) as! ScorecardCell
                
                switch indexPath.row
                {
                case 1:
                    // yardage
                    contentCell.cellLabel.text = "\(globals.globalEvent.course.holes[indexPath.section - 1].yardage)"
                case 2:
                    // par
                    contentCell.cellLabel.text = "\(globals.globalEvent.course.holes[indexPath.section - 1].par)"
                case 3:
                    // handicap
                    contentCell.cellLabel.text = "\(globals.globalEvent.course.holes[indexPath.section - 1].handicap)"
                case 4:
                    // net score
                    // check for a submitted score for this hole
                    if /*globals.globalPlayer*/player.scorecard.grossScoreArray.indices.contains(indexPath.section-1) && player.scorecard[indexPath.section].grossScore != 0
                    {
                        var scoreValue: String = "\(player.scorecard[indexPath.section].netScore)"
                        
                        // append dots to the score if the player was given stroke(s) due to handicap
                        switch (/*globals.globalPlayer.*/player.scorecard[indexPath.section].grossScore - /*globals.globalPlayer.*/player.scorecard[indexPath.section].netScore) {
                        case 1:
                            scoreValue += " •"
                        case 2:
                            scoreValue += " ••"
                        default:
                            scoreValue += ""
                        }
                        
                        contentCell.cellLabel.text = scoreValue
                    }
                        
                    else
                    {
                        contentCell.cellLabel.text = "-"
                    }
                default:
                    contentCell.cellLabel.text = ""
                }
                
                alternateCellColors(indexPath: indexPath, cell: contentCell)
                
                return contentCell
            }
        }
    }
    
    func alternateCellColors(indexPath: IndexPath, cell: UICollectionViewCell)
    {
        if indexPath.section % 2 != 0
        {
            cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        }
            
        else
        {
            cell.backgroundColor = UIColor.white
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
     {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
     {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool
     {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool
     {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?)
     {
     
     }
     */
    
//////////////////////////////////////////////////
    
    
    
    
    
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        super.setPlayer(newPlayer: selectedPlayer)
        // Register cell classesS
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
*/
}
