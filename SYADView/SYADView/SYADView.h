//
//  SYADView.h
//  SYADView
//  https://github.com/sauchye/SYADView
//  Created by Saucheong Ye on 7/24/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SYPageControlAlignment) {
    
    SYPageControlAlignmentLeft = 0,
    SYPageControlAlignmentCenter,
    SYPageControlAlignmentRight
};

@interface SYADView : UIView

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, strong) UIColor *pageTintColor;
@property (nonatomic, strong) UIColor *currentTintColor;
// default 3.0  if is scrollTime 0 not scroll
@property (nonatomic, assign) NSTimeInterval scrollTime;

@property (nonatomic, copy) void(^didSelectImageBlock)(NSInteger index);


- (void)startScroll;
- (void)endScroll;
- (instancetype)initWithFrame:(CGRect)frame
                    imageData:(NSArray *)imageData
         pageControlAlignment:(SYPageControlAlignment)pageControlAlignment;

@end
