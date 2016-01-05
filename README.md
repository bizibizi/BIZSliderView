# BIZSliderView

*Wait for gif presentation, it's loading...*

![alt tag](https://github.com/bizibizi/BIZSliderView/blob/master/presentation.gif)


BIZSliderView is a custom slider with flexible adjusting.


# Installation

### Manually
- Copy ```Classes``` folder to your project 

### From CocoaPods:
```objective-c
pod 'BIZSliderView' 
```


# Usage

 - ```#import "BIZSliderView.h"``` 
- Create and setup ```BIZSliderView``` 
```objective-c
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

```


# Contact

Igor Bizi
- https://www.linkedin.com/in/igorbizi
- igorbizi@mail.ru


# License
 
The MIT License (MIT)

Copyright (c) 2015-present Igor Bizi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
