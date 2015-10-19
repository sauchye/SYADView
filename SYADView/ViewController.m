//
//  ViewController.m
//  SYADView
//  https://github.com/sauchye/SYADView
//  Created by Saucheong Ye on 7/24/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "ViewController.h"
#import "DetailViewController.h"
#import "SYADView.h"

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
    if (_imgData.count > 0) {
        
        _adView = [[SYADView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)
                                        imageData:_imgData
                                       scrollTime:3.0
                                    pageTintColor:[UIColor whiteColor]
                                 currentTintColor:[UIColor orangeColor]
                                    pageControlAlignment:SYPageControlAlignmentRight];

        __weak typeof(self) weakSelf = self;
        _adView.didSelectedImageBlock = ^(NSInteger index, NSString *url){
        
            NSLog(@"didSelectedImage :%ld",(long)index);
            [weakSelf.navigationController pushViewController:[[DetailViewController alloc] init] animated:YES];
        };
        [self.view addSubview:_adView];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (!_adView.timer.isValid) {
        [_adView startTimer];
    }
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [_adView dissTimer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
