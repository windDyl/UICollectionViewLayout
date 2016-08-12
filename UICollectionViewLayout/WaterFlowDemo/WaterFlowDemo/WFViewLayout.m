//
//  WFViewLayout.m
//  WaterFlowDemo
//
//  Created by Ethank on 16/4/29.
//  Copyright © 2016年 Ldy. All rights reserved.
//

#import "WFViewLayout.h"

@interface WFViewLayout ()
@property (nonatomic, strong)NSMutableDictionary *dict;//所有列的最大y值
@property (nonatomic, strong)NSMutableArray *attrsArray;//布局属性
@end

@implementation WFViewLayout
- (NSMutableDictionary *)dict {
    if (!_dict) {
        self.dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}
- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        self.attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.columnCount = 3;
    }
    return self;
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
- (void)prepareLayout {
    for (int i = 0; i < self.columnCount; i++) {
        NSString *key = [NSString stringWithFormat:@"%d", i];
        [self.dict setObject:@(self.inset.top) forKey:key];
    }
    
    //先清空布局属性，再重新加载
    [self.attrsArray removeAllObjects];
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        UICollectionViewLayoutAttributes *atts = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:atts];
    }
}
- (CGSize)collectionViewContentSize {
    __block NSString *maxColumnKey = @"0";
    [self.dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *maxY, BOOL * _Nonnull stop) {
        if ([self.dict[maxColumnKey] floatValue] < [maxY floatValue]) {
            maxColumnKey = key;
        }
    }];
    CGFloat y = self.inset.top + self.inset.bottom + [self.dict[maxColumnKey] floatValue];
    return CGSizeMake(0, y);
}
//单个cell的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    __block NSString *minColumnKey = @"0";
    [self.dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *maxY, BOOL * _Nonnull stop) {
        if ([self.dict[minColumnKey] floatValue] > [maxY floatValue]) {
            minColumnKey = key;
        }
    }];
    
    CGFloat width = (self.collectionView.frame.size.width - self.inset.left - self.inset.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat height = [self.delegate viewLayout:self heightWithWidtd:width atIndexPath:indexPath];
    CGFloat y = self.inset.top + [self.dict[minColumnKey] floatValue];
    CGFloat x = self.inset.left + (width + self.columnMargin) * [minColumnKey intValue];
    self.dict[minColumnKey] = @(y + height);
    UICollectionViewLayoutAttributes *atts = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    atts.frame = CGRectMake(x, y, width, height);
    return atts;
}
//返回所有cell的布局属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

@end
