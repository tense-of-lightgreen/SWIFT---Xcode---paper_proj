//
//  ViewController.swift
//  CollectionView
//
//  Created by cscoi007 on 2017. 2. 11..
//  Copyright © 2017년 cscoi007. All rights reserved.
//

import UIKit
class SearchSiteNCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var SiteN1: UIView!
    @IBOutlet weak var SiteN2: UIView!

    
    var selectedCell: Int = 0
    var items = [String]()
    
    let reuseIdentifier = "CollectionViewCellK" // also enter this string as the cell identifier in the storyboard
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCell = 0
        
        items = ["riss","KISS","center","digital","CSERIC","ITFIND","LG","KISTI"]
        
        self.SiteN1.alpha = 1
        self.SiteN2.alpha = 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        var imageView = cell.viewWithTag(2) as! UIImageView
        
        imageView.image = UIImage(named: items[indexPath.row])
        
        
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        if(indexPath.item == 0)
        {
            self.SiteN1.alpha = 1
            
            self.SiteN2.alpha = 0
        }
            
        else if(indexPath.item == 1)
        {
            self.SiteN1.alpha = 0
            self.SiteN2.alpha = 1
        }
    }
}
