# XHStarRateView
iOS自定义星级评论视图 ⭐️⭐️⭐️⭐️⭐️

## Demo

![](https://ws2.sinaimg.cn/large/006tKfTcly1fmxkuml0brg30af0ij0y0.gif)

## 功能特性
* 支持设置任意星星数量;
* 支持动画修改评论效果；
* 多种评分样式支持：整星评论、半星评论、不完整星星评论；
* 支持 block  和 delegate 两种方式返回修改结果；



## 如何使用

1. 下载并拖拽 **XHStarRateView.h** 与 **XHStarRateView.m** 文件到项目。
2. 导入头文件 `import "XHStarRateView.h"`。
3. 如果需要，遵守代理协议 **XHStarRateViewDelegate**。



### 通过代理的方法获取当前评分数

```objective-c
XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(20, 60, 200, 30)];
starRateView.isAnimation = YES; // 设置是否有动画
starRateView.rateStyle = XHStarRateViewRateStyeIncompleteStar; // 设置星级评分样式
starRateView.tag = 1;
starRateView.delegate = self; // 遵守代理协议
[self.view addSubview:starRateView];
```

你也可以使用封装好的完全初始化方法：

```objective-c
XHStarRateView *starRateView2 = [[XHStarRateView alloc] initWithFrame:CGRectMake(20, 100, 200, 30) numberOfStar:5 rateStyle:XHStarRateViewRateStyeHalfStar isAnimation:NO delegate:self];
starRateView2.tag = 2;
[self.view addSubview:starRateView2];
```

实现代理协议：

```objective-c
-(void)starRateView:(XHStarRateView *)starRateView ratingDidChange:(CGFloat)currentRating {
    NSLog(@"%ld----  %f",(long)starRateView.tag,currentRating);
}
```



### 通过Block传值的方法获取当前评分数

```objective-c
XHStarRateView *starRateView3 = [[XHStarRateView alloc] initWithFrame:CGRectMake(20, 140, 200, 30) completion:^(CGFloat currentScore) {
    NSLog(@"3----  %f",currentScore);
}];

[self.view addSubview:starRateView3];
```

当然，此方式也有一个可用的完全初始化方法：

```objective-c
XHStarRateView *starRateView4 = [[XHStarRateView alloc] initWithFrame:CGRectMake(20, 180, 200, 30) numberOfStar:8 rateStyle:XHStarRateViewRateStyeHalfStar isAnimation:YES completion:^(CGFloat currentScore) {
    NSLog(@"4----  %f",currentScore);
}];
[self.view addSubview:starRateView4];
```






