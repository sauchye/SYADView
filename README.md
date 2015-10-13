### SYADDemo

### Installation

Drag SYADView  file to your project.

### Usage

  # import "SYADView.h"

## Usage



``` objective-c
        _adView = [[SYADView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)
                                        imageData:_imgData
                                    pageTintColor:[UIColor grayColor]
                                 currentTintColor:[UIColor orangeColor]
                                    pageAlignment:SYPageControllAlignmentRight];

        _adView.didSelectedImageBlock = ^(NSInteger index, NSString *url){
        
            NSLog(@"didSelectedImage :%ld",(long)index);
        };
        [self.view addSubview:_adView];
```



### Dissmiss ADView

``` objective-c
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [_adView freeTimer];
}
```



###  Available

iOS >= 6.0

##### Method

``` objective-c
- (instancetype)initWithFrame:(CGRect)frame
            imageData:(NSArray *)imageData
        pageTintColor:(UIColor *)pageTintColor
     currentTintColor:(UIColor *)currentTintColor
        pageAlignment:(SYPageControlAlignment)pageAlignment;
```



##### You Can Define

- PageControll Alignment

``` objective-c
typedef NS_ENUM(NSInteger, SYPageControlAlignment) {
    
    SYPageControlAlignmentLeft = 0,
    SYPageControlAlignmentCenter,
    SYPageControlAlignmentRight
};
```

- PageControl TintColor
  
  ​

### License

SYADDemo is under MIT License. See LICENSE file for more information.