//
//  ViewController.m
//  PageViewControllerDemo
//
//  Created by Hoang Van Trung on 7/18/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#import "ContentViewController.h"
#import "ControlsViewController.h"
#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray *pageViewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    pageViewController.delegate = self;
    pageViewController.dataSource = self;
    CollectionViewController *collectionVC = [CollectionViewController new];
    ContentViewController *contentVC = [ContentViewController new];
    ControlsViewController *controlsVC = [ControlsViewController new];
    TableViewController *tableVC = [TableViewController new];
    
    pageViewControllers = @[collectionVC,tableVC,contentVC, controlsVC];
    
    [pageViewController setViewControllers:@[collectionVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    pageViewController.view.backgroundColor = [UIColor whiteColor];
}

- (UIViewController *)viewControllerAtIndex: (NSInteger)index {
    return [pageViewControllers objectAtIndex:index];
}

- (NSInteger)indexOfViewController: (UIViewController *)viewController {
    for(UIViewController *vc in pageViewControllers) {
        if(viewController  == vc){
            return [pageViewControllers indexOfObject:viewController];
            break;
        }
    }
    return -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self indexOfViewController:viewController];
    if(index == pageViewControllers.count - 1 || index == -1) return nil;
    return [self viewControllerAtIndex:index + 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self indexOfViewController:viewController];
    if(index == 0 || index == -1) return nil;
    return [self viewControllerAtIndex:index - 1];
}

@end
