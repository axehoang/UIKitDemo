//
//  ViewController.h
//  CollectionViewDemo
//
//  Created by Hoang Van Trung on 7/12/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@interface ImageShowingViewController : UIViewController
@property (strong, nonatomic) NSString *imageURL;
@end
