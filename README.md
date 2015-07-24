###SYADDemo

###Installation
pod 'SYADDemo'
###Usage
#import SYADView
##easy use


        SYADView *adView = [[SYADView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2)];
        adView.imgData = _imgData;
        adView.tapImageViewClickedBlock = ^(NSInteger index, NSString *url){
            //处理点击图片逻辑
            NSLog(@"tap index :%ld",(long)index);
        };
        [self.view addSubview:adView];

###License
This project is under MIT License. See LICENSE file for more information.