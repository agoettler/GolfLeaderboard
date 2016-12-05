//
//  CustomCollectionViewLayout.swift
//  CustomCollectionLayout
//
//  Created by JOSE MARTINEZ on 15/12/2014.
//  Copyright (c) 2014 brightec. All rights reserved.
//
//  Updated to Swift 3 by Andrew Goettler on 12/11/2016
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout
{

    let numberOfColumns = 5
    
    let columnHeaders: [String] = ["Hole", "Yards", "Par", "Handicap", "Score", "Col n"]
    
    var itemAttributes: [[UICollectionViewLayoutAttributes]]?
    
    var itemsSize : [CGSize]?
    
    var contentSize : CGSize!
    
    override func prepare()
    {
        if self.collectionView?.numberOfSections == 0
        {
            return
        }
        
        if (self.itemAttributes != nil && (self.itemAttributes?.count)! > 0)
        {
            for section in 0..<self.collectionView!.numberOfSections
            {
                let numberOfItems : Int = self.collectionView!.numberOfItems(inSection: section)
                
                for index in 0..<numberOfItems
                {
                    if section != 0 && index != 0
                    {
                        continue
                    }
                    
                    let attributes : UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: IndexPath(item: index, section: section))!
                    
                    if section == 0
                    {
                        var frame = attributes.frame
                        frame.origin.y = self.collectionView!.contentOffset.y
                        attributes.frame = frame
                    }
                    
                    if index == 0
                    {
                        var frame = attributes.frame
                        frame.origin.x = self.collectionView!.contentOffset.x
                        attributes.frame = frame
                    }
                }
            }
            
            return
        }
        
        if (self.itemsSize == nil || self.itemsSize?.count != numberOfColumns)
        {
            self.calculateItemsSize()
        }
        
        var column = 0
        var xOffset : CGFloat = 0
        var yOffset : CGFloat = 0
        var contentWidth : CGFloat = 0
        var contentHeight : CGFloat = 0
        
        for section in 0..<self.collectionView!.numberOfSections
        {
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []
            
            for index in 0..<numberOfColumns
            {
                let itemSize = self.itemsSize?[index]
                let indexPath = IndexPath(item: index, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: (itemSize?.width)!, height: (itemSize?.height)!).integral
                
                if section == 0 && index == 0
                {
                    attributes.zIndex = 1024;
                }
                
                else  if section == 0 || index == 0
                {
                    attributes.zIndex = 1023
                }
                
                if section == 0
                {
                    var frame = attributes.frame
                    frame.origin.y = self.collectionView!.contentOffset.y
                    attributes.frame = frame
                }
                
                if index == 0
                {
                    var frame = attributes.frame
                    frame.origin.x = self.collectionView!.contentOffset.x
                    attributes.frame = frame
                }
                
                sectionAttributes.append(attributes)
                
                xOffset += (itemSize?.width)!
                column += 1
                
                if column == numberOfColumns
                {
                    if xOffset > contentWidth
                    {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += (itemSize?.height)!
                }
            }
            
            if (self.itemAttributes == nil)
            {
                self.itemAttributes = [[UICollectionViewLayoutAttributes]]()
            }
            
            self.itemAttributes!.append(sectionAttributes)
        }
        
        if let attributes : UICollectionViewLayoutAttributes = self.itemAttributes?.last?.last
        {
            contentHeight = attributes.frame.origin.y + attributes.frame.size.height
            
            self.contentSize = CGSize(width: contentWidth, height: contentHeight)
        }
    }
    
    override var collectionViewContentSize : CGSize
    {
        return self.contentSize
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    {
        return self.itemAttributes?[indexPath.section][indexPath.row]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        var attributes = [UICollectionViewLayoutAttributes]()
        
        if let itemAttributes = self.itemAttributes
        {
            for section in itemAttributes
            {
                let filteredArray = section.filter({ (evaluatedObject) -> Bool in
                    return rect.intersects(evaluatedObject.frame)
                })
                
                attributes.append(contentsOf: filteredArray)
            }
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool
    {
        return true
    }
    
    func sizeForItemWithColumnIndex(_ columnIndex: Int) -> CGSize
    {
        let fontSize: CGFloat = 20.0
        
        let separationWidth: CGFloat = 10.0
        
        var headerWidths: [CGFloat] = []
        
        var minWidth: CGFloat = 0.0
        
        // compute width of all column headers, ignoring the last one
        for header in columnHeaders.dropLast()
        {
            let headerWidth: CGFloat = (header as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)]).width
            
            minWidth += (headerWidth + separationWidth)
            
            headerWidths.append(headerWidth)
        }
        
        // compute excess width beyond the minimum needed by the column headers, divide by number of columns
        let paddingWidth = (self.collectionView!.bounds.width - minWidth)/CGFloat(numberOfColumns)
        
        let itemWidth: CGFloat
        
        if columnIndex < headerWidths.count
        {
            itemWidth = headerWidths[columnIndex]
        }
        
        else
        {
            // sloppy - assumes the last string in the array is the default/excess column header
            itemWidth = (columnHeaders.last! as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)]).width
        }
        
        // add padding width to the column width to distribute excess space evenly across all columns
        let width : CGFloat = itemWidth + separationWidth + paddingWidth
        
        return CGSize(width: width, height: 40)
    }
    
    func calculateItemsSize()
    {
        self.itemsSize = []
        
        for index in 0..<numberOfColumns
        {
            self.itemsSize!.append(self.sizeForItemWithColumnIndex(index))
        }
    }
}
