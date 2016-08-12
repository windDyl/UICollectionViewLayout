//
//  CDCollectionViewCell.m
//  UICollectViewDemo
//
//  Created by Ethank on 16/4/17.
//  Copyright © 2016年 Ldy. All rights reserved.
//

#import "CDCollectionViewCell.h"

@interface CDCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CDCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.layer.borderWidth = 3.;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 3.;
    self.imageView.layer.masksToBounds = YES;
}
-(void)setImageStr:(NSString *)imageStr {
    _imageStr = [imageStr copy];
    self.imageView.image = [UIImage imageNamed:imageStr];
}
@end
