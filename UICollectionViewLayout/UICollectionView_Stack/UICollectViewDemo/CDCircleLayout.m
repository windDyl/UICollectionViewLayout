//
//  CDCircleLayout.m
//  UICollectViewDemo
//
//  Created by Ethank on 16/4/25.
//  Copyright © 2016年 Ldy. All rights reserved.
//

#import "CDCircleLayout.h"
static const CGFloat CDItemW = 100;
static const CGFloat CDItemH = 100;
static const CGFloat CircleRadius = 100;
@implementation CDCircleLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *atts = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    atts.size = CGSizeMake(CDItemW, CDItemH);
    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
    CGPoint circleCenter = CGPointMake(centerX, centerY);
    //没个item的夹角
    CGFloat angleDelta = M_PI * 2 / [self.collectionView numberOfItemsInSection:0];
    //计算当前item的角度
    CGFloat angle = indexPath.item * angleDelta;
    //计算item的center
    atts.center = CGPointMake(circleCenter.x + CircleRadius * cosf(angle), circleCenter.y - CircleRadius * sinf(angle));
    atts.zIndex = indexPath.item;
    return atts;
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *atts = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:atts];
    }
    return array;
}
@end
