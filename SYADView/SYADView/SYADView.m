//
//  SYADView.m
//  SYADDemo
//  https://github.com/sauchye/SYADView
//  Created by Sauchye on 7/24/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//



#import "SYADView.h"

static NSInteger const BUTTON_TAG = 100001;
static CGFloat const  LEFT_OR_RIGHT_WIDTH = 80;
static CGFloat const  padding = 20;

@interface SYADView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *adScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *imgData;
@property (nonatomic) CGFloat currentWidth;
@property (nonatomic) CGFloat currentHeight;

@end

@implementation SYADView

#pragma mark - configureADScrollView

- (instancetype)initWithFrame:(CGRect)frame
            imageData:(NSArray *)imageData
        pageTintColor:(UIColor *)pageTintColor
     currentTintColor:(UIColor *)currentTintColor
        pageControlAlignment:(SYPageControlAlignment)pageControlAlignment{

    self = [super initWithFrame:frame];
    
    if (self) {
        
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
        _adScrollView.bounces = NO;
        _adScrollView.showsHorizontalScrollIndicator = NO;
        _adScrollView.showsVerticalScrollIndicator = NO;
        _adScrollView.contentOffset = CGPointMake(_currentWidth, 0);
        _adScrollView.contentSize = CGSizeMake(_currentWidth * (imageData.count + 2), _currentHeight);
        _adScrollView.delegate = self;
        
        _pageControl = [UIPageControl new];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = imageData.count;
        _pageControl.pageIndicatorTintColor = pageTintColor;
        _pageControl.currentPageIndicatorTintColor = currentTintColor;

        if (pageControlAlignment == SYPageControlAlignmentLeft) {
            
            _pageControl.frame = CGRectMake(padding, _currentHeight - padding, LEFT_OR_RIGHT_WIDTH, padding);
            
        }else if (pageControlAlignment == SYPageControlAlignmentCenter){
            
            _pageControl.frame = CGRectMake(0, _currentHeight - padding, _currentWidth, padding);
            
        }else if (pageControlAlignment == SYPageControlAlignmentRight){
            
            _pageControl.frame = CGRectMake(_currentWidth - padding - LEFT_OR_RIGHT_WIDTH, _currentHeight - padding, LEFT_OR_RIGHT_WIDTH, padding);
        }

        [self addSubview:_pageControl];
        [self startAd];

    }
    return self;
}

- (void)tapBtnClick:(UIButton *)sender{
    
    if (_didSelectedImageBlock) {
        
        _didSelectedImageBlock(sender.tag - BUTTON_TAG,nil);
    }
}

#pragma mark - startAd
- (void)startAd{
    if (_timer == nil){
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                  target:self
                                                selector:@selector(nextAd)
                                                userInfo:nil
                                                 repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }else{
        [self freeTimer];
    }
}

#pragma mark - nextAd
- (void)nextAd{
    
    NSLog(@"nextAd...");
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

#pragma mark - scrollViewDidEndDecelerating
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
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

#pragma mark - freeTimer
- (void)freeTimer{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - dealloc
- (void)dealloc{
    [self freeTimer];
}

@end
