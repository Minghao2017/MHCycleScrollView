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
    
    var colors = [
        UIColor.redColor(),
        UIColor.orangeColor(),
        UIColor.blueColor(),
        UIColor.brownColor(),
        UIColor.cyanColor()
    ]
    
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
        cycleScrollView.cycleScrollViewDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(#function,indexPath.item)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CycleScrollCollectionViewCell", forIndexPath: indexPath) as! CycleScrollCollectionViewCell
        cell.titleLbl.text = "\(indexPath.item)"
        cell.contentView.backgroundColor = colors[indexPath.item]
        return cell
    }
}
