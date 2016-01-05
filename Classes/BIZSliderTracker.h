//
//  BIZSliderTracker.h
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 5/26/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    LeftTextPosition = 1,
    RightTextPosition
} TextPositionForSliderTracker;


// * Tracker that arrows on slider's value, displays picking values
@interface BIZSliderTracker : UIView

// * Need to call then slider value changed
- (void)setDisplayedText:(NSString *)text forTextPosition:(TextPositionForSliderTracker)textPosition;
- (void)moveToPoint:(CGPoint)point;

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIColor *arrowBackgroundColor;
@end
