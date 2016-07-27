//
//  WSCycleScrollView.swift
//  Pods
//
//  Created by Xue on 16/7/26.
//
//

import UIKit

public class WSCycleScrollView: UICollectionView {
    
        /// 自动滚动时间间距
    public var autoScrollTimeInterval: NSTimeInterval = 3 {
        didSet {
            layout.invalidateLayout()
        }
    }
    
        /// delegate为WSCycleScrollView内部使用，外部设置无效
    override public var delegate: UICollectionViewDelegate? {
        get {
            return super.delegate
        }
        set {
            
        }
    }
    
        /// WSCycleScrollView代理对象。只传递了shouldSelectItemAtIndexPath方法
    public var cycleScrollViewDelegate: UICollectionViewDelegate?

    
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
