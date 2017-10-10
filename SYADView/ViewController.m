//
//  ViewController.m
//  SYADView
//  https://github.com/sauchye/SYADView
//  Created by Saucheong Ye on 7/24/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#import "ViewController.h"
#import "SYADView.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *imgData;
@property (nonatomic, strong) SYADView *adView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = @"SYADView";
    
    if (!_imgData) {
        _imgData = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg"];
    }
    
#pragma mark - Example
    if (_imgData) {
        
        _adView = [[SYADView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)
                                        imageData:_imgData
                             pageControlAlignment:SYPageControlAlignmentRight];
        
//        _adView.currentTintColor = [UIColor redColor];
//        _adView.pageTintColor = [UIColor whiteColor];
        _adView.scrollTime = 2.f;
        __weak typeof(self) weakSelf = self;
        [self.view addSubview:_adView];
        _adView.didSelectImageBlock = ^(NSInteger index){
            [weakSelf.navigationController pushViewController:[DetailViewController  new] animated:YES];
            NSLog(@"didSelectedImage :%ld",(long)index);
        };
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (!_adView.timer.isValid) {
        [_adView startScroll];
    }
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    if (_adView.timer.isValid) {
        [_adView endScroll];
    }

}


@end
