//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by Hoang Van Trung on 7/12/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@end

@implementation ViewController{
    UICollectionView *collectionViewDemo;
    NSArray *images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    images = @[@"moon0",@"moon1",@"moon2",@"moon3",@"moon0",@"moon1",@"moon2",@"moon3",@"moon0",@"moon1",@"moon2",@"moon3"];
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 40)/3 - 0.001f, SCREEN_HEIGHT/3);
    collectionViewDemo = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    collectionViewDemo.delegate = self;
    collectionViewDemo.dataSource = self;
    [collectionViewDemo registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionviewcelldemo"];
    [self.view addSubview:collectionViewDemo];
}


#pragma mark UICollectionViewDelegate && UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionviewcelldemo" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 40)/3 - 0.001f, SCREEN_HEIGHT/3)];
    imageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    [cell.contentView addSubview:imageView];
    UILabel *imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3 - 50, (SCREEN_WIDTH - 40)/3 - 0.001f, 50)];
    imageLabel.text = [NSString stringWithFormat:@"Image %ld",(long)indexPath.row];
    imageLabel.font = [UIFont systemFontOfSize:18];
    imageLabel.textAlignment = NSTextAlignmentCenter;
    imageLabel.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5f];
    [cell.contentView addSubview:imageLabel];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
