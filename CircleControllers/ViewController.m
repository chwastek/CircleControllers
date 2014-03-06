//
//  ViewController.m
//  CircleControllers
//
//  Created by Filip Chwastowski on 03.03.2014.
//  Copyright (c) 2014 Shoikan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController (){
    FCProgressView *_slider;
}

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	_slider = [[FCProgressView alloc] initWithFrame:self.sliderPlaceholder.bounds];
    [self.sliderPlaceholder addSubview:_slider];
    self.progress = 0.0f;
    _slider.value = self.progress;
    self.progressView.progress = self.progress;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

-(void)updateProgress{
    self.progress += 0.01;
    if (self.progress >= 1.01) {
        [self.timer invalidate];
        self.timer = nil;
    }else{
        [_slider setValue:self.progress animated:YES];
        [self.progressView setProgress:self.progress animated:YES];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
