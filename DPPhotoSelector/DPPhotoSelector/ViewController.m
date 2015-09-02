//
//  ViewController.m
//  DPPhotoSelector
//
//  Created by boombox on 15/9/2.
//  Copyright (c) 2015年 lidaipeng. All rights reserved.
//

#import "ViewController.h"
#import "DPPhotoGroupViewController.h"

@implementation ResultCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

@end

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, DPPhotoGroupViewControllerDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation ViewController{
    NSArray     *_dataSource;
}

#pragma mark - ---------------------- override
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(clickShow)];
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ---------------------- getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        layout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing      = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate        = self;
        _collectionView.dataSource      = self;
        _collectionView.pagingEnabled   = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ResultCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

#pragma mark - ---------------------- UICollectionViewDataSource/delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [ResultCollectionViewCell new];
    }
    cell.imageView.image = _dataSource[indexPath.row];
    return cell;
}

#pragma mark - ---------------------- DPPhotoGroupViewControllerDelegate
- (void)didSelectPhotos:(NSMutableArray *)photos{
    _dataSource = photos;
    [self.collectionView reloadData];
}

#pragma mark - ---------------------- action
- (void)clickShow{
    DPPhotoGroupViewController *groupVC = [DPPhotoGroupViewController new];
    groupVC.maxSelectionCount = 9;
    groupVC.delegate = self;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:groupVC] animated:YES completion:nil];
}

@end
