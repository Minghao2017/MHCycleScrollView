//
//  WSCycleScrollLayout.swift
//  Pods
//
//  Created by Xue on 16/7/26.
//
//

import UIKit

public class WSCycleScrollLayout: UICollectionViewLayout {
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    override public func prepareLayout() {
        
        guard let collectionView = collectionView else {
            return
        }
        guard cache.isEmpty else {
            return
        }
        
        for item in 0..<collectionView.numberOfItemsInSection(0) {
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            let width: CGFloat = collectionView.bounds.size.width
            let height: CGFloat = collectionView.bounds.size.height
            let y: CGFloat = 0
            let x: CGFloat = CGFloat(item) * width
            attributes.frame = CGRectMake(x, y, width, height)
            cache.append(attributes)
        }
    }
    
    override public func collectionViewContentSize() -> CGSize {
        guard let collectionView = collectionView else {
            return CGSizeZero
        }
        
        let width: CGFloat = collectionView.bounds.size.width
        let height: CGFloat = collectionView.bounds.size.height
        return CGSizeMake(width * CGFloat(collectionView.numberOfItemsInSection(0)), height)
    }
    
    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes  in cache {
            if CGRectIntersectsRect(attributes.frame, rect ) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
