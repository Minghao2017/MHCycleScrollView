//
//  ViewController.swift
//  WSCycleScrollView
//
//  Created by Wilson on 07/26/2016.
//  Copyright (c) 2016 Wilson. All rights reserved.
//

import UIKit
import WSCycleScrollView

class ViewController: UIViewController {

    var cycleScrollView: WSCycleScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cycleScrollView = WSCycleScrollView()
        
        cycleScrollView.frame = CGRectMake(0, 100, view.bounds.size.width, 200)
        view.addSubview(cycleScrollView)
        cycleScrollView.backgroundColor = UIColor.lightGrayColor()
        
        let nib = UINib(nibName: "CycleScrollCollectionViewCell", bundle: nil)
        cycleScrollView.registerNib(nib, forCellWithReuseIdentifier: "CycleScrollCollectionViewCell")
        cycleScrollView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CycleScrollCollectionViewCell", forIndexPath: indexPath) as! CycleScrollCollectionViewCell
        cell.titleLbl.text = "\(indexPath.item)"
        return cell
    }
}
