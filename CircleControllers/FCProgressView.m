//
//  CircleSlider.m
//  CircleControllers
//
//  Created by Filip Chwastowski on 03.03.2014.
//  Copyright (c) 2014 Shoikan. All rights reserved.
//

#import "FCProgressView.h"

@implementation FCProgressView{
    CGFloat prevValue;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //set values & limits
        _minValue = 0.0;
        _maxValue = 1.0;
        _animated = NO;
        _clockwise = YES;
        
        _progressTintColor = self.tintColor;
        _trackTintColor = [UIColor lightGrayColor];
        //set track
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.fillColor = [UIColor clearColor].CGColor;
        _trackLayer.backgroundColor = [UIColor clearColor].CGColor;
        _trackLayer.strokeColor = _trackTintColor.CGColor;
        _minAngle = -M_PI / 2.0;
        _angle = _minAngle;
        _maxAngle = M_PI * 3 / 2.0;
        _lineWidth = 5.0;
        _value = 0.5;
        
        //set progress
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.backgroundColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = _progressTintColor.CGColor;
        
        //set status
        _status = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)/2, CGRectGetMidY(self.bounds)/2, CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds)/2.0)];
        _status.textAlignment = NSTextAlignmentCenter;
        _status.text = @"test";
        _status.textColor = self.tintColor;
        [_trackLayer addSublayer:_status.layer];

        [self updateWithBounds:self.bounds];
        
        [self.layer addSublayer:self.trackLayer];
        [self.layer addSublayer:self.progressLayer];
        [self updateProgress];
    }
    return self;
}

#pragma mark - Rendering

-(void)updateProgress{
    CGPoint center = CGPointMake(CGRectGetMidX(self.trackLayer.bounds), CGRectGetMidY(self.trackLayer.bounds));
    CGFloat offset = self.lineWidth/2.f;
    CGFloat radius = MIN(CGRectGetHeight(self.trackLayer.bounds)/2, CGRectGetWidth(self.trackLayer.bounds)/2) - offset;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:self.minAngle
                                                      endAngle:self.maxAngle
                                                     clockwise:YES];
    self.trackLayer.lineWidth = self.lineWidth;
    self.trackLayer.path = path.CGPath;
    
    UIBezierPath *progressRing = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:radius
                                                            startAngle:self.minAngle
                                                              endAngle:self.angle
                                                             clockwise:self.clockwise];
    self.progressLayer.path = progressRing.CGPath;
    self.progressLayer.lineWidth = self.lineWidth;
//    if (self.clockwise) {
//        self.progressLayer.strokeColor = self.progressTintColor.CGColor;
//        self.trackLayer.strokeColor = self.trackTintColor.CGColor;
//    }else{
//        self.progressLayer.strokeColor = self.trackTintColor.CGColor;
//        self.trackLayer.strokeColor = self.progressTintColor.CGColor;
//    }
    
//    if (self.animated) {
//        UIBezierPath *progressRing = [UIBezierPath bezierPathWithArcCenter:center
//                                                                    radius:radius
//                                                                startAngle:self.minAngle
//                                                                  endAngle:self.maxAngle
//                                                                 clockwise:self.clockwise];
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//        animation.fromValue = [NSNumber numberWithFloat:prevValue];
//        animation.toValue = [NSNumber numberWithFloat:_value];
//        animation.removedOnCompletion = YES;
//        animation.fillMode = kCAFillModeForwards;
//        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//        [self.progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
//        self.progressLayer.path = progressRing.CGPath;
//    }else{
//        UIBezierPath *progressRing = [UIBezierPath bezierPathWithArcCenter:center
//                                                            radius:radius
//                                                        startAngle:self.minAngle
//                                                          endAngle:self.angle
//                                                         clockwise:self.clockwise];
//        self.progressLayer.path = progressRing.CGPath;
//    }
    
    self.status.text = [NSString stringWithFormat:@"%.2f", _value*100];
}

- (void)updateWithBounds:(CGRect)bounds{
    self.trackLayer.bounds = bounds;
    self.trackLayer.position = CGPointMake(CGRectGetWidth(bounds)/2.0, CGRectGetHeight(bounds)/2.0);
    self.progressLayer.bounds = bounds;
    self.progressLayer.position = CGPointMake(CGRectGetWidth(bounds)/2.0, CGRectGetHeight(bounds)/2.0);
    [self updateProgress];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - API methods

-(void)setValue:(float)value animated:(BOOL)animated{
    _animated = animated;
    prevValue = _value;
    _value = MIN(self.maxValue, MAX(self.minValue, value));
    self.angle = 2 * M_PI * value + self.minAngle;
    NSLog(@"angle = %.2f value = %.2f prev = %.2f", _angle, _value, prevValue);
    [self updateProgress];
}

-(void)setLineWidth:(CGFloat)lineWidth{
    if (lineWidth != _lineWidth) {
        _lineWidth = lineWidth;
        self.trackLayer.lineWidth = lineWidth;
        [self updateProgress];
    }
}

-(void)setProgressTintColor:(UIColor *)color{
    if(color != _progressTintColor) {
        _progressTintColor = color;
        self.trackLayer.strokeColor = color.CGColor;
    }
}

#pragma mark - Property overrides

-(void)setValue:(CGFloat)value{
    [self setValue:value animated:NO];
}

-(void)tintColorDidChange{
    self.progressTintColor = self.tintColor;
    self.status.textColor = self.tintColor;
}

//#pragma mark - Touches overrides
//
//-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
//    NSLog(@"start tracking touches!");
//    
//    return YES;
//}

@end
