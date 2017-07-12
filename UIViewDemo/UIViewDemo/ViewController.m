//
//  ViewController.m
//  UIViewDemo
//
//  Created by Hoang Van Trung on 7/7/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ViewController.h"
#import "AppSampleData.h"
#import "Image.h"
#import "ImageShowingViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController{
    UILabel* imageNameLabel;
    UIImageView* imageView;
    NSArray<Image *> *sampleImages;
    int imageIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect bounds = [UIScreen mainScreen].bounds;
    sampleImages = [AppSampleData createSampleImages];
    NSLog(@"%f,%f,%f,%f",bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    float viewY = 0;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/4, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageIndex = 0;
    imageView.image = [UIImage imageNamed:[sampleImages objectAtIndex:imageIndex].image];
    [self.view addSubview:imageView];
    viewY += imageView.frame.origin.y + imageView.frame.size.height + 10;
    imageNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, viewY, SCREEN_WIDTH/2, 30)];
    imageNameLabel.numberOfLines = 2;
    imageNameLabel.font = [UIFont systemFontOfSize:18];
    imageNameLabel.text = [sampleImages objectAtIndex:imageIndex].name;
    imageNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:imageNameLabel];
    
    UIButton* nextButton = [[UIButton alloc] initWithFrame:CGRectMake(imageNameLabel.frame.origin.x + imageNameLabel.frame.size.width, viewY, 30, 30)];
    [nextButton setImage:[UIImage imageNamed:@"ic_next"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    UIButton* previousButton = [[UIButton alloc] initWithFrame:CGRectMake(imageNameLabel.frame.origin.x - 30, viewY, 30, 30)];
    [previousButton setImage:[UIImage imageNamed:@"ic_previous"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    
    UITapGestureRecognizer *imageTapping = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapping:)];
    imageTapping.numberOfTapsRequired = 2;
    [imageView addGestureRecognizer:imageTapping];
    imageView.userInteractionEnabled = YES;
}

- (void)imageTapping:(id)sender{
    ImageShowingViewController* imageShowingVC = [ImageShowingViewController new];
    imageShowingVC.imageIndex = imageIndex;
    [self presentViewController:imageShowingVC animated:YES completion:nil];
}

- (void)nextImage:(id)sender{
    if(imageIndex == IMAGE_QTY - 1){
        return;
    }
    imageIndex++;
    imageView.image = [UIImage imageNamed:[sampleImages objectAtIndex:imageIndex].image];
    imageNameLabel.text = [sampleImages objectAtIndex:imageIndex].name;
}

- (void)previousImage:(id)sender{
    if(imageIndex == 0){
        return;
    }
    imageIndex--;
    imageView.image = [UIImage imageNamed:[sampleImages objectAtIndex:imageIndex].image];
    imageNameLabel.text = [sampleImages objectAtIndex:imageIndex].name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
