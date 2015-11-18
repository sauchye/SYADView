### SYADView

### Installation

Drag SYADView  file to your project.

### Usage

##### import "SYADView.h", see Example



``` objective-c
        _adView = [[SYADView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)
                                        imageData:_imgData
                             pageControlAlignment:SYPageControlAlignmentRight];

        _adView.scrollTime = 2.0;
//        _adView.currentTintColor = [UIColor redColor];
//        _adView.pageTintColor = [UIColor whiteColor];
        _adView.didSelectImageBlock = ^(NSInteger index){

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
         pageControlAlignment:(SYPageControlAlignment)pageControlAlignment;
```

### License

``SYADView `` is under MIT License. See LICENSE file for more information.