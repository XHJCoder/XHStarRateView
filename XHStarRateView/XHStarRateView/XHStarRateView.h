//
//  XHStarRateView.h
//  XHStarRateView
//
//  Created by 江欣华 on 16/4/1.
//  Copyright © 2016年 jxh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHStarRateView;

/**
 点击评分的 block 回调

 @param currentScore 当前评论分数，CGFloat 类型
 */
typedef void(^XHStarRateViewRateCompletionBlock)(CGFloat currentScore);

/**
 星级评分样式

 - XHStarRateViewRateStyeFullStar:       整星评论，默认样式。
 - XHStarRateViewRateStyeHalfStar:       允许半星评论。
 - XHStarRateViewRateStyeIncompleteStar: 允许不完整星评论。
 */
typedef NS_ENUM(NSUInteger, XHStarRateViewRateStye) {
    XHStarRateViewRateStyeFullStar,
    XHStarRateViewRateStyeHalfStar,
    XHStarRateViewRateStyeIncompleteStar,
};

/**
 点击评分的代理方法
 */
@protocol XHStarRateViewDelegate <NSObject>
-(void)starRateView:(XHStarRateView *)starRateView ratingDidChange:(CGFloat)currentRating;
@end

@interface XHStarRateView : UIView

@property (nonatomic, assign) BOOL isAnimation;                 // 是否动画显示，默认 NO
@property (nonatomic, assign) XHStarRateViewRateStye rateStyle; // 星级评分样式
@property (nonatomic, weak) id<XHStarRateViewDelegate> delegate;

/**
 *通过代理的方法获取当前评分数currentScore
 */
- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame
                 numberOfStar:(NSInteger)numberOfStar
                    rateStyle:(XHStarRateViewRateStye)rateStyle
                  isAnimation:(BOOL)isAnimation
                     delegate:(id)delegate;

/**
 *通过Block传值的方法获取当前评分数currentScore
 */
- (instancetype)initWithFrame:(CGRect)frame
                   completion:(XHStarRateViewRateCompletionBlock)completionBlock;

- (instancetype)initWithFrame:(CGRect)frame
                 numberOfStar:(NSInteger)numberOfStar
                    rateStyle:(XHStarRateViewRateStye)rateStyle
                  isAnimation:(BOOL)isAnimation
                   completion:(XHStarRateViewRateCompletionBlock)completionBlock;

@end
