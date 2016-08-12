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
#import "CDStackLayout.h"
#import "CDCircleLayout.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)NSMutableArray *imageS;
@property (nonatomic, strong)UICollectionView *collectionV;
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
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT - 100) collectionViewLayout:[[CDCircleLayout alloc] init]];
    [_collectionV setBackgroundColor:[UIColor lightGrayColor]];
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    _collectionV.showsHorizontalScrollIndicator = NO;
    [_collectionV registerNib:[UINib nibWithNibName:@"CDCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:_collectionV];
    
}


#pragma mark - Private

- (void)switchLayout {
    if ([self.collectionV.collectionViewLayout isKindOfClass:[CDCircleLayout class]]) {
        [self.collectionV setCollectionViewLayout:[[CDLineLayout alloc] init] animated:YES];
    } else {
        [self.collectionV setCollectionViewLayout:[[CDCircleLayout alloc] init] animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageS.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.imageStr = self.imageS[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.collectionV.collectionViewLayout isKindOfClass:[CDLineLayout class]]) {
        NSLog(@"selected %ld", (long)indexPath.item);
    } else {
        [self switchLayout];
    }
}

#pragma mark - 系统方法

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self switchLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
