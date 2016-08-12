//
//  WFCell.m
//  WaterFlowDemo
//
//  Created by Ethank on 16/4/29.
//  Copyright © 2016年 Ldy. All rights reserved.
//

#import "WFCell.h"
#import "WFModel.h"
#import "UIImageView+WebCache.h"

@interface WFCell()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WFCell

-(void)setModel:(WFModel *)model {
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"loading"]];
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.img]];
//    self.imageView.image = [UIImage imageWithData:data];
    self.priceLabel.text = model.price;
}
@end
