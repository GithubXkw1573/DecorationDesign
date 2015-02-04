//
//  BannerTableCell.m
//  TGQ2
//
//  Created by 许开伟 on 14-8-25.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "BannerTableCell.h"
#import "ImageLooker.h"
#import "UIImageView+WebCache.h"
#import "AdvertisingController.h"

@implementation BannerTableCell
@synthesize m_dictionary,guanggaoArray,imagescrollView,pageControl,viewControllers,plateType,plateCode;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self initComponent];
    }
    return self;
}

-(void)loadContent
{
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"PLATE-COLUMN-AD",@"JUDGEMETHOD",self.plateType,@"PLATETYPE",self.plateCode,@"PLATECODE", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            NSArray *list = [result objectForKey:@"PLATEADLISTINFO"];
            self.guanggaoArray = [[[NSMutableArray alloc] initWithArray:list] autorelease];
            [self reloadComponent];
        }else {
            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
            NSLog(@"%@",errrDesc);
        }
    }];
    [request setFailedBlock:^{
        NSLog(@"网络错误");
    }];
    [request startRequest];
}

-(void)initComponent
{
    kNumberOfPages = 0;
    UIImageView *mypageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160*widthRate)];
    mypageview.image=[UIImage imageNamed:@"首页切换图1.png"];
    [self.contentView addSubview:mypageview];
    [mypageview release];
    
    UIScrollView *guanggaoscrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 160*widthRate)];
    guanggaoscrollView.backgroundColor=[UIColor clearColor];
    guanggaoscrollView.tag=1;
    self.imagescrollView=guanggaoscrollView;
    [self.contentView addSubview:guanggaoscrollView];
    [guanggaoscrollView release];
    
    guanggaoscrollView.bounces=NO;
    guanggaoscrollView.pagingEnabled = YES;
    guanggaoscrollView.showsHorizontalScrollIndicator = NO;
    guanggaoscrollView.showsVerticalScrollIndicator = NO;
    guanggaoscrollView.scrollsToTop = NO;
    guanggaoscrollView.delegate = self;
    //新建一个定时器
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changePic) userInfo:nil repeats:YES];
    
    UIPageControl *pageCon=[[UIPageControl alloc]initWithFrame:CGRectMake(135*widthRate, 140, 50, 20)];
    pageCon.backgroundColor = [UIColor clearColor];
    pageCon.currentPageIndicatorTintColor = [UIColor redColor];
    pageCon.pageIndicatorTintColor = [UIColor colorWithRed:150/255.f green:152/255.f blue:155/255.f alpha:1.f];
    pageCon.alpha=0.6;
    [pageCon addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    self.pageControl=pageCon;
    [self.contentView addSubview:pageCon];
    [pageCon release];
}

-(void)reloadComponent
{
    kNumberOfPages=[guanggaoArray count];
    
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

    imagescrollView.contentSize = CGSizeMake(imagescrollView.frame.size.width * kNumberOfPages, imagescrollView.frame.size.height);
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    
    if (kNumberOfPages>=2) {
        [imagescrollView scrollRectToVisible:CGRectMake(0, 0, applicationwidth, imagescrollView.frame.size.height) animated:YES];
        [self loadScrollViewWithPage:0];
        [self loadScrollViewWithPage:1];
    }
    else if(kNumberOfPages==1){
        [imagescrollView scrollRectToVisible:CGRectMake(0, 0, applicationwidth, imagescrollView.frame.size.height) animated:YES];
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
        
        UIImageView *mypageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160*widthRate)];
        mypageview.tag = 33;
        mypageview.userInteractionEnabled = YES;
        [mypageview setImageWithURL:[NSURL URLWithString:[[guanggaoArray objectAtIndex:page2] objectAtIndex:1]] placeholderImage:[UIImage imageNamed:@"首页切换图1.png"]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [mypageview addGestureRecognizer:tap];
        [tap release];
        [controller addSubview:mypageview];
        [mypageview release];
        
        [viewControllers replaceObjectAtIndex:page2 withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (nil == controller.superview) {
        CGRect frame = imagescrollView.frame;
        frame.origin.x = frame.size.width * page2;
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
        int page2 = floor((imagescrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage = page2;
        
        [self loadScrollViewWithPage:page2 - 1];
        [self loadScrollViewWithPage:page2];
        [self loadScrollViewWithPage:page2 + 1];
    }
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (void)changePage:(id)sender {
    NSInteger page2 = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page2 - 1];
    [self loadScrollViewWithPage:page2];
    [self loadScrollViewWithPage:page2 + 1];
    // update the scroll view to the appropriate page
    CGRect frame = imagescrollView.frame;
    frame.origin.x = frame.size.width * page2;
    frame.origin.y = 0;
    [imagescrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setCell:(NSDictionary *)dic row:(int)row
{
    self.m_dictionary = dic;
    UIImageView *imageView =(UIImageView*)[self.contentView viewWithTag:301];
    UILabel *nameLabel = (UILabel*)[self.contentView viewWithTag:302];
    UILabel *remarkLabel = (UILabel*)[self.contentView viewWithTag:303];
    UILabel *dateLabel = (UILabel*)[self.contentView viewWithTag:304];
    UILabel *distanceLabel = (UILabel*)[self.contentView viewWithTag:305];
    nameLabel.adjustsFontSizeToFitWidth = NO;
    [imageView setImageWithURL:[NSURL URLWithString:[PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"imgPath"]] placeholderImage:[UIImage imageNamed:@"默认活动图"]];
    nameLabel.text = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"name"];
    remarkLabel.text = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"remark"];
    dateLabel.text = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"endTime"];
    //NSString *distance = [NSString stringWithFormat:@"%.2f",[[PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"metre"] floatValue]/1000];
    NSString *distance = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"metre"];
    distanceLabel.text = [NSString stringWithFormat:@"%@",distance];
}

-(void)tapClick:(UITapGestureRecognizer*)tap
{
    if (tap.view.tag == 33) {
        AdvertisingController *adver = [[AdvertisingController alloc] init];
        adver.hidesBottomBarWhenPushed = YES;
        adver.plateCode = self.plateCode;
        adver.plateType = self.plateType;
        adver.pageMark = [NSString stringWithFormat:@"%li",self.pageControl.currentPage];
        [self.currController.navigationController pushViewController:adver animated:YES];
        [adver release];
    }
}

-(void)changePic
{
    kCurrentPage ++;
    if (kCurrentPage>guanggaoArray.count-1) {
        kCurrentPage=0;
    }
    [self loadScrollViewWithPage:kCurrentPage - 1];
    [self loadScrollViewWithPage:kCurrentPage];
    [self loadScrollViewWithPage:kCurrentPage + 1];
    CGRect frame = imagescrollView.frame;
    frame.origin.x = frame.size.width * kCurrentPage;
    frame.origin.y = 0;
    [imagescrollView scrollRectToVisible:frame animated:YES];
}

@end
