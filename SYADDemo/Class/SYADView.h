//
//  SYADView.h
//  SYADDemo
//  https://github.com/sauchye/SYADDemo
//  Created by Sauchye on 7/24/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYADView : UIView

@property (nonatomic, strong) UIScrollView *adScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *imgData;/**< 图片数据*/

/**
 *  点击图片事件 图片:index 传参数:url
 */
@property (nonatomic, copy) void(^tapImageViewClickedBlock)(NSInteger index, NSString *url);

@end
