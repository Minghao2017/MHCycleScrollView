//
//  WSCycleScrollView.swift
//  Pods
//
//  Created by Xue on 16/7/26.
//
//

import UIKit

public class WSCycleScrollView: UICollectionView {
    
    private var layout: WSCycleScrollLayout
    
    
    public init() {
        layout = WSCycleScrollLayout()
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        
        pagingEnabled = true

    }
    
    required public init?(coder aDecoder: NSCoder) {
        layout = WSCycleScrollLayout()
        
        super.init(coder: aDecoder)
        
        collectionViewLayout = layout
        pagingEnabled = true
    }
    
    
}

extension WSCycleScrollView: UIScrollViewDelegate {
    public func scrollViewDidScroll(scrollView: UIScrollView) {
    }
}
