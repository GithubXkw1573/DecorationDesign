//
//  EGORefreshTableHeaderView.m
//  Demo
//
//

#import "EGORefreshTableHeaderView.h"

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION     0.18f

#define RefreshViewHight    65.0f

@interface EGORefreshTableHeaderView (Private)
- (void)setState:(HeaderEGOPullRefreshState)aState;
@end

@implementation EGORefreshTableHeaderView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
        
        // 显示最后更新时间
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RefreshViewHight - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel = label;
		[label release];
		
        // 显示当前状态  －－  EGOOPullRefreshPulling , EGOOPullRefreshNormal , EGOOPullRefreshLoading,	
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RefreshViewHight - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		_statusLabel = label;
		[label release];
		
        // 箭头动画
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f, 0.0f, 30.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage = layer;
		
        // 加载时的旋转动画
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(25.0f, RefreshViewHight - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		[view release];
		
        // 设置状态 －－ 默认
		[self setState:HeaderEGOOPullRefreshNormal];
    }
	
    return self;
}

#pragma mark -
#pragma mark Update Date

- (void)refreshLastUpdatedDate {
	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {
		
		NSDate *date = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setAMSymbol:@"上午"];
		[formatter setPMSymbol:@"下午"];
		[formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
		_lastUpdatedLabel.text = [NSString stringWithFormat:@"最后更新: %@", [formatter stringFromDate:date]];
		[formatter release];
        
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	} else {
		
		_lastUpdatedLabel.text = nil;
	}
}

#pragma mark -
#pragma mark private

- (void)setState:(HeaderEGOPullRefreshState)aState{
	
	switch (aState) {
            
		case HeaderEGOOPullRefreshPulling:
			
			_statusLabel.text = NSLocalizedString(@"松开即可刷新...", @"松开即可刷新...");
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			
			break;
		case HeaderEGOOPullRefreshNormal:
			
			if (_state == HeaderEGOOPullRefreshPulling) {
                
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			_statusLabel.text = NSLocalizedString(@"下拉刷新...", @"下拉刷新...");
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self refreshLastUpdatedDate];
			
			break;
		case HeaderEGOOPullRefreshLoading:
			
			_statusLabel.text = NSLocalizedString(@"刷新中...", @"刷新中...");
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

//当手指在屏幕上不断拖动调用此方法
/**
 用法:
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	[egoRefreshHeaderView egoRefreshScrollViewDidScroll:myscrollView];
}
 **/
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {	
	
	if (_state == HeaderEGOOPullRefreshLoading) {     // 加载状态
		
		scrollView.contentInset = UIEdgeInsetsMake(RefreshViewHight, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {     // 未加载状态 && 拖动
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
            
			_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
		}
        
        // 未加载状态
		if (_state == HeaderEGOOPullRefreshPulling && scrollView.contentOffset.y >0-RefreshViewHight && scrollView.contentOffset.y < 0.0f && !_loading) {   // 拖动状态 && RefreshView未完整显示
            
			[self setState:HeaderEGOOPullRefreshNormal];      // 正常状态
            
		} else if (_state == HeaderEGOOPullRefreshNormal && scrollView.contentOffset.y <0-RefreshViewHight  && !_loading) {   // 正常状态 && RefreshView完整显示
            
			[self setState:HeaderEGOOPullRefreshPulling];     // 拖动状态
		}
		
		if (scrollView.contentInset.bottom != 0) {
            
			scrollView.contentInset = UIEdgeInsetsZero;
		}
	}
}

//当用户停止拖动，并且手指从屏幕中拿开的的时候调用此方法
/**
 用法:
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [egoRefreshHeaderView egoRefreshScrollViewDidEndDragging:myscrollView];
 }
 **/
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
        
		_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y <0-RefreshViewHight && !_loading) {
		
        if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
            
			[_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
		}
		
		[self setState:HeaderEGOOPullRefreshLoading];     // 加载状态
        
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(RefreshViewHight, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
}

//当开发者页面刷新完毕调用此方法
/**
 [egoRefreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myscrollView];
 [delegate egoRefreshScrollViewDataSourceDidFinishedLoading:myscrollView];
 **/
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {	
    
	[self setState:HeaderEGOOPullRefreshNormal];      // 恢复正常状态
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	
	_delegate = nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
    [super dealloc];
}

@end
