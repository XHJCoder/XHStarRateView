//
//  XHStarRateView.m
//  XHStarRateView
//
//  Created by 江欣华 on 16/4/1.
//  Copyright © 2016年 jxh. All rights reserved.
//

#import "XHStarRateView.h"

static NSString *const KForegroundStarImage = @"b27_icon_star_yellow";
static NSString *const KBackgroundStarImage = @"b27_icon_star_gray";
static const NSUInteger KDefaultNumberOfStar = 5;

@interface XHStarRateView()

@property (nonatomic, strong, readwrite) UIView *foregroundStarView;
@property (nonatomic, strong, readwrite) UIView *backgroundStarView;
@property (nonatomic, assign, readwrite) NSUInteger numberOfStar; // 星星数量
@property (nonatomic, copy) XHStarRateViewRateCompletionBlock completionBlock;

@end

@implementation XHStarRateView

#pragma mark - Init Method

// 指定初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                 numberOfStar:(NSInteger)numberOfStar
                    rateStyle:(XHStarRateViewRateStye)rateStyle
                  isAnimation:(BOOL)isAnimation
                   completion:(XHStarRateViewRateCompletionBlock)completionBlock
                     delegate:(id)delegate
{
    if (self = [super initWithFrame:frame]) {
        _numberOfStar    = numberOfStar;
        _rateStyle       = rateStyle;
        _isAnimation     = isAnimation;
        _completionBlock = completionBlock;
        _delegate        = delegate;
        [self createStarView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self createStarView];
    }
    return self;
}

#pragma mark 代理方式

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame
                  numberOfStar:KDefaultNumberOfStar
                     rateStyle:XHStarRateViewRateStyeFullStar
                   isAnimation:NO
                    completion:nil
                      delegate:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
                 numberOfStar:(NSInteger)numberOfStar
                    rateStyle:(XHStarRateViewRateStye)rateStyle
                  isAnimation:(BOOL)isAnimation
                     delegate:(id)delegate
{
    return [self initWithFrame:frame
                  numberOfStar:numberOfStar
                     rateStyle:rateStyle
                   isAnimation:isAnimation
                    completion:nil
                      delegate:delegate];
}

#pragma mark block方式

- (instancetype)initWithFrame:(CGRect)frame
                   completion:(XHStarRateViewRateCompletionBlock)completionBlock
{
    return [self initWithFrame:frame
                  numberOfStar:KDefaultNumberOfStar
                     rateStyle:XHStarRateViewRateStyeFullStar
                   isAnimation:NO
                    completion:completionBlock
                      delegate:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
                 numberOfStar:(NSInteger)numberOfStar
                    rateStyle:(XHStarRateViewRateStye)rateStyle
                  isAnimation:(BOOL)isAnimation
                   completion:(XHStarRateViewRateCompletionBlock)completionBlock
{
    return [self initWithFrame:frame
                  numberOfStar:numberOfStar
                     rateStyle:rateStyle
                   isAnimation:isAnimation
                    completion:completionBlock
                      delegate:nil];
}

- (void)dealloc {
    self.delegate = nil;
    self.completionBlock = nil;
}

#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat animationDuration = (self.isAnimation ? 0.2 : 0);
    [UIView animateWithDuration:animationDuration animations:^{
        self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width / self.numberOfStar * self.currentRating, self.bounds.size.height);
    }];
}

#pragma mark - Custom Accessors

- (void)setCurrentRating:(CGFloat)currentRating {
    if (_currentRating == currentRating) {
        return;
    }
    if (currentRating < 0) {
        _currentRating = 0;
    } else if (currentRating > _numberOfStar) {
        _currentRating = _numberOfStar;
    } else {
        _currentRating = currentRating;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:ratingDidChange:)]) {
        [self.delegate starRateView:self ratingDidChange:_currentRating];
    }
    
    if (self.completionBlock) {
        _completionBlock(_currentRating);
    }
    [self setNeedsLayout];
}

#pragma mark - Private Method

- (void)createStarView {
    self.foregroundStarView = [self createStarViewWithImageNamed:KForegroundStarImage];
    self.backgroundStarView = [self createStarViewWithImageNamed:KBackgroundStarImage];
    
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width * _currentRating / _numberOfStar, self.bounds.size.height);
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (UIView *)createStarViewWithImageNamed:(NSString *)name {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < _numberOfStar; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / _numberOfStar, 0, self.bounds.size.width / _numberOfStar, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realRating = offset / (self.bounds.size.width / _numberOfStar);

    switch (_rateStyle) {
        case XHStarRateViewRateStyeFullStar: {
            self.currentRating = ceilf(realRating);
            break;
        }
        case XHStarRateViewRateStyeHalfStar: {
            float round = roundf(realRating);
            self.currentRating = (round > realRating) ? round : (round + 0.5);
            break;
        }
        case XHStarRateViewRateStyeIncompleteStar: {
            self.currentRating = realRating;
            break;
        }
    }
}

@end
