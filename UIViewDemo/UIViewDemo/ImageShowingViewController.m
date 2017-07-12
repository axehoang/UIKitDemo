//
//  ImageShowingViewController.m
//  UIViewDemo
//
//  Created by Hoang Van Trung on 7/7/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ImageShowingViewController.h"
#import "AppSampleData.h"
#import "Image.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ImageShowingViewController ()

@end

@implementation ImageShowingViewController{
    NSMutableArray* imageIndexes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    imageIndexes = [NSMutableArray new];
    NSArray<Image *> *sampleImages = [AppSampleData createSampleImages];
    UIScrollView* imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - 50)];
    imageScrollView.delegate = self;
    imageScrollView.pagingEnabled = YES;
    float scrollViewWidth = imageScrollView.bounds.size.width;
    float scrollViewHeight = imageScrollView.bounds.size.height;
    for(int i = 0; i< sampleImages.count; i++){
        UIView* imageShowingView = [[UIView alloc] initWithFrame:CGRectMake(i*scrollViewWidth, 0, scrollViewWidth, scrollViewHeight)];
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollViewWidth, scrollViewHeight - 50)];
        imageView.image = [UIImage imageNamed:[sampleImages objectAtIndex:i].image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageShowingView addSubview:imageView];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, scrollViewHeight - 50, scrollViewWidth, 50)];
        nameLabel.text = [sampleImages objectAtIndex:i].name;
        nameLabel.font = [UIFont systemFontOfSize:18];
        nameLabel.numberOfLines = 2;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [imageShowingView addSubview:nameLabel];
        [imageScrollView addSubview:imageShowingView];
    }
    [imageScrollView setContentSize:CGSizeMake(scrollViewWidth * IMAGE_QTY, scrollViewHeight)];
    [self.view addSubview:imageScrollView];
    
    UIView *imageIndexView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 25*IMAGE_QTY)/2, SCREEN_HEIGHT - 50, 25 * IMAGE_QTY, 50)];
    for(int i = 0;i<sampleImages.count;i++){
        UIImageView *indexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*25, 0, 25, 50)];
        indexImageView.contentMode = UIViewContentModeScaleAspectFit;
        if(i == _imageIndex){
            indexImageView.image = [UIImage imageNamed:@"ic_selected"];
        }else{
            indexImageView.image = [UIImage imageNamed:@"ic_unselected"];
        }
        [imageIndexes addObject:indexImageView];
        [imageIndexView addSubview:indexImageView];
    }
    [self.view addSubview:imageIndexView];
    
    [imageScrollView scrollRectToVisible:CGRectMake(scrollViewWidth*_imageIndex, 0, scrollViewWidth, scrollViewHeight) animated:NO];
    
    UIButton* closeButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 0, 40, 40)];
    [closeButton setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    [closeButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int imageIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    for (int i = 0; i < imageIndexes.count; i++) {
        UIImageView* imageView = [imageIndexes objectAtIndex:i];
        if(i == imageIndex){
            imageView.image = [UIImage imageNamed:@"ic_selected"];
        }else{
            imageView.image = [UIImage imageNamed:@"ic_unselected"];
        }
    }
}

- (void)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
