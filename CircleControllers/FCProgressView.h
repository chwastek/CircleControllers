//
//  CircleSlider.h
//  CircleControllers
//
//  Created by Filip Chwastowski on 03.03.2014.
//  Copyright (c) 2014 Shoikan. All rights reserved.
//

#import <UIKit/UIKit.h>
@import QuartzCore;

@interface FCProgressView : UIControl

//values & limits
@property(nonatomic, assign) CGFloat progress;
@property(nonatomic, assign, getter = isAnimated) BOOL animated;
@property(nonatomic, assign, getter = isClockwise) BOOL clockwise;
@property(nonatomic, assign, getter = isCountdown) BOOL countdown;

//appearance
@property(nonatomic, strong) UIColor *progressTintColor;
@property(nonatomic, strong) UIColor *trackTintColor;
@property(nonatomic, assign) CGFloat lineWidth;

@property(nonatomic, readonly, strong) CAShapeLayer *trackLayer;
@property(nonatomic, readonly, strong) CAShapeLayer *progressLayer;

@property(nonatomic, assign) CGFloat maxAngle;
@property(nonatomic, assign) CGFloat minAngle;
@property(nonatomic, strong) UILabel *status;

-(void)setValue:(float)value animated:(BOOL)animated;
-(void)setLineWidth:(CGFloat)lineWidth;
@end
