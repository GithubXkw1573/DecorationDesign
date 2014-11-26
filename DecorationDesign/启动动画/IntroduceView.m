//
//  IntroduceView.m
//  QSQ
//
//  Created by ssyz on 13-8-20.
//  Copyright (c) 2013年 luob. All rights reserved.
//

#import "IntroduceView.h"
#import "DDAppDelegate.h"

@implementation IntroduceView
@synthesize viewControllers;
@synthesize pageControl;
@synthesize imagescrollView;

-(void)dealloc
{
    [imagescrollView release];
    [pageControl release];
    [viewControllers release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIScrollView *guanggaoscrollView=[[UIScrollView alloc] init];
        if (iOS7Later) {
            guanggaoscrollView.frame=CGRectMake(0, -20, applicationwidth, boundsheight);
        }
        else
        {
            guanggaoscrollView.frame=CGRectMake(0, 0, applicationwidth, applicationheight);
        }
        guanggaoscrollView.backgroundColor=[UIColor clearColor];
        guanggaoscrollView.tag=1;
        self.imagescrollView=guanggaoscrollView;
        [self addSubview:guanggaoscrollView];
        [guanggaoscrollView release];
        
        guanggaoscrollView.bounces=NO;
        guanggaoscrollView.pagingEnabled = YES;
        guanggaoscrollView.showsHorizontalScrollIndicator = NO;
        guanggaoscrollView.showsVerticalScrollIndicator = NO;
        guanggaoscrollView.scrollsToTop = NO;
        guanggaoscrollView.delegate = self;
        
        UIPageControl *page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, applicationheight, applicationwidth, 20)];
        page.backgroundColor = [UIColor clearColor];
        [page addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        self.pageControl=page;
        [self addSubview:page];
        [page release];
        
        kNumberOfPages=5;
        
        NSMutableArray *controllers = [[NSMutableArray alloc] init];
        for (int i = 0; i < kNumberOfPages; i++) {
            [controllers addObject:[NSNull null]];
        }
        self.viewControllers = controllers;
        [controllers release];
        
        imagescrollView.contentSize = CGSizeMake(guanggaoscrollView.frame.size.width * kNumberOfPages, guanggaoscrollView.frame.size.height);
        
        pageControl.numberOfPages = kNumberOfPages;
        pageControl.currentPage = 0;
        
        if (kNumberOfPages>=2) {
            [self loadScrollViewWithPage:0];
            [self loadScrollViewWithPage:1];
        }
        else if(kNumberOfPages==1){
            [self loadScrollViewWithPage:0];
        }
    }
    return self;
}

-(void)BeganBtnPressed:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"firstused%@",MineVersion]];
    
    self.superview.alpha=1.0;
    UIVIEW_ANIMATION_BEGIN3(@"detail_ani", 1.0, @selector(animationDidStop:));
    self.superview.alpha=0.0;
    UIVIEW_ANIMATION_END;
    
    DDAppDelegate *delegate = (DDAppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate.window setRootViewController:delegate.TabBarController];
    [delegate.window insertSubview:self.superview atIndex:77];
}

-(void)animationDidStop:(id)sender
{
    [self.superview removeFromSuperview];
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
    
    // replace the placeholder if necessary
    UIView *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[UIView alloc] init];
        
        UIImageView *mypageview=[[UIImageView alloc]init];
        if (iOS7Later) {
            mypageview.frame=CGRectMake(0, 0, applicationwidth, boundsheight);
        }
        else
        {
            mypageview.frame=CGRectMake(0, 0, applicationwidth, applicationheight);
        }
        
        if (applicationheight>460) {
            mypageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"初次登录%i长.png",page]];
        }
        else
        {
            mypageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"初次登录%i.png",page]];
        }
        
        [controller addSubview:mypageview];
        [mypageview release];
        
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
        
        if (page==kNumberOfPages-1) {
            UIButton *beganbtn=[UIButton buttonWithType:UIButtonTypeCustom];
            if (iOS7Later) {
                beganbtn.frame=CGRectMake(80, applicationheight-44-60, 160, 60);
            }
            else
            {
                beganbtn.frame=CGRectMake(80, applicationheight-22-60, 160, 60);
            }
            [beganbtn setBackgroundImage:[UIImage imageNamed:@"开启推享之旅.png"] forState:UIControlStateNormal];
//            [beganbtn setBackgroundImage:[UIImage imageNamed:@"返回按下jpg"] forState:UIControlEventTouchDown];
            [beganbtn addTarget:self action:@selector(BeganBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [controller addSubview:beganbtn];
        }
    }
    
    // add the controller's view to the scroll view
    if (nil == controller.superview) {
        CGRect frame = imagescrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.frame = frame;
        [imagescrollView addSubview:controller];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==1) {
        if (pageControlUsed) {
            return;
        }
        
        CGFloat pageWidth = imagescrollView.frame.size.width;
        int page = floor((imagescrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage = page;
        
        [self loadScrollViewWithPage:page - 1];
        [self loadScrollViewWithPage:page];
        [self loadScrollViewWithPage:page + 1];
    }
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (void)changePage:(id)sender {
    int page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = imagescrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [imagescrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
