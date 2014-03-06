//
//  ViewController.h
//  CircleControllers
//
//  Created by Filip Chwastowski on 03.03.2014.
//  Copyright (c) 2014 Shoikan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCProgressView.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *sliderPlaceholder;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (assign, nonatomic) CGFloat progress;
@property (strong, nonatomic) NSTimer *timer;

@end
