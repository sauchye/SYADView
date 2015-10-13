//
//  ViewController.m
//  SYADDemo
//  https://github.com/sauchye/SYADView
//  Created by Sauchye on 7/24/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "ViewController.h"
#import "SYADView.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *imgData;
@property (nonatomic, strong) SYADView *adView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SYADDemo";
    
    if (!_imgData) {
        _imgData = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg"];
    }
    
#pragma mark - Example
    if (_imgData.count > 0) {
        
        _adView = [[SYADView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)
                                        imageData:_imgData
                                    pageTintColor:[UIColor grayColor]
                                 currentTintColor:[UIColor orangeColor]
                                    pageControlAlignment:SYPageControlAlignmentRight];

        _adView.didSelectedImageBlock = ^(NSInteger index, NSString *url){
        
            NSLog(@"didSelectedImage :%ld",(long)index);
        };
        [self.view addSubview:_adView];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [_adView freeTimer];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
