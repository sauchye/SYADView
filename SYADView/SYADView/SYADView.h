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

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) void(^didSelectedImageBlock)(NSInteger index, NSString *url);

- (void)startTimer;
- (void)dissTimer;
- (instancetype)initWithFrame:(CGRect)frame
                    imageData:(NSArray *)imageData
                   scrollTime:(NSTimeInterval)scrollTime
                pageTintColor:(UIColor *)pageTintColor
             currentTintColor:(UIColor *)currentTintColor
         pageControlAlignment:(SYPageControlAlignment)pageControlAlignment;
@end
