//
//  WSCycleCollectionView.swift
//  Pods
//
//  Created by Xue on 16/7/26.
//
//

import UIKit

@objc public protocol WSCycleCollectionViewDelegate: UICollectionViewDelegate {
    optional func cycleCollectionView(view: WSCycleCollectionView, didMoveToPage index: Int)
    optional func cycleCollectionView(view: WSCycleCollectionView, numberOfPages pages: Int)
}

/// 滚动部分
public class WSCycleCollectionView: UICollectionView {
    
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
    public var cycleScrollViewDelegate: WSCycleCollectionViewDelegate?

    var pagesCountChangedBlock: (Int -> Void)?
    var currentPageChangedBlock: (Int -> Void)?
    
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
    
    public override func reloadData() {
        super.reloadData()
        
        var totalPages = dataSource?.collectionView(self, numberOfItemsInSection: 0)
        totalPages = totalPages ?? 0
        cycleScrollViewDelegate?.cycleCollectionView?(self, numberOfPages: totalPages!)
        pagesCountChangedBlock?(totalPages!)
    }
}

private extension WSCycleCollectionView {
    func setupCollectionView() {
        pagingEnabled = true
        showsHorizontalScrollIndicator = false
        bounces = false
    }
}