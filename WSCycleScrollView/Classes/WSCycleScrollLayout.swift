//
//  WSCycleScrollLayout.swift
//  Pods
//
//  Created by Xue on 16/7/26.
//
//

import UIKit

private let DISPLAY_ITEM: Int = 1

class WSCycleScrollLayout: UICollectionViewLayout {
    
    var displayingPageIndex: Int = 0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    private var timer: NSTimer?
    
    override func prepareLayout() {
        
        guard let collectionView = collectionView else {
            return
        }
        
        if !cache.isEmpty {
            cache.removeAll()
        }
        
        let count = collectionView.numberOfItemsInSection(0)
        
        guard count > 0 else {
            return
        }
        
        let cellWidth: CGFloat = collectionView.bounds.size.width
        let cellHeight: CGFloat = collectionView.bounds.size.height
        let y: CGFloat = 0

        guard count > 2 else {
            for item in 0..<count {
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                let x: CGFloat = CGFloat(item) * cellWidth
                attributes.frame = CGRectMake(x, y, cellWidth, cellHeight)
                cache.append(attributes)
            }
            return
        }
        
        for pageIndex in 0..<count {
            
            //计算当前pageIndex对应的item
            let item: Int
            if displayingPageIndex == DISPLAY_ITEM {
                item = pageIndex
            } else if displayingPageIndex < DISPLAY_ITEM {
                item = (pageIndex + DISPLAY_ITEM - displayingPageIndex) % count
            } else {
                var temp = pageIndex - displayingPageIndex + DISPLAY_ITEM
                if temp < 0 {
                    temp += count
                }
                item = temp
            }
            
            let indexPath = NSIndexPath(forItem: pageIndex, inSection: 0)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            let x: CGFloat = CGFloat(item) * cellWidth
            attributes.frame = CGRectMake(x, y, cellWidth, cellHeight)
            cache.append(attributes)
        }
        
        collectionView.setContentOffset(CGPointMake(cellWidth, 0), animated: false)
        
        if let collectionView = collectionView as? WSCycleScrollView {
            collectionView.setDelegateInternal(self)
        }
        startTimer()
    }
    
    override func collectionViewContentSize() -> CGSize {
        guard let collectionView = collectionView else {
            return CGSizeZero
        }
        
        let width: CGFloat = collectionView.bounds.size.width
        let height: CGFloat = collectionView.bounds.size.height
        return CGSizeMake(width * CGFloat(collectionView.numberOfItemsInSection(0)), height)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes  in cache {
            if CGRectIntersectsRect(attributes.frame, rect ) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    deinit {
        stopTimer()
    }
}

extension WSCycleScrollLayout: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updatePageIndex()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        updatePageIndex()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        guard let count = collectionView?.numberOfItemsInSection(0) where count > 2 else {
            return
        }
        
        startTimer()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let collectionView = collectionView as? WSCycleScrollView {
            collectionView.cycleScrollViewDelegate?.collectionView?(collectionView, didSelectItemAtIndexPath: indexPath)
        }
    }
}

extension WSCycleScrollLayout {
    
    func updatePageIndex() {
        guard let collectionView = collectionView else {
            return
        }
        
        let offsetX = collectionView.contentOffset.x
        if offsetX == 0 {
            displayingPageIndex -= 1
            if displayingPageIndex < 0 {
                displayingPageIndex += collectionView.numberOfItemsInSection(0)
            }
            invalidateLayout()
        } else if offsetX == collectionView.bounds.size.width * 2 {
            displayingPageIndex += 1
            displayingPageIndex %= collectionView.numberOfItemsInSection(0)
            invalidateLayout()
        }
    }
    
    func startTimer() {
        if self.timer != nil {
            self.timer!.invalidate()
            self.timer = nil
        }
        
        let autoScrollTimeInterval: NSTimeInterval
        if let cv = collectionView as? WSCycleScrollView {
            autoScrollTimeInterval = cv.autoScrollTimeInterval
        } else {
            autoScrollTimeInterval = 3
        }
        
        let timer = NSTimer(timeInterval: autoScrollTimeInterval, target: self, selector: #selector(WSCycleScrollLayout.timerTriggered), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        self.timer = timer
    }
    func stopTimer() {
        if self.timer != nil {
            self.timer!.invalidate()
            self.timer = nil
        }
    }
    
    func timerTriggered() {
        guard let collectionView = collectionView else {
            return
        }
        collectionView.setContentOffset(CGPointMake(collectionView.bounds.size.width * 2, 0), animated: true)
    }

}

extension WSCycleScrollView {
    func setDelegateInternal(delegate: UICollectionViewDelegate?) {
        super.delegate = delegate
    }
}
