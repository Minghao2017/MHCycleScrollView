//
//  WSCycleScrollView.swift
//  Pods
//
//  Created by Xue on 16/7/26.
//
//

import UIKit

public class WSCycleScrollView: UICollectionView {
    
    var autoScrollTimeInterval: NSTimeInterval = 3
    
    private var layout: WSCycleScrollLayout
    
    public init() {
        layout = WSCycleScrollLayout()
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        
        setupCollectionView()

    }
    
    required public init?(coder aDecoder: NSCoder) {
        layout = WSCycleScrollLayout()
        
        super.init(coder: aDecoder)
        
        collectionViewLayout = layout
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        pagingEnabled = true
        showsHorizontalScrollIndicator = false
        bounces = false
    }
}

