//
//  ViewController.m
//  TextViewsDemo
//
//  Created by Hoang Van Trung on 7/14/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 alpha:1.0]

@interface ViewController ()
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    float viewY = 20;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_scrollView];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, viewY, SCREEN_WIDTH, 25)];
    NSString* sampleHTMLText = @"<p style=\"font-size: 18;font-family: ProximaNova-Regular;\"><a title=\"SimiCart - Mobile Shopping App builder\" href=\"http://www.simicart.com/\" target=\"_self\">SimiCart</a><span>&nbsp;is an </span><strong style=\"font-size: 18;font-family: ProximaNova-Regular;\">m-commerce solution</strong><span> for Magento merchants to create a mobile shopping app to increase customers' loyalty. Actually, besides SimiCart, there are a lot of mobile commerce solutions which can get you a shopping app and all of them have their own advantages and disadvantages.Thus, it takes more time for you to choose an appropriate one.&nbsp;</span><span>However, with SimiCart White Paper 101, you will make decision faster.&nbsp;</span><span>You can read the whole white paper for free here:</span></p>";
    NSError *error = nil;
    _label.attributedText = [[NSAttributedString alloc] initWithData:[sampleHTMLText dataUsingEncoding:NSUTF8StringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:&error];
    _label.numberOfLines = 0;
//    _label.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
    [_label sizeToFit];
    viewY += _label.frame.size.height + 5;
    [_scrollView addSubview:_label];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(5, viewY, SCREEN_WIDTH - 10, 40)];
    NSArray *fontFamilies = [UIFont familyNames];
    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
    _textField.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
    _textField.textColor = [UIColor orangeColor];
    _textField.placeholder = @"Birthday";
    _textField.textAlignment = NSTextAlignmentCenter;
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(datePickerChangeValue:) forControlEvents:UIControlEventValueChanged];
    _textField.inputView = datePicker;
    [_scrollView addSubview:_textField];
    _textField.backgroundColor = UIColorFromRGB(0xcacaca);
    viewY += _textField.frame.size.height + 5;
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, viewY, SCREEN_WIDTH, 25)];
    _textView.delegate = self;
    _textView.attributedText = [[NSAttributedString alloc] initWithData:[sampleHTMLText dataUsingEncoding:NSUTF8StringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:&error];
    [_textView sizeToFit];
    [_scrollView addSubview:_textView];
    viewY += _textView.frame.size.height;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, viewY);
}

- (void)datePickerChangeValue: (id)sender{
    UIDatePicker *pickerView = sender;
    NSDate *date = pickerView.date;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"hh:mm:ss a dd/MM/yyyy";
    NSString *dateString = [dateFormatter stringFromDate:date];
    _textField.text = dateString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
