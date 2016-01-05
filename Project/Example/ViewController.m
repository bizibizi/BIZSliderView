//
//  ViewController.m
//  Example
//
//  Created by IgorBizi@mail.ru on 12/18/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "ViewController.h"
#import "BIZSliderView.h"


@interface ViewController () <BIZSliderViewDelegate>
@end


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // * Create
    BIZSliderView *sliderView = [[BIZSliderView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.025, 100, self.view.bounds.size.width * 0.95, 60)];
    sliderView.delegate = self;
    [sliderView setActiveColor:[UIColor greenColor] inactiveColor:[UIColor whiteColor] handlerColor:[UIColor greenColor] borderColor:[UIColor lightGrayColor]];
    sliderView.minValue = 1;
    sliderView.maxValue = 1000;
    NSUInteger current = 300;
    [sliderView setValue:current animated:NO];
    sliderView.sign = @"ft";
    sliderView.sliderTracker.arrowBackgroundColor = [UIColor redColor];
    [self.view addSubview:sliderView];
}


#pragma mark - BIZSliderViewDelegate


- (void)sliderView:(BIZSliderView *)sliderView didChangeValue:(NSInteger)value
{
    NSLog(@"%ld", (long)value);
}


@end
