//
//  CDLineLayout.m
//  UICollectViewDemo
//
//  Created by Ethank on 16/4/18.
//  Copyright © 2016年 Ldy. All rights reserved.
//

#import "CDLineLayout.h"

static const CGFloat CDItemW = 160;
static const CGFloat CDItemH = 280;
static const CGFloat LineSpacing = 80;
@implementation CDLineLayout
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

/**
 *  准备加载
 */
-(void)prepareLayout {
    self.itemSize = CGSizeMake(CDItemW, CDItemH);
    CGFloat inset = (self.collectionView.frame.size.width - CDItemW)*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = LineSpacing;
}
/**
 *  只要显示的边界发生改变就重新布局：内部会重新调用layoutAttributesForElementsInRect方法
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    //停止滚动时的rect
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    //此时lastRect上的item的UICollectionViewLayoutAttributes
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    //屏幕中点x的值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat margin = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *atts in array) {
        if (ABS(atts.center.x - centerX) < ABS(margin)) {
            margin = atts.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + margin, proposedContentOffset.y);
}

/** 有效距离:当item的中间x距离屏幕的中间x在CDActiveDistance以内,才会开始放大, 其它情况都是缩小 */
static CGFloat const CDActiveDistance = 160;
/** 缩放因素: 值越大, item就会越大 */
static CGFloat const CDScaleFactor = 0.6;
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //计算可见矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
    //获取默认的cell的UICollectionViewLayoutAttributes
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //计算屏幕中间的x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    //遍历布局属性
    for (UICollectionViewLayoutAttributes *attribute in array) {
        // 如果不在屏幕上,直接跳过
        if (!CGRectIntersectsRect(visiableRect, attribute.frame)) {
            continue;
        }
        //每个item的中点
        CGFloat itemCenterX  = attribute.center.x;
        //差距越小，缩放比例越大
        //根据和屏幕中心x的差距计算缩放比例
        CGFloat scale = 1 + CDScaleFactor*(1 - ABS(itemCenterX - centerX) / CDActiveDistance);
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}
@end
