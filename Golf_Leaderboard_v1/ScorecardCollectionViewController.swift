//
//  ScorecardCollectionViewController.swift
//  Golf_Leaderboard_v1
//
//  Created by Andrew Goettler on 11/8/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class ScorecardCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{

    @IBOutlet weak var scorecardCollectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        <#code#>
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) 
     {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
