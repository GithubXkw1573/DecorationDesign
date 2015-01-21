//
//  EGORefreshTableFooterView.m
//  Demo
//
//

#import "EGORefreshTableFooterView.h"

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION     0.18f

#define RefreshViewHight    65.0f

@interface EGORefreshTableFooterView (Private)
- (void)setState:(FooterEGOPullRefreshState)aState;
@end

@implementation EGORefreshTableFooterView

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
		layer.contents = (id)[UIImage imageNamed:@"blueArrowDown.png"].CGImage;
		
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
		[self setState:FooterEGOOPullRefreshNormal];
    }
	
    return self;
}

#pragma mark -
#pragma mark Update Date

- (void)refreshLastUpdatedDate {
	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceLastUpdated:)]) {
		
		NSDate *date = [_delegate egoRefreshTableFooterDataSourceLastUpdated:self];
		
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

- (void)setState:(FooterEGOPullRefreshState)aState{
	
	switch (aState) {
            
		case FooterEGOOPullRefreshPulling:
			
			_statusLabel.text = NSLocalizedString(@"松开即可加载...", @"松开即可加载...");
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			
			break;
		case FooterEGOOPullRefreshNormal:
			
			if (_state == FooterEGOOPullRefreshPulling) {
                
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			_statusLabel.text = NSLocalizedString(@"上拉加载...", @"上拉加载...");
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self refreshLastUpdatedDate];
			
			break;
		case FooterEGOOPullRefreshLoading:
			
			_statusLabel.text = NSLocalizedString(@"加载中...", @"加载中...");
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
 [egoRefreshFooterView egoRefreshScrollViewDidScroll:myscrollView];
 }
 **/
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {	
	
	if (_state == FooterEGOOPullRefreshLoading) {     // 加载状态
		
		scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, RefreshViewHight, 0.0f);
		
	} else if (scrollView.isDragging) {     // 未加载状态 && 拖动
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)]) {
            
			_loading = [_delegate egoRefreshTableFooterDataSourceIsLoading:self];
		}
        
        float heght;
        if (scrollView.contentSize.height<scrollView.frame.size.height) {
            heght =scrollView.frame.size.height;
        }else
        {
            heght =scrollView.contentSize.height;
        }
        
        // 未加载状态
		if (_state == FooterEGOOPullRefreshPulling && scrollView.contentOffset.y + scrollView.frame.size.height < heght + RefreshViewHight && scrollView.contentOffset.y > 0.0f && !_loading) {   // 拖动状态 && RefreshView未完整显示
            
			[self setState:FooterEGOOPullRefreshNormal];      // 正常状态
            
		} else if (_state == FooterEGOOPullRefreshNormal && scrollView.contentOffset.y + (scrollView.frame.size.height) > heght + RefreshViewHight  && !_loading) {   // 正常状态 && RefreshView完整显示
            
//            NSLog(@"%f",scrollView.contentOffset.y);
//            NSLog(@"%f",(scrollView.frame.size.height));
//            NSLog(@"%f",scrollView.contentSize.height);
//            NSLog(@"%f",RefreshViewHight);
            
			[self setState:FooterEGOOPullRefreshPulling];     // 拖动状态
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
 [egoRefreshFooterView egoRefreshScrollViewDidEndDragging:myscrollView];
 }
 **/
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)]) {
        
		_loading = [_delegate egoRefreshTableFooterDataSourceIsLoading:self];
	}
	
    float heght;
    if (scrollView.contentSize.height<scrollView.frame.size.height) {
        heght =scrollView.frame.size.height;
    }else
    {
        heght =scrollView.contentSize.height;
    }
    
	if (scrollView.contentOffset.y + scrollView.frame.size.height > heght + RefreshViewHight && !_loading) {
		
        if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDidTriggerRefresh:)]) {
            
			[_delegate egoRefreshTableFooterDidTriggerRefresh:self];
		}
		
		[self setState:FooterEGOOPullRefreshLoading];     // 加载状态
        
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, RefreshViewHight, 0.0f);
		[UIView commitAnimations];
	}
}

//当开发者页面刷新完毕调用此方法
/**
 [egoRefreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:myscrollView];
 [delegate egoRefreshScrollViewDataSourceDidFinishedLoading:myscrollView];
 **/
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
    
	[self setState:FooterEGOOPullRefreshNormal];      // 恢复正常状态
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
