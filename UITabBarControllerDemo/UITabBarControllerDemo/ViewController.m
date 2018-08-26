//
//  ViewController.m
//  UITabBarControllerDemo
//
//  Created by Hoang Van Trung on 7/19/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#import "TableViewController.h"
#import "ContentViewController.h"
#import "ControlsViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [self addChildViewController:tabBarController];
    [self.view addSubview:tabBarController.view];
    tabBarController.view.frame = self.view.bounds;
    CollectionViewController *collectionVC = [CollectionViewController new];
    TableViewController *tableVC = [TableViewController new];
    ContentViewController *contentVC = [ContentViewController new];
    ControlsViewController *controlsVC = [ControlsViewController new];
    [tabBarController setViewControllers:@[collectionVC, tableVC, contentVC, controlsVC] animated:YES];
    tabBarController.tabBar.backgroundColor = [UIColor orangeColor];
    tabBarController.tabBar.tintColor = [UIColor blueColor];
    CGRect frame = collectionVC.view.bounds;
    frame.size.height -= 50;
    collectionVC.view.bounds = frame;
    
//    tabBarController.tabBar.barTintColor = [UIColor redColor];
    tabBarController.tabBar.unselectedItemTintColor = [UIColor blackColor];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"item1" image:[UIImage imageNamed:@"ic_home"] tag:1];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"item2" image:[UIImage imageNamed:@"ic_home"] tag:2];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"item3" image:[UIImage imageNamed:@"ic_home"] tag:3];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"item4" image:[UIImage imageNamed:@"ic_home"] tag:4];
    collectionVC.tabBarItem = item1;
    tableVC.tabBarItem = item2;
    contentVC.tabBarItem = item3;
    controlsVC.tabBarItem = item4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
