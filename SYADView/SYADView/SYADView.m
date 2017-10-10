//
//  SYADView.m
//  SYADView
//  https://github.com/sauchye/SYADView
//  Created by Saucheong Ye on 7/24/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//



#import "SYADView.h"

static NSInteger const BUTTON_TAG = 100001;
static CGFloat const  LEFT_OR_RIGHT_WIDTH = 80;
static CGFloat const  padding = 20;
static NSTimeInterval const  delay = 3.0;

@interface SYADView ()<UIScrollViewDelegate>

/**
 *  default scrollsToTop NO
 */
@property (nonatomic, strong) UIScrollView *adScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imgData;
@property (nonatomic) CGFloat currentWidth;
@property (nonatomic) CGFloat currentHeight;

@end

@implementation SYADView


- (instancetype)initWithFrame:(CGRect)frame
                    imageData:(NSArray *)imageData
         pageControlAlignment:(SYPageControlAlignment)pageControlAlignment{
    
    if (self = [super initWithFrame:frame]) {
        
        _imgData = imageData;
        _adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width/2)];
        [self addSubview:_adScrollView];
        
        _currentWidth = _adScrollView.frame.size.width;
        _currentHeight = _adScrollView.frame.size.height;
        
        
        UIImageView *last = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _currentWidth, _currentHeight)];
        last.image = [UIImage imageNamed:imageData.lastObject];
        [_adScrollView addSubview:last];
        
        for (NSInteger i = 0; i < imageData.count; ++i){
            UIImage *image = [UIImage imageNamed:imageData[i]];
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake((i+1) * _currentWidth, 0, _currentWidth, _currentHeight)];
            view.image = image;
            view.userInteractionEnabled = YES;
            [_adScrollView addSubview:view];
            
            UIButton *tapBtn = [[UIButton alloc] init];
            tapBtn.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            [tapBtn addTarget:self action:@selector(tapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            tapBtn.tag = i + BUTTON_TAG;
            [view addSubview:tapBtn];
        }
        
        UIImageView *first = [[UIImageView alloc] initWithFrame:CGRectMake(_currentWidth * (imageData.count + 1), 0, _currentWidth, _currentHeight)];
        first.image = [UIImage imageNamed:imageData.firstObject];
        
        
        [_adScrollView addSubview:first];
        
        _adScrollView.pagingEnabled = YES;
        _adScrollView.scrollsToTop = NO;
        _adScrollView.bounces = NO;
        _adScrollView.showsHorizontalScrollIndicator = NO;
        _adScrollView.showsVerticalScrollIndicator = NO;
        _adScrollView.contentOffset = CGPointMake(_currentWidth, 0);
        _adScrollView.contentSize = CGSizeMake(_currentWidth * (imageData.count + 2), _currentHeight);
        _adScrollView.delegate = self;
        
        _pageControl = [UIPageControl new];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = imageData.count;
        _pageControl.pageIndicatorTintColor = self.pageTintColor;
        _pageControl.currentPageIndicatorTintColor = self.currentTintColor;
        

        if (pageControlAlignment == SYPageControlAlignmentLeft) {
            
            _pageControl.frame = CGRectMake(padding, _currentHeight - padding, LEFT_OR_RIGHT_WIDTH, padding);
            
        }else if (pageControlAlignment == SYPageControlAlignmentCenter){
            
            _pageControl.frame = CGRectMake(0, _currentHeight - padding, _currentWidth, padding);
            
        }else if (pageControlAlignment == SYPageControlAlignmentRight){
            
            _pageControl.frame = CGRectMake(_currentWidth - padding - LEFT_OR_RIGHT_WIDTH, _currentHeight - padding, LEFT_OR_RIGHT_WIDTH, padding);
        }

        [self addSubview:_pageControl];
        

    }
    return self;
}

#pragma mark - startScroll
- (void)startScroll{
    
    if (_scrollTime > 0) {
        if (!_timer){
            __weak typeof(self) weakSelf = self;
            _timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTime
                                                      target:weakSelf
                                                    selector:@selector(nextAd)
                                                    userInfo:nil
                                                     repeats:YES];
            
            [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSDefaultRunLoopMode];
        }
    }
}

#pragma mark- nextAd
- (void)nextAd{

    NSLog(@"NEXT AD");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _adScrollView.contentOffset = CGPointMake(_adScrollView.contentOffset.x + _currentWidth, 0);
    
    NSInteger page = (_adScrollView.contentOffset.x - _currentWidth) / _currentWidth;
    [UIView commitAnimations];
    
    if (page == -1){
        
        [_adScrollView setContentOffset:CGPointMake(_currentWidth * _imgData.count, 0)];
        _pageControl.currentPage = _imgData.count - 1;
        
    }else if (page == _imgData.count){
        
        [_adScrollView setContentOffset:CGPointMake(_currentWidth, 0)];
        _pageControl.currentPage = 0;
        
    }else{
        _pageControl.currentPage = page;
    }
}


#pragma mark - Handel Event
- (void)tapBtnClick:(UIButton *)sender{
    
    if (_didSelectImageBlock) {
        
        _didSelectImageBlock(sender.tag - BUTTON_TAG);
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    if (_scrollTime > 0) {
        [self startScroll];
    }
    
    NSInteger page = (scrollView.contentOffset.x - _currentWidth) / _currentWidth;
    
    if (page == -1){
        
        [_adScrollView setContentOffset:CGPointMake(_currentWidth * _imgData.count, 0)];
        _pageControl.currentPage = _imgData.count-1;
        
    }else if (page == _imgData.count){
        
        [_adScrollView setContentOffset:CGPointMake(_currentWidth, 0)];
        _pageControl.currentPage = 0;
    }else{
        
        _pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self endScroll];
}


#pragma mark - setter

@synthesize pageTintColor = _pageTintColor;
@synthesize currentTintColor = _currentTintColor;
@synthesize scrollTime = _scrollTime;

- (UIColor *)pageTintColor{
    
    if (!_pageTintColor) {
        _pageTintColor = [UIColor whiteColor];
    }
    return _pageTintColor;
}

- (void)setPageTintColor:(UIColor *)pageTintColor{
    
    if (_pageControl) {
        _pageControl.pageIndicatorTintColor = pageTintColor;
    }
    _pageTintColor = pageTintColor;
}


- (void)setCurrentTintColor:(UIColor *)currentTintColor{
    
    if (_pageControl) {
        _pageControl.currentPageIndicatorTintColor = currentTintColor;
    }
    _currentTintColor = currentTintColor;
}

- (UIColor *)currentTintColor{
    
    if (!_currentTintColor) {
        _currentTintColor = [UIColor orangeColor];
    }
    return _currentTintColor;
}

- (void)setScrollTime:(NSTimeInterval)scrollTime{
    
    if (!scrollTime) {
        _scrollTime = delay;
    }else{
        _scrollTime = scrollTime;
    }
}

#pragma mark - applicationDidBecomeActive
- (void)applicationWillResignActive{
    [self endScroll];
}

- (void)applicationDidBecomeActive{
    
    if (_scrollTime > 0){
        [self startScroll];
    }
}

#pragma mark - dissmissScroll
- (void)endScroll{
    [_timer invalidate];
    _timer = nil;
}

@end
