//
//  NewsScrollView.m
//  TGQ2
//
//  Created by 许开伟 on 14-8-22.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "NewsScrollView.h"

@implementation NewsScrollView
@synthesize viewControllers;
@synthesize zixunleibieused;
@synthesize navigationScrollView;
@synthesize t_delegate;
@synthesize shaixuan;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize =CGSizeMake(applicationwidth, self.frame.size.height-1);
        self.pagingEnabled =YES;
        self.tag =2;
        self.delegate = self;
        self.backgroundColor =[UIColor clearColor];
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.directionalLockEnabled = YES;
        UIPageControl *page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, applicationheight-44, applicationwidth, 20)];
        page.backgroundColor = [UIColor clearColor];
        [page addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        pageControl=page;
        [self addSubview:page];
        [page release];
    }
    return self;
}

-(void)reloadscrollview:(NSMutableArray*)menuList
{
    self.zixunleibieused = menuList;
    //zixunleibieused=[[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"zixunleibieused%@",[UserInfo shared].m_UserName]]];
    self.contentSize =CGSizeMake(applicationwidth*[zixunleibieused count], applicationheight-44-44-49);
    self.hidden=NO;
    
    kNumberOfPages=[zixunleibieused count];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    for(UIView *v in self.viewControllers)
    {
        if ((NSNull*)v !=[NSNull null]) {
            [v removeFromSuperview];
        }
        
    }
    [self.viewControllers removeAllObjects];
    self.viewControllers = controllers;
    [controllers release];
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    
    if (kNumberOfPages>=2) {
        [self loadScrollViewWithPage:0];
        [self loadScrollViewWithPage:1];
    }
    else if(kNumberOfPages==1){
        [self loadScrollViewWithPage:0];
    }
    else if(kNumberOfPages==0)
    {
        self.hidden=YES;
    }
}

-(void)loadScrollViewWithPage:(int)page
{
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
    
    UIView *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[UIView alloc] init];
        NewsTableView *newsTableView = [[NewsTableView alloc] initWithFrame:CGRectMake(0,0, applicationwidth, applicationheight-44-44-49)];
        newsTableView.tag=99;
        [controller addSubview:newsTableView];
        newsTableView.delegate=self;
        [newsTableView setCurrController:self.currController];
        newsTableView.shaixuan = self.shaixuan;
        newsTableView.m_array = [zixunleibieused objectAtIndex:page];
        //        [newsTableView informationrequest];
        [newsTableView ViewFrashData];
        [newsTableView release];
        
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (nil == controller.superview) {
        CGRect frame = self.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.frame = frame;
        [self addSubview:controller];
    }
}

-(void)NewsTableViewBtnPressed:(NSArray *)dic
{
    [t_delegate NewsTableViewBtnPressed:dic];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==2) {
        if (pageControlUsed) {
            return;
        }
        
        CGFloat pageWidth = self.frame.size.width;
        int page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage = page;
        
        [self loadScrollViewWithPage:page - 1];
        [self loadScrollViewWithPage:page];
        [self loadScrollViewWithPage:page + 1];
    }
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag==2) {
        pageControlUsed = NO;
        
        NSLog(@"%f",navigationScrollView.contentOffset.x);
        NSLog(@"%f",scrollView.contentOffset.x/applicationwidth);
        
        NSInteger  page = scrollView.contentOffset.x/applicationwidth;
        [self.navigationScrollView changeNaviItem:page];
        
        if ((scrollView.contentOffset.x/applicationwidth-4)*64>navigationScrollView.contentOffset.x) {
            CGRect frame = navigationScrollView.frame;
            frame.origin.x = (scrollView.contentOffset.x/applicationwidth-4)*64+60.f;
            frame.origin.y = 0;
            [navigationScrollView scrollRectToVisible:frame animated:YES];
        }
        else if ((scrollView.contentOffset.x/applicationwidth)*64<navigationScrollView.contentOffset.x)
        {
            CGRect frame = navigationScrollView.frame;
            frame.origin.x = (scrollView.contentOffset.x/applicationwidth)*64;
            frame.origin.y = 0;
            [navigationScrollView scrollRectToVisible:frame animated:YES];
        }
    }
}

- (void)changePage:(id)sender {
    int page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = self.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

-(void)ButtonListDidSelectWithItem:(NSNumber*)index
{
    NSInteger  page = [index integerValue];
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
//    CGRect frame = self.frame;
//    frame.origin.x = frame.size.width * page;
//    frame.origin.y = 0;
//    [self scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

@end
