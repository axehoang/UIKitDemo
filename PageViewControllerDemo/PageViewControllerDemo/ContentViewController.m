//
//  ViewController.m
//  ContentViewDemo
//
//  Created by Hoang Van Trung on 7/13/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation ContentViewController{
    float progress;
    NSArray *webViewURLs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    _progressView.progressTintColor = [UIColor blueColor];
    _progressView.trackTintColor = [UIColor grayColor];
    _progressView.center = self.view.center;
    [self.view addSubview:_progressView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated{
    progress = 0;
    [self performSelector:@selector(increaseProgress) withObject:self afterDelay:0.3f];
}

- (void)increaseProgress{
    _progressView.progress = progress += 0.1f;
    if(progress < 1){
        [self performSelector:@selector(increaseProgress) withObject:self afterDelay:0.3f];
    }else{
        [_progressView removeFromSuperview];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
        NSError *error;
        _imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://cdn.pixabay.com/photo/2017/03/23/17/02/night-2168868_1280.png"] options:NSDataReadingUncached error:&error]];
        NSLog(@"%@",error);
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
        [self.view addSubview:_imageView];
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 200)];
        _webView.delegate = self;
        [self.view addSubview:_webView];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.simicart.com/"]]];
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _activityIndicatorView.color = [UIColor orangeColor];
        _activityIndicatorView.center = self.view.center;
        [self.view addSubview:_activityIndicatorView];
        webViewURLs = @[@"https://www.simicart.com/",@"https://www.facebook.com/",@"https://www.google.com/"];
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 100, CGRectGetWidth(self.view.bounds), 100)];
        _pickerView.backgroundColor = [UIColor orangeColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self.view addSubview:_pickerView];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    switch (navigationType) {
        case UIWebViewNavigationTypeLinkClicked:
            return NO;
        default:
            return YES;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.view.userInteractionEnabled = NO;
    [_activityIndicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.view.userInteractionEnabled = YES;
    [_activityIndicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UIPickerViewDataSorce && UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString* webViewURL = [webViewURLs objectAtIndex:row];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webViewURL]]];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return webViewURLs.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [webViewURLs objectAtIndex:row];
}

@end
