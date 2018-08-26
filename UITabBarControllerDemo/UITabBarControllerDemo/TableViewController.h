//
//  ViewController.h
//  TableViewDemo
//
//  Created by Hoang Van Trung on 7/12/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Image.h"

@interface TableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@end

@interface TableViewCellDemo : UITableViewCell
@property (nonatomic, strong) Image *image;
@end
