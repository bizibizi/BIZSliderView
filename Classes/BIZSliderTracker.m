//
//  BIZSliderTracker.m
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 5/26/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "BIZSliderTracker.h"


@interface BIZSliderTracker ()
@property (nonatomic) CGRect leftTextPositionRect;
@property (nonatomic) CGRect rightTextPositionRect;
@end


@implementation BIZSliderTracker {
    CGFloat hConst; // h for self View
    CGFloat h; // h for arrow
    CGFloat w; // w for arrow
    CGFloat x; // x for arrow
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        hConst = frame.size.height;
        h = hConst * 0.45;
        w = hConst * 0.8,
        x = (frame.size.width - w) / 2;
        
        self.backgroundColor = [UIColor clearColor];
        _arrowBackgroundColor = [UIColor blackColor];
        
        // * Text can be in the front or in the back of arrow
        CGFloat inset = 8;
        self.leftTextPositionRect = CGRectMake(0,
                                               0,
                                               (frame.size.width-w)/2 - inset,
                                               frame.size.height);
        self.rightTextPositionRect = CGRectMake((frame.size.width-w)/2 + w + inset,
                                                0,
                                                (frame.size.width-w)/2 - inset,
                                                frame.size.height);
        
        self.valueLabel = [[UILabel alloc] initWithFrame:self.leftTextPositionRect];
        self.valueLabel.textAlignment = NSTextAlignmentRight;
        self.valueLabel.font = [UIFont systemFontOfSize:25];
        self.valueLabel.textColor = [UIColor blackColor];
        [self addSubview:self.valueLabel];
    }
    
    return self;
}

- (void)setDisplayedText:(NSString *)text forTextPosition:(TextPositionForSliderTracker)textPosition
{
    self.valueLabel.text = text;
    if (textPosition == RightTextPosition) {
        self.valueLabel.frame = self.rightTextPositionRect;
        self.valueLabel.textAlignment = NSTextAlignmentLeft;
    } else if (textPosition == LeftTextPosition) {
        self.valueLabel.frame = self.leftTextPositionRect;
        self.valueLabel.textAlignment = NSTextAlignmentRight;
    }
}

- (void)moveToPoint:(CGPoint)point
{
    self.center = CGPointMake(point.x, self.center.y);
}

// * Draws arrow
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // * Rect
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(x,
                                                                         hConst*0.055,
                                                                         w,
                                                                         h)];
    // *Arrow
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    [arrowPath moveToPoint:CGPointMake(CGRectGetMinX(rectPath.bounds),
                                       CGRectGetMaxY(rectPath.bounds))];
    [arrowPath addLineToPoint:CGPointMake(CGRectGetMidX(rectPath.bounds),
                                          CGRectGetMaxY(rectPath.bounds) * 1.9)];
    [arrowPath addLineToPoint:CGPointMake(CGRectGetMaxX(rectPath.bounds),
                                          CGRectGetMaxY(rectPath.bounds))];
    [arrowPath closePath];
    
    [rectPath appendPath:arrowPath];
    
    [self.arrowBackgroundColor setFill];
    [rectPath fill];
    
    // * Shadow
    self.layer.shadowPath = rectPath.CGPath;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.cornerRadius = 1;
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 1;
    self.layer.masksToBounds = NO;
}


@end
