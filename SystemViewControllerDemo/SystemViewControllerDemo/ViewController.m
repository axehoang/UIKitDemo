//
//  ViewController.m
//  SystemViewControllerDemo
//
//  Created by Hoang Van Trung on 7/18/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ViewController{
    UIImageView *imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"moon0"];
    [self.view addSubview:imageView];
    
    UIButton *editButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    editButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [editButton setImage:[UIImage imageNamed:@"ic_camera"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editImage:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview: editButton];
    
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 40, 40)];
    shareButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [shareButton setImage:[UIImage imageNamed:@"ic_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareImage:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview: shareButton];
    imageView.userInteractionEnabled = YES;
}

- (void)editImage: (id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)shareImage: (id)sender {
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[imageView.image] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
