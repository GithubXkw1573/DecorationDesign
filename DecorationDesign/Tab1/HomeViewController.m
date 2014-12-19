//
//  HomeViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/17.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize imagescrollView,pageControl,guanggaoArray,viewControllers,designerArray,designerscrollView,homeMBProgress;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initComponents];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)initNaviWithTitle:(NSString*)title
{
    if (iOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"标题栏%i.png",[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?7:6]] forBarMetrics:UIBarMetricsDefault];
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80*widthRate, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=title;
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    //搜索按钮
    UIView *rightbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 60, 44);
    rightbtn.tag = 2;
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"导航搜索.png"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightbtnview addSubview:rightbtn];
    
    UIBarButtonItem *myrightitem = [[UIBarButtonItem alloc] initWithCustomView:rightbtnview];
    self.navigationItem.rightBarButtonItem = myrightitem;
    [myrightitem release];
    [rightbtnview release];
}

-(void)initComponents
{
    self.view.backgroundColor=[UIColor colorWithRed:35/255.f green:11/255.f blue:114/255.f alpha:1.0f];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"家装样图1",@"imagename",@"高端大气，舒适，温馨",@"desc",@"许开伟",@"author", nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"首页切换图1",@"imagename",@"低调奢华，有内涵",@"desc",@"周星星",@"author", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"首页切换图2",@"imagename",@"活泼乱动，真可爱",@"desc",@"余文乐",@"author", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"首页切换图3",@"imagename",@"简约委婉，小清新",@"desc",@"陈奕迅",@"author", nil];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"首页切换图4",@"imagename",@"霸气侧漏，小清新",@"desc",@"斯琴高娃",@"author", nil];
    self.guanggaoArray = [NSMutableArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5, nil];
    kNumberOfPages=[guanggaoArray count];
    self.designerArray = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"周新星",@"name",@"设计师头像1",@"image",@"1202",@"id", nil];
        [self.designerArray addObject:dic];
    }
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, applicationheight-29) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor clearColor];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
    
    
    
    MBProgressHUD *mbprogress = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    mbprogress.tag = 5666;
    self.homeMBProgress = mbprogress;
    [mbprogress setCenter:CGPointMake(applicationwidth/2.0, applicationheight/2)];
    [[UIApplication sharedApplication].keyWindow addSubview:mbprogress];
    [mbprogress hide:YES];
    [mbprogress setLabelText:@"加载中"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row=[indexPath row];
    
    if (row==0) {
        static NSString *CellIdentifier = @"Cell0";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *mypageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 80*widthRate)];
            mypageview.image=[UIImage imageNamed:@"首页横幅1.png"];
            [cell.contentView addSubview:mypageview];
            [mypageview release];
            
            UIScrollView *guanggaoscrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 80*widthRate)];
            guanggaoscrollView.backgroundColor=[UIColor clearColor];
            guanggaoscrollView.tag=1;
            self.imagescrollView=guanggaoscrollView;
            [cell.contentView addSubview:guanggaoscrollView];
            [guanggaoscrollView release];
            
            guanggaoscrollView.bounces=NO;
            guanggaoscrollView.pagingEnabled = YES;
            guanggaoscrollView.showsHorizontalScrollIndicator = NO;
            guanggaoscrollView.showsVerticalScrollIndicator = NO;
            guanggaoscrollView.scrollsToTop = NO;
            guanggaoscrollView.delegate = self;
            
            //新建一个定时器
            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changePic) userInfo:nil repeats:YES];
            
            
            UIPageControl *pageCon=[[UIPageControl alloc]initWithFrame:CGRectMake(135*widthRate, 60, 50, 20)];
            pageCon.backgroundColor = [UIColor clearColor];
            pageCon.currentPageIndicatorTintColor = [UIColor redColor];
            pageCon.pageIndicatorTintColor = [UIColor colorWithRed:150/255.f green:152/255.f blue:155/255.f alpha:1.f];
            pageCon.alpha=0.6;
            [pageCon addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
            self.pageControl=pageCon;
            [cell.contentView addSubview:pageCon];
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
        
        return cell;
    }
    else if(row==1)
    {
        static NSString *CellIdentifier = @"Cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            
            UIButton *guanggaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(9*widthRate, 10*widthRate, 135*widthRate, 132.5*widthRate)];
            guanggaoBtn.backgroundColor = [UIColor clearColor];
            [guanggaoBtn setImage:[UIImage imageNamed:@"suning"] forState:UIControlStateNormal];
            guanggaoBtn.tag = 11;
            [guanggaoBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:guanggaoBtn];
            [guanggaoBtn release];
            
            UIButton *shejishibtn = [[UIButton alloc] initWithFrame:CGRectMake(149*widthRate, 10*widthRate, 162*widthRate, 132.5*widthRate)];
            shejishibtn.backgroundColor = [UIColor clearColor];
            [shejishibtn setImage:[UIImage imageNamed:@"shejishi"] forState:UIControlStateNormal];
            shejishibtn.tag = 12;
            [shejishibtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:shejishibtn];
            [shejishibtn release];
            
            
        }
        
        return cell;
    }
    else if(row==2)
    {
        static NSString *CellIdentifier = @"Cell2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            UIButton *loupanBtn = [[UIButton alloc] initWithFrame:CGRectMake(9*widthRate, 5*widthRate, 135*widthRate, 132.5*widthRate)];
            loupanBtn.backgroundColor = [UIColor clearColor];
            [loupanBtn setImage:[UIImage imageNamed:@"loupan"] forState:UIControlStateNormal];
            loupanBtn.tag = 13;
            [loupanBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:loupanBtn];
            [loupanBtn release];
            
            UIButton *baomingBtn = [[UIButton alloc] initWithFrame:CGRectMake(149*widthRate, 5*widthRate, 79*widthRate, 62*widthRate)];
            baomingBtn.backgroundColor = [UIColor clearColor];
            [baomingBtn setImage:[UIImage imageNamed:@"baoming"] forState:UIControlStateNormal];
            baomingBtn.tag = 14;
            [baomingBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:baomingBtn];
            [baomingBtn release];
            
            UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(232*widthRate, 5*widthRate, 79*widthRate, 62*widthRate)];
            searchBtn.backgroundColor = [UIColor clearColor];
            [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
            searchBtn.tag = 15;
            [searchBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:searchBtn];
            [searchBtn release];
            
            UIButton *jiajuBtn = [[UIButton alloc] initWithFrame:CGRectMake(149*widthRate, 72*widthRate, 164*widthRate, 65.5*widthRate)];
            jiajuBtn.backgroundColor = [UIColor clearColor];
            [jiajuBtn setImage:[UIImage imageNamed:@"hongxing"] forState:UIControlStateNormal];
            jiajuBtn.tag = 16;
            [jiajuBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:jiajuBtn];
            [jiajuBtn release];
            
            
        }
        
        return cell;
    }
    else if(row ==3)
    {
        static NSString *CellIdentifier = @"Cell3";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            UIButton *cailiaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(9*widthRate, 5*widthRate, 135*widthRate, 120*widthRate)];
            cailiaoBtn.backgroundColor = [UIColor clearColor];
            [cailiaoBtn setImage:[UIImage imageNamed:@"caiiao"] forState:UIControlStateNormal];
            cailiaoBtn.tag = 17;
            [cailiaoBtn addTarget:self action:@selector(buttonClicked2:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:cailiaoBtn];
            [cailiaoBtn release];
            
            UIButton *gongsiBtn = [[UIButton alloc] initWithFrame:CGRectMake(149*widthRate, 5*widthRate, 162*widthRate, 120*widthRate)];
            gongsiBtn.backgroundColor = [UIColor clearColor];
            [gongsiBtn setImage:[UIImage imageNamed:@"jiazhuang"] forState:UIControlStateNormal];
            gongsiBtn.tag = 18;
            [gongsiBtn addTarget:self action:@selector(buttonClicked4:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:gongsiBtn];
            [gongsiBtn release];
            
        }
        
        return cell;
    }
    
    return nil;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row=[indexPath row];
    switch (row) {
        case 0:
            return 80*widthRate;
            break;
        case 1:
            return 142.5*widthRate;
            break;
        case 2:
            return 137.5*widthRate;
            break;
        case 3:
            return 135*widthRate;
            break;
        default:
            break;
    }
    return 0;
}

- (void)loadScrollViewWithPage:(int)page2 {
    if (page2 < 0) return;
    if (page2 >= kNumberOfPages) return;
    
    // replace the placeholder if necessary
    UIView *controller = [viewControllers objectAtIndex:page2];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[UIView alloc] init];
        
        UIButton *mypageview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160*widthRate)];
        NSLog(@"image:%@",[[guanggaoArray objectAtIndex:page2] objectForKey:@"imagename"]);
        [mypageview setImage:[UIImage imageNamed:[[guanggaoArray objectAtIndex:page2] objectForKey:@"imagename"]] forState:UIControlStateNormal];
        mypageview.tag = 33;
        [mypageview addTarget:self action:@selector(buttonClicked3:) forControlEvents:UIControlEventTouchUpInside];
        //[mypageview setImageWithURL:[NSURL URLWithString:[[guanggaoArray objectAtIndex:page2] objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"默认大.png"]];
        [controller addSubview:mypageview];
        [mypageview release];
        
        UIImageView *zhezhaoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, applicationwidth, 30)];
        zhezhaoView.image = [UIImage imageNamed:@"黑色半透明"];
        zhezhaoView.backgroundColor = [UIColor clearColor];
        [controller addSubview:zhezhaoView];
        [zhezhaoView release];
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0.4*applicationwidth, 30)];
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.text = [[guanggaoArray objectAtIndex:page2] objectForKey:@"desc"];
        descLabel.font = font(12);
        descLabel.textColor = [UIColor whiteColor];
        [zhezhaoView addSubview:descLabel];
        [descLabel release];
        
        UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.4*applicationwidth+10, 0, 0.3*applicationwidth, 30)];
        authorLabel.backgroundColor = [UIColor clearColor];
        authorLabel.text = [NSString stringWithFormat:@"--%@",[[guanggaoArray objectAtIndex:page2] objectForKey:@"author"]];
        authorLabel.font = font(12);
        authorLabel.textAlignment = UITextAlignmentCenter;
        authorLabel.textColor = [UIColor whiteColor];
        [zhezhaoView addSubview:authorLabel];
        [authorLabel release];
        
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

-(void)loadDesigners
{
    
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

-(void)changePic
{
    currPage ++;
    if (currPage>guanggaoArray.count-1) {
        currPage=0;
    }
    [self loadScrollViewWithPage:currPage - 1];
    [self loadScrollViewWithPage:currPage];
    [self loadScrollViewWithPage:currPage + 1];
    CGRect frame = imagescrollView.frame;
    frame.origin.x = frame.size.width * currPage;
    frame.origin.y = 0;
    [imagescrollView scrollRectToVisible:frame animated:YES];
}

- (void)changePage:(id)sender {
    int page2 = pageControl.currentPage;
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

-(void)buttonClicked3:(UIButton*)btn
{
    //图片浏览点击事件
//    ZuopingLookViewController *zuopingLookViewController = [[ZuopingLookViewController alloc] init];
//    [self.navigationController pushViewController:zuopingLookViewController animated:YES];
//    [ZuopingLookViewController release];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    ImageLooker *looker = [[ImageLooker alloc] initWithFrame:window.frame withImage:[UIImage imageNamed:[[guanggaoArray objectAtIndex:pageControl.currentPage] objectForKey:@"imagename"]]];
    [window addSubview:looker];
    looker.backgroundColor = [UIColor blackColor];
    
    looker.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.35f animations:^{
        looker.transform = CGAffineTransformMakeScale(1, 1);
    }];
    [looker release];
}

-(void)buttonClicked2:(UIButton*)btn
{
    [self.homeMBProgress show:YES];
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //装修材料
        FaxianViewController *faxian = [[FaxianViewController alloc] init];
        faxian.contentType = 3;
        [UserInfo shared].m_plateType = @"C";
        [self.navigationController pushViewController:faxian animated:YES];
        [faxian release];
    });
}
-(void)buttonClicked4:(UIButton*)btn
{
    //家装公司
    [self.homeMBProgress show:YES];
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //家装公司
        FaxianViewController *faxian = [[FaxianViewController alloc] init];
        faxian.contentType = 4;
        [UserInfo shared].m_plateType = @"J";
        [self.navigationController pushViewController:faxian animated:YES];
        [faxian release];
    });
}

-(void)buttonClicked:(UIButton*)btn
{
    switch (btn.tag) {
        case 2:
        {
            //搜索
            FaxianViewController *faxian = [[FaxianViewController alloc] init];
            [self.navigationController pushViewController:faxian animated:YES];
            [faxian release];
        }
            break;
        case 11:
        {
            //广告
//            FaxianViewController *faxian = [[FaxianViewController alloc] init];
//            faxian.contentType = 1;
//            [self.navigationController pushViewController:faxian animated:YES];
//            [faxian release];
        }
            break;
        case 12:
        {
            [self.homeMBProgress show:YES];
            double delayInSeconds = 0.1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //设计师
                FaxianViewController *faxian = [[FaxianViewController alloc] init];
                faxian.contentType = 1;
                [UserInfo shared].m_plateType = @"S";
                [self.navigationController pushViewController:faxian animated:YES];
                [faxian release];
            });
        }
            break;
        case 13:
        {
            [self.homeMBProgress show:YES];
            double delayInSeconds = 0.1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //我家楼盘
                FaxianViewController *faxian = [[FaxianViewController alloc] init];
                faxian.contentType = 2;
                [UserInfo shared].m_plateType = @"L";
                [self.navigationController pushViewController:faxian animated:YES];
                [faxian release];
            });
            
        }
            break;
        case 14:
        {
            
            //报名
//            FaxianViewController *faxian = [[FaxianViewController alloc] init];
//            faxian.contentType = 2;
//            [self.navigationController pushViewController:faxian animated:YES];
//            [faxian release];
        }
            break;
        case 15:
        {
            
            //搜索
//            FaxianViewController *faxian = [[FaxianViewController alloc] init];
//            faxian.contentType = 2;
//            [self.navigationController pushViewController:faxian animated:YES];
//            [faxian release];
        }
            break;
        case 16:
        {
            //红星家具
//            FaxianViewController *faxian = [[FaxianViewController alloc] init];
//            faxian.contentType = 2;
//            [self.navigationController pushViewController:faxian animated:YES];
//            [faxian release];
        }
            break;
        case 17:
        {
            [self.homeMBProgress show:YES];
            double delayInSeconds = 0.1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //装修材料
                FaxianViewController *faxian = [[FaxianViewController alloc] init];
                faxian.contentType = 3;
                [UserInfo shared].m_plateType = @"C";
                [self.navigationController pushViewController:faxian animated:YES];
                [faxian release];
            });
            
        }
            break;
        case 18:
        {
            [self.homeMBProgress show:YES];
            double delayInSeconds = 0.1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //家装公司
                FaxianViewController *faxian = [[FaxianViewController alloc] init];
                faxian.contentType = 4;
                [UserInfo shared].m_plateType = @"J";
                [self.navigationController pushViewController:faxian animated:YES];
                [faxian release];
            });
            
        }
            break;
        case 33:
        {
            
        }
            break;
        case 70:
        {
            //设计师个人详情界面
            DesignerViewController *designerViewController = [[DesignerViewController alloc] init];
            [self.navigationController pushViewController:designerViewController animated:YES];
            [designerViewController release];
        }
            break;
        
    }
}

@end
