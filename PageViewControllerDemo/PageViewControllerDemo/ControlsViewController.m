//
//  ViewController.m
//  ControlsDemo
//
//  Created by Hoang Van Trung on 7/13/17.
//  Copyright © 2017 Axe. All rights reserved.
//

#import "ControlsViewController.h"
#define images @[@"moon0",@"moon1",@"moon2",@"moon3",@"moon4"]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

typedef enum : NSUInteger {
    Button,
    DatePicker,
    PageControl,
    Slider,
    Stepper,
    Switch
} Controls;

const NSUInteger numberOfImages = 5;

@interface ControlsViewController ()

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
//@property (strong, nonatomic) UIButton *previousButton, *nextButton;
@property (strong, nonatomic) UIView *buttonView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UISlider *slider;
@property (strong, nonatomic) UIStepper *stepper;
@property (strong, nonatomic) UISwitch *switcher;
@property (strong, nonatomic) UIScrollView *imageScrollView;
@end

@implementation ControlsViewController{
    NSInteger selectedImageIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UILabel appearanceWhenContainedIn:[UISegmentedControl class], nil] setNumberOfLines:0];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"UIButton",@"UIDatePicker",@"UIPageControl",@"UISlider",@"UIStepper",@"UISwitch"]];
    _segmentedControl.selectedSegmentIndex = Button;
    [_segmentedControl addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
    float viewY = 20;
    _segmentedControl.frame = CGRectMake(0, viewY, SCREEN_WIDTH, 50);
    [self.view addSubview:_segmentedControl];
    viewY += _segmentedControl.frame.size.height;
    _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, viewY, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - 100)];
    for(int i = 0; i <images.count;i++){
        NSString* imageName = [images objectAtIndex:i];
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *SCREEN_WIDTH, 0, SCREEN_WIDTH, _imageScrollView.frame.size.height)];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_imageScrollView addSubview:imageView];
    }
    selectedImageIndex = 0;
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * images.count, _imageScrollView.frame.size.height);
    _imageScrollView.delegate = self;
    [self.view addSubview:_imageScrollView];
    viewY += _imageScrollView.frame.size.height;
    
    UIView* controlView = [[UIView alloc] initWithFrame:CGRectMake(0, viewY, SCREEN_WIDTH, 100)];
    [self.view addSubview:controlView];
    //Button View
    _buttonView = [[UIView alloc] initWithFrame:controlView.bounds];
    UIButton *previousButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4 - 100, 0, 100, 100)];
    [previousButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [previousButton setImage:[UIImage imageNamed:@"ic_previous"] forState:UIControlStateNormal];
    [previousButton setTitle:@"Previous" forState:UIControlStateNormal];
    previousButton.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 50, 25);
    previousButton.titleEdgeInsets = UIEdgeInsetsMake(50, 0, 0, 0);
    previousButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [previousButton addTarget:self action:@selector(previousImage:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(3*SCREEN_WIDTH/4, 0, 100, 100)];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextButton setImage:[UIImage imageNamed:@"ic_next"] forState:UIControlStateNormal];
    nextButton.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 50, 25);
    nextButton.titleEdgeInsets = UIEdgeInsetsMake(25, -75, 5, 5);
    nextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [nextButton addTarget:self action:@selector(nextImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView addSubview:previousButton];
    [_buttonView addSubview:nextButton];
    [controlView addSubview:_buttonView];
    
    //Date Picker
    _datePicker = [[UIDatePicker alloc] initWithFrame:controlView.bounds];
    [_datePicker addTarget:self action:@selector(datePickerChangeValue:) forControlEvents:UIControlEventValueChanged];
    [controlView addSubview:_datePicker];
    
    //PageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:controlView.bounds];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    _pageControl.numberOfPages = images.count;
    _pageControl.currentPage = selectedImageIndex;
    [controlView addSubview:_pageControl];
    
    //Slider
    _slider = [[UISlider alloc] initWithFrame:controlView.bounds];
    _slider.maximumValue = 4;
    _slider.minimumValue = 0;
    _slider.value = 0;
    [_slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [controlView addSubview:_slider];
    
    //Stepper
    _stepper = [[UIStepper alloc] initWithFrame:controlView.bounds];
    _stepper.stepValue = 1;
    _stepper.maximumValue = 4;
    _stepper.minimumValue = 0;
    _stepper.value = 0;
    [_stepper addTarget:self action:@selector(stepperChangeValue:) forControlEvents:UIControlEventValueChanged];
    [controlView addSubview:_stepper];
    
    //Switch
    _switcher = [[UISwitch alloc] initWithFrame:controlView.bounds];
    [_switcher addTarget:self action:@selector(switcherChangeValue:) forControlEvents:UIControlEventValueChanged];
    [controlView addSubview:_switcher];
    
    [self showControlView:Button];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)sliderValueChange: (id)sender{
    selectedImageIndex = roundf(_slider.value);
    _slider.value = selectedImageIndex;
    [_imageScrollView scrollRectToVisible:CGRectMake(selectedImageIndex * SCREEN_WIDTH, 0, SCREEN_WIDTH, _imageScrollView.frame.size.height) animated:YES];
}

- (void)switcherChangeValue: (id)sender{
    UISwitch *switcher = (UISwitch *)sender;
    if(switcher.on)
        selectedImageIndex = rand()%2 * 2;
    else
        selectedImageIndex =  rand()% 1 + 1;
    _slider.value = selectedImageIndex;
    [_imageScrollView scrollRectToVisible:CGRectMake(selectedImageIndex * SCREEN_WIDTH, 0, SCREEN_WIDTH, _imageScrollView.frame.size.height) animated:YES];
}

- (void)stepperChangeValue: (id)sender{
    UIStepper *stepper = (UIStepper *)sender;
    selectedImageIndex = (int)stepper.value;
    _slider.value = selectedImageIndex;
    [_imageScrollView scrollRectToVisible:CGRectMake(selectedImageIndex * SCREEN_WIDTH, 0, SCREEN_WIDTH, _imageScrollView.frame.size.height) animated:YES];
}

- (void)datePickerChangeValue: (id)sender{
    selectedImageIndex = rand()%5;
    _pageControl.currentPage = selectedImageIndex;
    _slider.value = selectedImageIndex;
    [_imageScrollView scrollRectToVisible:CGRectMake(selectedImageIndex * SCREEN_WIDTH, 0, SCREEN_WIDTH, _imageScrollView.frame.size.height) animated:YES];
}

- (void)changeSegment:(id)sender{
    switch (_segmentedControl.selectedSegmentIndex) {
        case Button:
            [self showControlView:Button];
            break;
        case DatePicker:
            [self showControlView:DatePicker];
            break;
        case PageControl:
            [self showControlView:PageControl];
            break;
        case Slider:
            [self showControlView:Slider];
            break;
        case Stepper:
            [self showControlView:Stepper];
            break;
        case Switch:
            [self showControlView:Switch];
            break;
        default:
            break;
    }
}

- (void)showControlView:(Controls) control{
    _buttonView.hidden = YES;
    _datePicker.hidden = YES;
    _pageControl.hidden = YES;
    _slider.hidden = YES;
    _stepper.hidden = YES;
    _switcher.hidden = YES;
    switch (control) {
        case Button:
            _buttonView.hidden = NO;
            break;
        case DatePicker:
            _datePicker.hidden = NO;
            break;
        case PageControl:
            _pageControl.hidden = NO;
            break;
        case Slider:
            _slider.hidden = NO;
            break;
        case Stepper:
            _stepper.hidden = NO;
            break;
        case Switch:
            _switcher.hidden = NO;
            break;
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)previousImage: (id)sender{
    if(selectedImageIndex > 0){
        selectedImageIndex --;
        _slider.value = selectedImageIndex;
        [_imageScrollView scrollRectToVisible:CGRectMake(selectedImageIndex * SCREEN_WIDTH, 0, SCREEN_WIDTH, _imageScrollView.frame.size.height) animated:YES];
    }
}

- (void)nextImage: (id)sender{
    if(selectedImageIndex < images.count){
        selectedImageIndex ++;
        _slider.value = selectedImageIndex;
        [_imageScrollView scrollRectToVisible:CGRectMake(selectedImageIndex * SCREEN_WIDTH, 0, SCREEN_WIDTH, _imageScrollView.frame.size.height) animated:YES];
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    selectedImageIndex =  floor(scrollView.contentOffset.x / scrollView.bounds.size.width);
    _pageControl.currentPage = selectedImageIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
