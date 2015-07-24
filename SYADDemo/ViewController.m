//
//  ViewController.m
//  SYADDemo
//  https://github.com/sauchye/SYADDemo
//  Created by Sauchye on 7/24/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#import "ViewController.h"
#import "SYADView.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *imgData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SYADDemo";
    
    if (!_imgData) {
        _imgData = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg"];
    }
    
    if (_imgData.count > 0) {
        SYADView *adView = [[SYADView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2)];
        adView.imgData = _imgData;
        adView.tapImageViewClickedBlock = ^(NSInteger index, NSString *url){
            //处理点击图片逻辑
            NSLog(@"tap index :%ld",(long)index);
        };
        [self.view addSubview:adView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
