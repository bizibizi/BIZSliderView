//
//  BIZSliderView.m
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 5/26/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "BIZSliderView.h"
#import <QuartzCore/QuartzCore.h>
#import "BIZSliderTracker.h"


#define SliderView_handleWidth 6.0 // width for handleView
#define SliderView_borderWidth 1.0 // size of border with the slider
#define SliderView_handleCornerRadius 6.0 // view corners radius for slider
#define SliderView_animationSpeed 0.1 // speed when slider change position on tap


@interface BIZSliderView ()
//! Background of slider scale for active area
@property (nonatomic, strong) UIView *foregroundView;
//! Area between active and not active area, will be rounded
@property (nonatomic, strong) UIView *handleView;
//! Background of slider scale for not active area. In that area placed slider with scale, other view area are clear
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, readwrite) NSUInteger value;
@end


@implementation BIZSliderView


#pragma mark - LiceCycle


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    // * Height shared between slider scale and value tracker
    // * As 4/6
    [self initSlider];
    
    self.backgroundColor = [UIColor clearColor];
    _showLeftSign = YES;
    _showRightSign = YES;
    _showTrackerSign = YES;
    self.value = 0.0;
    
    self.sliderTracker = [[BIZSliderTracker alloc] initWithFrame:
                          CGRectMake(self.backgroundView.frame.origin.x,
                                     0,
                                     self.backgroundView.bounds.size.width,
                                     self.bounds.size.height * 0.4)];
    [self addSubview:self.sliderTracker];
}

- (void)initSlider
{
    // * Need to access touches on SliderTracker in the begining and in the end of BackgroundView
    CGFloat insetForBackgroundView = self.bounds.size.width * 0.025;
    self.backgroundView = [[UIView alloc] initWithFrame:
                           CGRectMake(insetForBackgroundView,
                                      self.bounds.size.height * 0.4,
                                      self.bounds.size.width - insetForBackgroundView*2,
                                      self.bounds.size.height * 0.6)];
    [self addSubview:self.backgroundView];
    self.backgroundView.layer.cornerRadius = SliderView_handleCornerRadius;
    self.backgroundView.clipsToBounds = YES;
    self.backgroundView.layer.borderWidth = SliderView_borderWidth;
    
    self.foregroundView = [[UIView alloc] init];
    [self.backgroundView addSubview:self.foregroundView];
    
    self.handleView = [[UIView alloc] init];
    self.handleView.layer.cornerRadius = SliderView_handleCornerRadius;
    self.handleView.layer.masksToBounds = YES;
    [self.backgroundView addSubview:self.handleView];
    
    // * labels
    CGFloat insetForLabels = 8;
    self.labelLeft = [[UILabel alloc] initWithFrame:
                      CGRectMake(insetForLabels,
                                 0,
                                 self.backgroundView.bounds.size.width/2 - insetForLabels,
                                 self.backgroundView.bounds.size.height)];
    self.labelRight = [[UILabel alloc] initWithFrame:
                       CGRectMake(self.backgroundView.bounds.size.width/2,
                                  0,
                                  self.backgroundView.bounds.size.width/2 - insetForLabels,
                                  self.backgroundView.bounds.size.height)];
    self.labelLeft.textAlignment = NSTextAlignmentLeft;
    self.labelLeft.font = [UIFont boldSystemFontOfSize:17];
    self.labelRight.textAlignment = NSTextAlignmentRight;
    self.labelRight.font = [UIFont boldSystemFontOfSize:17];
    self.labelRight.textColor = [UIColor blackColor];
    self.labelLeft.textColor = [UIColor blackColor];
    [self.backgroundView addSubview:self.labelRight];
    [self.backgroundView addSubview:self.labelLeft];
}

- (void)setMinValue:(NSUInteger)minValue
{
    _minValue = minValue;
    
    self.labelLeft.text = [NSString stringWithFormat:@"%lu%@", (unsigned long)self.minValue, self.showLeftSign ? self.sign : @""];
}

- (void)setMaxValue:(NSUInteger)maxValue
{
    _maxValue = maxValue;
    self.labelRight.text = [NSString stringWithFormat:@"%lu%@", (unsigned long)self.maxValue, self.showRightSign ? self.sign : @""];
}

- (void)setSign:(NSString *)sign
{
    _sign = sign;
    [self reloadSigns];
}

- (void)reloadSigns
{
    self.minValue = self.minValue;
    self.maxValue = self.maxValue;
    [self setValue:self.value animated:NO];
}

- (void)setShowLeftSign:(BOOL)showLeftSign
{
    _showLeftSign = showLeftSign;
    [self reloadSigns];
}

- (void)setShowRightSign:(BOOL)showRightSign
{
    _showRightSign = showRightSign;
    [self reloadSigns];
}

- (void)setShowTrackerSign:(BOOL)showTrackerSign
{
    _showTrackerSign = showTrackerSign;
    [self reloadSigns];
}


#pragma mark - Touches


// * Detect touches on whole view and move slider in real time
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // * Get touch and translate it's coordinates to View
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self changeForegroundViewWithPoint:point];
}

// * In the end of touch make it with animation
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [UIView animateWithDuration:SliderView_animationSpeed
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         [self changeForegroundViewWithPoint:point];
                         
                     } completion:nil];
}


#pragma mark - Events


- (void)setActiveColor:(UIColor *)activeColor inactiveColor:(UIColor *)inactiveColor handlerColor:(UIColor *)handlerColor borderColor:(UIColor *)borderColor
{
    self.backgroundView.backgroundColor = inactiveColor;
    self.foregroundView.backgroundColor = activeColor;
    self.handleView.backgroundColor = handlerColor;
    [self.backgroundView.layer setBorderColor:borderColor.CGColor];
}

- (void)setValue:(NSUInteger)value animated:(BOOL)animated
{
    // * Range of values
    if (value <= self.minValue)
    {
        self.value = self.minValue;
    } else
        if (value >= self.maxValue && self.maxValue)
        {
            self.value = self.maxValue;
        } else
            if (value > self.minValue && value < self.maxValue)
            {
                self.value = value;
            }
    
    [self changeForegroundViewWithPoint:CGPointMake([self locationFromValue:self.value], 0)];
}

// * Takes coordinate of X from location of touch and moves foregroundView, handleView as scale
// * Translates values of touches into scale of foregroundView, handleView
- (void)changeForegroundViewWithPoint:(CGPoint)point
{
    // * Check out of bounds values
    if (point.x < 0 || point.x > CGRectGetMaxX(self.frame)) {
        return;
    }
    
    self.value = [self valueFromLocation:point.x];

    // * Range of values
    if (self.value <= self.minValue) {
        
        self.value = self.minValue;
        point.x = [self locationFromValue:self.value];
    } else
        
        if (self.value >= self.maxValue) {
            
            self.value = self.maxValue;
            point.x = [self locationFromValue:self.value];
        }
    
    // * ForegroundView
    self.foregroundView.frame = CGRectMake(SliderView_borderWidth,
                                           SliderView_borderWidth,
                                           point.x,
                                           self.backgroundView.frame.size.height - SliderView_borderWidth * 2);
    
    // * HandleView
    if (self.foregroundView.frame.size.width <= 0) {
        self.handleView.frame = CGRectMake(self.foregroundView.frame.origin.x,
                                           0,
                                           SliderView_handleWidth,
                                           self.foregroundView.frame.size.height);
    } else
        if (self.foregroundView.frame.size.width >= self.backgroundView.frame.size.width) {
            self.handleView.frame = CGRectMake(self.foregroundView.frame.size.width - SliderView_handleWidth/2,
                                               0,
                                               SliderView_handleWidth,
                                               self.foregroundView.frame.size.height);
        } else {
            self.handleView.frame = CGRectMake(self.foregroundView.frame.size.width - SliderView_handleWidth/2,
                                               0,
                                               SliderView_handleWidth,
                                               self.foregroundView.frame.size.height + SliderView_borderWidth * 2);
        }
    
    
    // * SliderTracker
    CGPoint xCenter = CGPointMake(point.x + SliderView_handleWidth/2 + self.backgroundView.frame.origin.x, 0);
    [self.sliderTracker moveToPoint:xCenter];
    [self.sliderTracker setDisplayedText:[NSString stringWithFormat:@"%lu%@", (unsigned long)self.value, self.showTrackerSign ? self.sign : @""] forTextPosition:[self textPositionForSliderTracker]];
    
    // * Delegate
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(sliderView:didChangeValue:)]) {
        [self.delegate sliderView:self didChangeValue:self.value];
    }
}

// * Label Position at SliderTracker
// * It can be in the front or in the back of sliderTracker
- (TextPositionForSliderTracker)textPositionForSliderTracker
{
    return (self.sliderTracker.center.x < self.backgroundView.bounds.size.width / 2)? RightTextPosition : LeftTextPosition;
}

// * Return value of slider from X coordinate
- (CGFloat)valueFromLocation:(CGFloat)location
{
    // * Disable negative values in numerator
    if (location <= 0) {
        return 0;
    }
    
    return (self.maxValue - self.minValue) * location /
    (self.backgroundView.frame.size.width - SliderView_borderWidth - SliderView_handleWidth/2);
}

// * Return X coordinate from value of slider
- (CGFloat)locationFromValue:(CGFloat)value
{
    // * Disable negative values in numerator
    if (value <= 0) {
        return 0;
    }
    
    return (value * (self.backgroundView.frame.size.width - SliderView_borderWidth - SliderView_handleWidth/2)) /
    (self.maxValue - self.minValue);
}



@end
