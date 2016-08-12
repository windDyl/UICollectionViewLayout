//
//  CDStackLayout.m
//  UICollectViewDemo
//
//  Created by Ethank on 16/4/22.
//  Copyright © 2016年 Ldy. All rights reserved.
//

#import "CDStackLayout.h"

static const CGFloat CDItemW = 160;
static const CGFloat CDItemH = 280;
//static const CGFloat LineSpacing = 10;
//static const CGFloat LeftMargin = 100;
static const CGFloat StrackCount = 10;
@implementation CDStackLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat centerX = self.collectionView.frame.size.width * 0.5 - StrackCount*StrackCount/2;
    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
        UICollectionViewLayoutAttributes *atts = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        atts.center = CGPointMake(centerX + indexPath.item * StrackCount, centerY);
        atts.size = CGSizeMake(CDItemW, CDItemH);
        atts.zIndex = [self.collectionView numberOfItemsInSection:0] - indexPath.item;
    if (indexPath.item > StrackCount) {
        atts.hidden = YES;
    } else {
        atts.hidden = NO;
        atts.transform3D = CATransform3DMakeRotation(M_PI_4 / 3, 1, 1, 0);
    }
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
