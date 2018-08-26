//
//  ViewController.m
//  WebViewDemo
//
//  Created by Hoang Van Trung on 7/18/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController{
    UIWebView *webView;
    UITableView *tableView;
    float webViewHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    webViewHeight = 100;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"webviewdemocell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"webviewdemocell"];
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, webViewHeight)];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.simicart.com/"]]];
        webView.delegate = self;
        webView.scrollView.scrollEnabled = NO;
        [cell addSubview:webView];
    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return webViewHeight;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    webViewHeight = [result floatValue];
    CGRect frame = webView.frame;
    frame.size.height = webViewHeight;
    webView.frame = frame;
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
