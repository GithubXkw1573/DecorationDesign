//
//  EGORefreshTableFooterView.h
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	FooterEGOOPullRefreshPulling = 0,
	FooterEGOOPullRefreshNormal,
	FooterEGOOPullRefreshLoading,
} FooterEGOPullRefreshState;

@protocol EGORefreshTableFooterDelegate;

@interface EGORefreshTableFooterView : UIView {
	
	id _delegate;
	FooterEGOPullRefreshState _state;
    
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
}

@property(nonatomic,assign) id<EGORefreshTableFooterDelegate> delegate;

- (void)refreshLastUpdatedDate;
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

@protocol EGORefreshTableFooterDelegate

// 开始刷新委托
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView *)view;
// 是否处于加载状态
- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView *)view;
@optional
// 返回最后更新时间
- (NSDate *)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView *)view;

@end