//
//  ViewController.swift
//  WSCycleScrollView
//
//  Created by Wilson on 07/26/2016.
//  Copyright (c) 2016 Wilson. All rights reserved.
//

import UIKit
import WSCycleScrollView
import SDWebImage

class ViewController: UIViewController {

    var cycleScrollView: WSCycleScrollView!
    
    var colors = [
        UIColor.redColor(),
        UIColor.orangeColor(),
        UIColor.blueColor(),
        UIColor.brownColor(),
        UIColor.cyanColor(),
        UIColor.redColor(),
        UIColor.orangeColor(),
        UIColor.blueColor(),
        UIColor.brownColor(),
        UIColor.cyanColor()
    ]
    
    var imageURLStrings = [
        "http://192.168.0.23:9095/2/20160507/p3erx0f1egsiyfsm_640_340.jpg",
        "http://192.168.0.23:9095/2/20160507/ijpiwbqvigyrbymx_750_350.jpg",
        "http://192.168.0.23:9095/2/20160507/p3erx0f1egsiyfsm_640_340.jpg",
        "http://192.168.0.23:9095/2/20160507/p3erx0f1egsiyfsm_640_340.jpg",
        "http://192.168.0.23:9095/2/20160507/p3erx0f1egsiyfsm_640_340.jpg",
        "http://192.168.0.23:9095/2/20160507/ijpiwbqvigyrbymx_750_350.jpg",
        "http://192.168.0.23:9095/2/20160507/ijpiwbqvigyrbymx_750_350.jpg",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cycleScrollView = WSCycleScrollView()
        cycleScrollView.frame = CGRectMake(0, 100, view.bounds.size.width, 200)
        view.addSubview(cycleScrollView)
        cycleScrollView.backgroundColor = UIColor.lightGrayColor()
        
        cycleScrollView.pageControlPageIndicatorTintColor = UIColor.redColor()
        cycleScrollView.pageControlCurrentPageIndicatorTintColor = UIColor.orangeColor()
        
        let nib = UINib(nibName: "CycleScrollCollectionViewCell", bundle: nil)
        cycleScrollView.collectionView.registerNib(nib, forCellWithReuseIdentifier: "CycleScrollCollectionViewCell")
        cycleScrollView.collectionView.dataSource = self
        cycleScrollView.collectionView.cycleScrollViewDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: WSCycleCollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(#function,indexPath.item)
    }
    
    func cycleCollectionView(view: WSCycleCollectionView, didMoveToPage index: Int) {
        print(#function, index)
    }
    
    func cycleCollectionView(view: WSCycleCollectionView, numberOfPages pages: Int) {
        print(#function, pages)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CycleScrollCollectionViewCell", forIndexPath: indexPath) as! CycleScrollCollectionViewCell
        cell.titleLbl.text = "\(indexPath.item)"
        cell.contentView.backgroundColor = colors[indexPath.item]
        cell.imageView.sd_setImageWithURL(NSURL(string: imageURLStrings[indexPath.item]))
        return cell
    }
}
