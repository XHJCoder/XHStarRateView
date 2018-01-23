//
//  ViewController.m
//  XHStarRateView
//
//  Created by huahua on 16/4/1.
//  Copyright © 2016年 jxh. All rights reserved.
//

#import "ViewController.h"
#import "XHStarRateView.h"

@interface ViewController () <XHStarRateViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     1. Delegate 方式创建
     */
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(20, 60, 200, 30)];
    starRateView.isAnimation = YES; // 有动画
    starRateView.rateStyle = XHStarRateViewRateStyeIncompleteStar; //允许不完整星评论
    starRateView.tag = 1;
    starRateView.delegate = self;
    [self.view addSubview:starRateView];
    
    /*
     2. 初始化方法创建
     半星评论、无动画
     */
    XHStarRateView *starRateView2 = [[XHStarRateView alloc] initWithFrame:CGRectMake(20, 100, 200, 30) numberOfStar:5 rateStyle:XHStarRateViewRateStyeHalfStar isAnimation:NO delegate:self];
    starRateView2.tag = 2;
    [self.view addSubview:starRateView2];
    
    /*
     3. block 方法1
     默认设置：完整星评论、
     */
    XHStarRateView *starRateView3 = [[XHStarRateView alloc] initWithFrame:CGRectMake(20, 140, 200, 30) completion:^(CGFloat currentScore) {
        NSLog(@"3----  %f",currentScore);
    }];
    
    [self.view addSubview:starRateView3];
    
    /*
     4. block 方法2
     半星评论、有动画
     */
    XHStarRateView *starRateView4 = [[XHStarRateView alloc] initWithFrame:CGRectMake(20, 180, 200, 30) numberOfStar:8 rateStyle:XHStarRateViewRateStyeHalfStar isAnimation:YES completion:^(CGFloat currentScore) {
        NSLog(@"4----  %f",currentScore);
    }];
    [self.view addSubview:starRateView4];
    
}

-(void)starRateView:(XHStarRateView *)starRateView ratingDidChange:(CGFloat)currentRating {
    NSLog(@"%ld----  %f",(long)starRateView.tag,currentRating);
}

@end
