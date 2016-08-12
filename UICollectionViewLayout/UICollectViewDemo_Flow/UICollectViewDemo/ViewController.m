//
//  ViewController.m
//  UICollectViewDemo
//
//  Created by Ethank on 16/4/17.
//  Copyright © 2016年 Ldy. All rights reserved.
//

#import "ViewController.h"
#import "CDCollectionViewCell.h"
#import "CDLineLayout.h"


#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)NSMutableArray *imageS;
@end

@implementation ViewController
static NSString *const identifier = @"CDCell";

- (NSMutableArray *)imageS {
    if (!_imageS) {
        self.imageS = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            [self.imageS addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _imageS;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT - 100) collectionViewLayout:[[CDLineLayout alloc] init]];
    [collectionV setBackgroundColor:[UIColor lightGrayColor]];
    collectionV.delegate = self;
    collectionV.dataSource = self;
    collectionV.showsHorizontalScrollIndicator = NO;
    [collectionV registerNib:[UINib nibWithNibName:@"CDCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:collectionV];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageS.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.imageStr = self.imageS[indexPath.item];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
