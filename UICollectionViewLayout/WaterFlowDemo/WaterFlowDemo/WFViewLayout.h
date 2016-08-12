//
//  WFViewLayout.h
//  WaterFlowDemo
//
//  Created by Ethank on 16/4/29.
//  Copyright © 2016年 Ldy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WFViewLayout;
@protocol WFViewLayoutDelegate <NSObject>

- (CGFloat)viewLayout:(WFViewLayout *)viewLayout heightWithWidtd:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface WFViewLayout : UICollectionViewLayout
/**
 *  缩进
 */
@property (nonatomic, assign)UIEdgeInsets inset;
/**
 *  列数
 */
@property (nonatomic, assign)int columnCount;
/**
 *  行间距
 */
@property (nonatomic, assign)CGFloat rowMargin;
/**
 *  列间距
 */
@property (nonatomic, assign)CGFloat columnMargin;

@property (nonatomic, assign)id <WFViewLayoutDelegate> delegate;
@end
