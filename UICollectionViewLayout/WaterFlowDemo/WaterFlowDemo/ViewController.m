//
//  ViewController.m
//  WaterFlowDemo
//
//  Created by Ethank on 16/4/29.
//  Copyright © 2016年 Ldy. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "WFModel.h"
#import "WFCell.h"
#import "WFViewLayout.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, WFViewLayoutDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation ViewController

static NSString *const identifier = @"cell id";
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = [WFModel objectArrayWithFilename:@"1.plist"];
    [self.dataArray addObjectsFromArray:array];
    [self setupView];
}
- (void)dealloc {
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}
- (void)setupView {
    WFViewLayout *layout = [[WFViewLayout alloc] init];
    layout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"WFCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:_collectionView];
}

#pragma mark -WFViewLayoutDelegate

- (CGFloat)viewLayout:(WFViewLayout *)viewLayout heightWithWidtd:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    WFModel *model = self.dataArray[indexPath.item];
    return [model.h floatValue] / [model.w floatValue] * width;
}

#pragma mark -UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WFCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

@end
