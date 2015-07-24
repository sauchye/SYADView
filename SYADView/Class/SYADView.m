//
//  SYADView.m
//  SYADDemo
//  https://github.com/sauchye/SYADView
//  Created by Sauchye on 7/24/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#import "SYADView.h"

@interface SYADView ()<UIScrollViewDelegate>

@end

@implementation SYADView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



-(void)setImgData:(NSArray *)imgData{
    
    _imgData = imgData;
    [self configureADScrollView];
}

#pragma mark - configureADScrollView
- (void)configureADScrollView{
    _adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width/2)];
    [self addSubview:_adScrollView];
    
    NSInteger currentWidth = _adScrollView.frame.size.width;
    NSInteger currentHeight = _adScrollView.frame.size.height;
    
    //最开始添加 最后一张
    UIImageView *last = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, currentWidth, currentHeight)];
    last.image = [UIImage imageNamed:_imgData.lastObject];
    [_adScrollView addSubview:last];
    
    for (NSInteger i = 0; i < _imgData.count; ++i){
        UIImage *image = [UIImage imageNamed:_imgData[i]];
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake((i+1)*currentWidth, 0, currentWidth, currentHeight)];
        view.image = image;
        view.userInteractionEnabled = YES;
        [_adScrollView addSubview:view];

        UIButton *tapBtn = [[UIButton alloc] init];
        tapBtn.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        [tapBtn addTarget:self action:@selector(tapImgViewAction:) forControlEvents:UIControlEventTouchUpInside];
        tapBtn.tag = i + 10001;
        [view addSubview:tapBtn];
    }
    
    //在最后的地方添加一个冗余的view,显示第一张图片
    UIImageView *first = [[UIImageView alloc] initWithFrame:CGRectMake(currentWidth * (8+1), 0, currentWidth, currentHeight)];
    first.image = [UIImage imageNamed:_imgData.firstObject];
    
    [_adScrollView addSubview:first];
    
    _adScrollView.pagingEnabled = YES;
    _adScrollView.bounces = NO;
    _adScrollView.showsHorizontalScrollIndicator = NO;
    _adScrollView.showsVerticalScrollIndicator = NO;
    _adScrollView.contentOffset = CGPointMake(currentWidth, 0);
    _adScrollView.contentSize = CGSizeMake(currentWidth * 10, currentHeight);
    _adScrollView.delegate = self;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(currentWidth - 130, currentHeight-20, 100, 20)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _imgData.count;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    [self addSubview:_pageControl];
    [self startAd];
}

- (void)tapImgViewAction:(UIButton *)sender{
    if (_tapImageViewClickedBlock) {
        
        _tapImageViewClickedBlock(sender.tag-10001,nil);
    }
}

#pragma mark - startAd
- (void)startAd{
    if (_timer == nil){
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                  target:self
                                                selector:@selector(nextAd) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }else{
        [_timer invalidate];
        _timer = nil;
        
        //        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0
        //                                                  target:self
        //                                                selector:@selector(nextAd) userInfo:nil repeats:YES];
        //
        //        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}


- (void)nextAd{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _adScrollView.contentOffset = CGPointMake(_adScrollView.contentOffset.x + _adScrollView.frame.size.width, 0);
    
    //计算出当前的页数
    NSInteger page = (_adScrollView.contentOffset.x - _adScrollView.frame.size.width) / _adScrollView.frame.size.width;
    [UIView commitAnimations];
    
    //跳转到真正最后一页
    if (page == -1){
        [_adScrollView setContentOffset:CGPointMake(_adScrollView.frame.size.width * _imgData.count, 0)];
        _pageControl.currentPage = _imgData.count-1;
    }else if (page == _imgData.count){  //跳转到真正的第一页
        [_adScrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
        _pageControl.currentPage = 0;
    }else{
        _pageControl.currentPage = page;
    }
}

#pragma mark - scrollViewDidEndDecelerating
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //计算出当前的页数
    NSInteger width = self.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x - self.frame.size.width) / self.frame.size.width;
    
    //跳转到真正最后一页
    if (page == -1){
        [_adScrollView setContentOffset:CGPointMake(width * _imgData.count, 0)];
        _pageControl.currentPage = _imgData.count-1;
    }else if (page == _imgData.count){  //跳转到真正的第一页
        
        [_adScrollView setContentOffset:CGPointMake(width, 0)];
        _pageControl.currentPage = 0;
    }else{
        
        _pageControl.currentPage = page;
    }
}


#pragma mark - dealloc
- (void)dealloc{
    [_timer invalidate];
    _timer = nil;
}

@end
