//
//  ViewController.m
//  TableViewDemo
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
    UITableView *tableViewDemo;
    NSArray<Image *> *images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    images = @[[[Image alloc] initWithImageName:@"Image 0" url:@"moon0"],[[Image alloc] initWithImageName:@"Image 1" url:@"moon1"],[[Image alloc] initWithImageName:@"Image 2" url:@"moon2"], [[Image alloc] initWithImageName:@"Image 3" url:@"moon3"],[[Image alloc] initWithImageName:@"Image 4" url:@"moon0"],[[Image alloc] initWithImageName:@"Image 5" url:@"moon1"],[[Image alloc] initWithImageName:@"Image 6" url:@"moon2"], [[Image alloc] initWithImageName:@"Image 7" url:@"moon3"],[[Image alloc] initWithImageName:@"Image 8" url:@"moon0"],[[Image alloc] initWithImageName:@"Image 9" url:@"moon1"],[[Image alloc] initWithImageName:@"Image 10" url:@"moon2"], [[Image alloc] initWithImageName:@"Image 11" url:@"moon3"]];
    tableViewDemo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableViewDemo.delegate = self;
    tableViewDemo.dataSource = self;
    tableViewDemo.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    [self.view addSubview:tableViewDemo];
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 44;
        default:{
            return 150;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [NSString stringWithFormat:@"tableviewcelldemo%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        switch (indexPath.row) {
            case 0:
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.textLabel.text = @"Show All Images";
                break;
            default:{
                cell = [[TableViewCellDemo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                ((TableViewCellDemo *)cell).image = [images objectAtIndex:indexPath.row - 1];
                break;
            }
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

@implementation TableViewCellDemo{
    UIImageView *imageView;
    UILabel *label;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        float padding = 15;
        float cellWidth = self.bounds.size.width - 2*padding;
        float cellHeight = self.bounds.size.height;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, 5, 100, cellHeight - 10)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:imageView];
        label = [[UILabel alloc] initWithFrame:CGRectMake(padding + 105, 0, cellWidth - 105, cellHeight)];
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:label];
    }
    return self;
}

- (void)setImage:(Image *)image{
    imageView.image = [UIImage imageNamed:image.imageURL];
    label.text = image.imageName;
}

@end
