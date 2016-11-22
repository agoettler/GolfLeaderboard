//
//  ScorecardViewController.swift
//  ScoreboardDemo
//
//  Created by Andrew Goettler on 11/15/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//  References code by Jose Martinez and Brightsec
//  https://github.com/brightec/CustomCollectionViewLayout
//

import UIKit

//private let reuseIdentifier = "Cell"

class ScorecardViewController: UICollectionViewController
{
    // TODO: Try using an ordinary prototyple collection view cell with a label instead of Jose's custom nibs
    
    @IBOutlet var scorecardCollectionView: UICollectionView!
    
    /*
    let dateCellIdentifier = "DateCellIdentifier"
    
    let contentCellIdentifier = "ContentCellIdentifier"
    */
    
    let scorecardCellIdentifier = "ScorecardCell"
    
    let globals: CurrentEventGlobalAccess = CurrentEventGlobalAccess.globalData

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        /*
        // Register cell classes
        self.collectionView!.register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: dateCellIdentifier)
        
        self.collectionView!.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
        */

        // Do any additional setup after loading the view.
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
            //labelCell.cellLabel.font = UIFont.systemFont(ofSize: 13)
            //labelCell.cellLabel.textColor = UIColor.black
            
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
                    labelCell.cellLabel.text = "Gross"
                case 5:
                    labelCell.cellLabel.text = "Net"
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
                //holeCell.cellLabel.font = UIFont.systemFont(ofSize: 13)
                //holeCell.cellLabel.textColor = UIColor.black
                holeCell.cellLabel.text = "\(globals.globalEvent.course.holes[indexPath.section - 1].number)"
                
                alternateCellColors(indexPath: indexPath, cell: holeCell)
                
                return holeCell
            }
            
            // if cell is in any other column
            else
            {
                let contentCell : ScorecardCell = collectionView .dequeueReusableCell(withReuseIdentifier: scorecardCellIdentifier, for: indexPath) as! ScorecardCell
                //contentCell.cellLabel.font = UIFont.systemFont(ofSize: 13)
                //contentCell.cellLabel.textColor = UIColor.black
                
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
                    // gross
                    // FIXME: Crashes if the scorecard does not have a score for each hole
                    contentCell.cellLabel.text = "\(globals.globalPlayer.scorecard![indexPath.section].grossScore)"
                case 5:
                    // net
                    // FIXME: Crashes if the scorecard does not have a score for each hole
                    contentCell.cellLabel.text = "\(globals.globalPlayer.scorecard![indexPath.section].netScore)"
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
}
