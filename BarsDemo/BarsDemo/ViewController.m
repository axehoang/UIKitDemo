//
//  ViewController.m
//  BarsDemo
//
//  Created by Hoang Van Trung on 7/15/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController{
    NSArray *sampleDatas;
    NSMutableArray *results;
    UISearchBar *searchBar;
    UITableView *searchTableView;
    UILabel *noResultsLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    sampleDatas = @[@"simicart",@"google",@"facebook",@"android",@"ios",@"magento"];
    results = [NSMutableArray new];
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 40)];
    [self.view addSubview:searchBar];
    searchBar.barTintColor = [UIColor orangeColor];
    searchBar.tintColor = [UIColor blackColor];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    UIToolbar *searchToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    searchToolbar.items = @[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSearching:)],[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneSearching:)]];
    searchBar.inputAccessoryView = searchToolbar;
    
    searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 60)];
    searchTableView.delegate = self;
    searchTableView.dataSource = self;
    searchTableView.tableFooterView = [UIView new];
    [self.view addSubview:searchTableView];
    
    noResultsLabel = [[UILabel alloc] initWithFrame:searchTableView.frame];
    noResultsLabel.text = @"No results found";
    noResultsLabel.textAlignment = NSTextAlignmentCenter;
    noResultsLabel.numberOfLines = 0;
    [self.view addSubview:noResultsLabel];
    noResultsLabel.hidden = YES;
    
}

- (void)cancelSearching: (id)sender {
    noResultsLabel.hidden = NO;
    searchTableView.hidden = YES;
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    [results removeAllObjects];
    [searchTableView reloadData];
}

- (void)doneSearching: (id)sender {
    NSString *searchKey = [searchBar.text lowercaseString];
    [results removeAllObjects];
    for(NSString *sampleData in sampleDatas){
        if([searchKey isEqualToString:sampleData]) {
            [results addObject:sampleData];
        }
    }
    noResultsLabel.hidden = YES;
    searchTableView.hidden = YES;
    if(results.count > 0){
        searchTableView.hidden = NO;
        [searchTableView reloadData];
    }else{
        noResultsLabel.hidden = NO;
    }
    [searchBar resignFirstResponder];
}
//UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self cancelSearching:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self doneSearching:nil];
}

//UITableViewDelegate & UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"barsdemotableviewcell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"barsdemotableviewcell"];
    }
    cell.textLabel.text = [results objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return results.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
