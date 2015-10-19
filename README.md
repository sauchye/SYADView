### SYADView

### Installation

Drag SYADView  file to your project.

### Usage

##### import "SYADView.h"



``` objective-c
        _adView = [[SYADView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)
                                        imageData:_imgData
                                       scrollTime:3.0
                                    pageTintColor:[UIColor whiteColor]
                                 currentTintColor:[UIColor orangeColor]
                                    pageControlAlignment:SYPageControlAlignmentRight];

        _adView.didSelectedImageBlock = ^(NSInteger index, NSString *url){

            NSLog(@"didSelectedImage :%ld",(long)index);
        };
        [self.view addSubview:_adView];
```

### Available

iOS >= 6.0

##### Method

``` objective-c
- (instancetype)initWithFrame:(CGRect)frame
                    imageData:(NSArray *)imageData
                   scrollTime:(NSTimeInterval)scrollTime
                pageTintColor:(UIColor *)pageTintColor
             currentTintColor:(UIColor *)currentTintColor
         pageControlAlignment:(SYPageControlAlignment)pageControlAlignment;
```

### License

SYADView is under MIT License. See LICENSE file for more information.