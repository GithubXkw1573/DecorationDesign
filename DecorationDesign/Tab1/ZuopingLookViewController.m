//
//  ZuopingLookViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "ZuopingLookViewController.h"

@interface ZuopingLookViewController ()

@end

@implementation ZuopingLookViewController
@synthesize zuopingList,viewControllers,imagescrollView,pageControl,myscrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNaviWithTitle:@"作品浏览"];
    
    [self initComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)initNaviWithTitle:(NSString*)title
{
    if (iOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.zuopingList = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"标题栏%i.png",[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?7:6]] forBarMetrics:UIBarMetricsDefault];
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80*widthRate, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=title;
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-10, 0, 60, 44);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(ZuopingLookControllerBackBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
}

-(void)ZuopingLookControllerBackBtnPressed:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initComponents
{
    //整体的scrollview
    UIScrollView *guanggaoscrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, applicationwidth, applicationheight-49-44)];
    guanggaoscrollView.backgroundColor=[UIColor clearColor];
    guanggaoscrollView.tag=11;
    self.myscrollView=guanggaoscrollView;
    [self.view addSubview:guanggaoscrollView];
    [guanggaoscrollView release];
    guanggaoscrollView.bounces=NO;
    guanggaoscrollView.pagingEnabled = YES;
    guanggaoscrollView.showsHorizontalScrollIndicator = NO;
    guanggaoscrollView.showsVerticalScrollIndicator = NO;
    guanggaoscrollView.scrollsToTop = NO;
    guanggaoscrollView.delegate = self;
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"家装样图1",@"imagename",@"高端大气，舒适，温馨",@"desc",@"许开伟",@"author", nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"首页切换图1",@"imagename",@"低调奢华，有内涵",@"desc",@"周星星",@"author", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"首页切换图2",@"imagename",@"活泼乱动，真可爱",@"desc",@"余文乐",@"author", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"首页切换图3",@"imagename",@"简约委婉，小清新",@"desc",@"陈奕迅",@"author", nil];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"首页切换图4",@"imagename",@"霸气侧漏，小清新",@"desc",@"斯琴高娃",@"author", nil];
    self.zuopingList = [NSMutableArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5, nil];
    kNumberOfPages=[zuopingList count];
    
    UIPageControl *pageCon=[[UIPageControl alloc]initWithFrame:CGRectMake(130, 300, 60, 20)];
    pageCon.backgroundColor = [UIColor clearColor];
    pageCon.currentPageIndicatorTintColor = [UIColor redColor];
    pageCon.pageIndicatorTintColor = [UIColor grayColor];
    pageCon.alpha=0.5;
    [pageCon addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    self.pageControl=pageCon;
    [self.view addSubview:pageCon];
    [pageCon release];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
    
    for (int i=0; i<[viewControllers count]; i++) {
        UIView *controller = [viewControllers objectAtIndex:i];
        if ((NSNull *)controller == [NSNull null]) {
            
        }
        else
        {
            [controller removeFromSuperview];
            controller=nil;
        }
    }
    
    myscrollView.contentSize = CGSizeMake(myscrollView.frame.size.width * kNumberOfPages, myscrollView.frame.size.height);
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(10, applicationheight-44-49-50, 200, 30)];
    desc.text = @"温暖舒适，给你家的感觉.";
    desc.backgroundColor = [UIColor clearColor];
    desc.textColor = [UIColor blackColor];
    desc.font = font(13);
    descLabel = desc;
    [self.view addSubview:desc];
    [desc release];
    
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(210, applicationheight-44-49-50, 100, 30)];
    author.text = @"许开伟";
    author.backgroundColor = [UIColor clearColor];
    author.textColor = [UIColor blackColor];
    author.font = font(14);
    authorLabel = author;
    [self.view addSubview:author];
    [author release];
    
    if (kNumberOfPages>=2) {
        [myscrollView scrollRectToVisible:CGRectMake(0, 0, myscrollView.frame.size.width, myscrollView.frame.size.height) animated:YES];
        [self loadScrollViewWithPage:0];
        [self loadScrollViewWithPage:1];
    }
    else if(kNumberOfPages==1){
        [myscrollView scrollRectToVisible:CGRectMake(0, 0, myscrollView.frame.size.width, myscrollView.frame.size.height) animated:YES];
        [self loadScrollViewWithPage:0];
    }
    
    
}

- (void)loadScrollViewWithPage:(NSInteger)page2 {
    if (page2 < 0) return;
    if (page2 >= kNumberOfPages) return;
    
    // replace the placeholder if necessary
    UIView *controller = [viewControllers objectAtIndex:page2];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[UIView alloc] init];
//        ImageLooker *looker = [[ImageLooker alloc] initWithFrame:CGRectMake(0, 0, myscrollView.frame.size.width, 160*widthRate) withImage:[UIImage imageNamed:[[zuopingList objectAtIndex:page2] objectForKey:@"imagename"]]];
        
        //[mypageview setImageWithURL:[NSURL URLWithString:[[guanggaoArray objectAtIndex:page2] objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"默认大.png"]];
        
        UIButton *mypageview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, myscrollView.frame.size.width, 160*widthRate)];
        NSLog(@"image:%@",[[zuopingList objectAtIndex:page2] objectForKey:@"imagename"]);
        [mypageview setImage:[UIImage imageNamed:[[zuopingList objectAtIndex:page2] objectForKey:@"imagename"]] forState:UIControlStateNormal];
        [mypageview addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [controller addSubview:mypageview];
        [mypageview release];
        
        
        
        [viewControllers replaceObjectAtIndex:page2 withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (nil == controller.superview) {
        CGRect frame = myscrollView.frame;
        frame.origin.x = frame.size.width * page2;
        frame.origin.y = 0;
        controller.frame = frame;
        [myscrollView addSubview:controller];
    }
    
    descLabel.text = [[zuopingList objectAtIndex:page2] objectForKey:@"desc"];
    authorLabel.text = [NSString stringWithFormat:@"--%@",[[zuopingList objectAtIndex:page2] objectForKey:@"author"]];
}

- (void)changePage:(id)sender {
    NSInteger page2 = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page2 - 1];
    [self loadScrollViewWithPage:page2];
    [self loadScrollViewWithPage:page2 + 1];
    // update the scroll view to the appropriate page
    CGRect frame = myscrollView.frame;
    frame.origin.x = frame.size.width * page2;
    frame.origin.y = 0;
    [myscrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==11) {
        if (pageControlUsed) {
            return;
        }
        
        CGFloat pageWidth = myscrollView.frame.size.width;
        int page2 = floor((myscrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage = page2;
        
        [self loadScrollViewWithPage:page2 - 1];
        [self loadScrollViewWithPage:page2];
        [self loadScrollViewWithPage:page2 + 1];
        
        
    }
}

-(void)buttonClicked:(UIButton*)btn
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    ImageLooker *looker = [[ImageLooker alloc] initWithFrame:window.frame withImage:[UIImage imageNamed:[[zuopingList objectAtIndex:pageControl.currentPage] objectForKey:@"imagename"]]];
    [window addSubview:looker];
    looker.backgroundColor = [UIColor blackColor];
    looker.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.35f animations:^{
        looker.transform = CGAffineTransformMakeScale(1, 1);
    }];
    [looker release];
}

@end
