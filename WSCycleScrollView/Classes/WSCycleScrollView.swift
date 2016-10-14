//
//  WSCycleScrollView.swift
//  Pods
//
//  Created by Xue on 2016/10/14.
//
//

import UIKit

/// 固定部分
public class WSCycleScrollView: UIView {
    public weak var collectionView: WSCycleCollectionView!
    
    public var pageControlCurrentPageIndicatorTintColor: UIColor? {
        get {
            return pageControl?.currentPageIndicatorTintColor
        }
        set {
            pageControl?.currentPageIndicatorTintColor = newValue
        }
    }
    
    public var pageControlPageIndicatorTintColor : UIColor? {
        get {
            return pageControl?.pageIndicatorTintColor
        }
        set {
            pageControl?.pageIndicatorTintColor = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSeubViewApperance()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSeubViewApperance()
    }
    
    /// 是否显示页码显示器。默认为true,当页数大于1时显示
    public var showPageControl = true {
        didSet {
            pageControl?.hidden = !showPageControl
        }
    }
    private weak var pageControl: UIPageControl?
}

private extension WSCycleScrollView {
    func setupSeubViewApperance() {
        setupCollectionView()
        setupPageControl()
    }
    
    func setupCollectionView() {
        let collectionView = WSCycleCollectionView()
        addSubview(collectionView)
        
        pinEdgeToSuperView(collectionView, attribute: .Leading)
        pinEdgeToSuperView(collectionView, attribute: .Top)
        pinEdgeToSuperView(collectionView, attribute: .Trailing)
        pinEdgeToSuperView(collectionView, attribute: .Bottom)
        
        self.collectionView = collectionView
        
        collectionView.pagesCountChangedBlock = {
            [weak self] (count) in
            self?.pageControl?.numberOfPages = count
            if let showPageControl = self?.showPageControl {
                self?.pageControl?.hidden = !showPageControl
            }
        }
        
        collectionView.currentPageChangedBlock = {
            [weak self] (index) in
            self?.pageControl?.currentPage = index
        }
    }
    
    func setupPageControl() {
        let pageControl = UIPageControl()
        addSubview(pageControl)
        pageControl.hidden = !showPageControl
        pageControl.hidesForSinglePage = true
        self.pageControl = pageControl

        pinEdgeToSuperView(pageControl, attribute: .Trailing, const: -8)
        pinEdgeToSuperView(pageControl, attribute: .Bottom, const: 8)
    }
    
    func pinEdgeToSuperView(view: UIView, attribute: NSLayoutAttribute, const: CGFloat = 0) {
        guard let sView = view.superview else {
            return
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .Equal, toItem: sView, attribute: attribute, multiplier: 1.0, constant: const).active = true
    }
}
