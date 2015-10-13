//
//  SYADView.h
//  SYADDemo
//  https://github.com/sauchye/SYADView
//  Created by Sauchye on 7/24/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SYPageControlAlignment) {
    
    SYPageControlAlignmentLeft = 0,
    SYPageControlAlignmentCenter,
    SYPageControlAlignmentRight
};

@interface SYADView : UIView

/**
 *  tap image event
 */
@property (nonatomic, copy) void(^didSelectedImageBlock)(NSInteger index, NSString *url);

- (void)freeTimer;

- (instancetype)initWithFrame:(CGRect)frame
            imageData:(NSArray *)imageData
        pageTintColor:(UIColor *)pageTintColor
     currentTintColor:(UIColor *)currentTintColor
        pageControlAlignment:(SYPageControlAlignment)pageControlAlignment;
@end
