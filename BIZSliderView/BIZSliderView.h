//
//  BIZSliderView.h
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 5/26/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BIZSliderTracker, BIZSliderView;
#import "BIZSliderTracker.h"


@protocol BIZSliderViewDelegate <NSObject>
@optional
- (void)sliderView:(BIZSliderView *)sliderView didChangeValue:(NSInteger)value;
@end


//! Class defines slider with trackerView above it for information of picked values
@interface BIZSliderView : UIView

@property (nonatomic, weak) id <BIZSliderViewDelegate> delegate;

//! Left label inside slider
@property (nonatomic, strong) UILabel *labelLeft;
//! Right label inside slider
@property (nonatomic, strong) UILabel *labelRight;

//! Sign that will be connected to values
@property (nonatomic, copy) NSString *sign;
@property (nonatomic) BOOL showRightSign;
@property (nonatomic) BOOL showLeftSign;
@property (nonatomic) BOOL showTrackerSign;

@property (nonatomic, assign) NSUInteger minValue;
@property (nonatomic, assign) NSUInteger maxValue;

//! Slider's value getter
@property (nonatomic, readonly) NSUInteger value;

//! Slider's value. Value should be between MIN and MAX
- (void)setValue:(NSUInteger)value animated:(BOOL)animated;

//! Customization of colors
- (void)setActiveColor:(UIColor *)activeColor inactiveColor:(UIColor *)inactiveColor handlerColor:(UIColor *)handlerColor borderColor:(UIColor *)borderColor;

//! Tracker of values
@property (nonatomic, strong) BIZSliderTracker *sliderTracker;

@end
