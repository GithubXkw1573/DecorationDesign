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
@synthesize imagescrollView,pageControl,guanggaoArray,viewControllers,designerArray,designerscrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNaviWithTitle:@"设计圈"];
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
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, applicationheight-49-44) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0f];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
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
            
            UIImageView *backimage=[[UIImageView alloc]init];
            backimage.backgroundColor=[UIColor whiteColor];
            cell.backgroundView=backimage;
            [backimage release];
            
            UIImageView *mypageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160*widthRate)];
            mypageview.image=[UIImage imageNamed:@"模块大.png"];
            [cell.contentView addSubview:mypageview];
            [mypageview release];
            
            UIScrollView *guanggaoscrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 160*widthRate)];
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
            
            UIPageControl *pageCon=[[UIPageControl alloc]initWithFrame:CGRectMake(265*widthRate, 135, 50, 20)];
            pageCon.backgroundColor = [UIColor clearColor];
            pageCon.currentPageIndicatorTintColor = [UIColor redColor];
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
            
//            UIImageView *backimage=[[UIImageView alloc]init];
//            backimage.backgroundColor=[UIColor clearColor];
//            cell.backgroundView=backimage;
//            [backimage release];
            
            cell.backgroundColor = [UIColor clearColor];
            
            
            PicTextButton *shejishibtn = [[PicTextButton alloc] initWithFrame:CGRectMake(9*widthRate, 7*widthRate, 70*widthRate, 75*widthRate) withIamge:@"shejishi" withText:@"设计师"];
            shejishibtn.tag = 11;
            [shejishibtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:shejishibtn];
            [shejishibtn release];
            
            PicTextButton *jiazhuanggongsibtn = [[PicTextButton alloc] initWithFrame:CGRectMake(86*widthRate, 7*widthRate, 70*widthRate, 75*widthRate) withIamge:@"jiazhuang" withText:@"家装公司"];
            jiazhuanggongsibtn.tag = 12;
            [jiazhuanggongsibtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:jiazhuanggongsibtn];
            [jiazhuanggongsibtn release];
            
            PicTextButton *zhushicailiaobtn = [[PicTextButton alloc] initWithFrame:CGRectMake(163*widthRate, 7*widthRate, 70*widthRate, 75*widthRate) withIamge:@"cailiao" withText:@"装饰材料"];
            zhushicailiaobtn.tag = 13;
            [zhushicailiaobtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:zhushicailiaobtn];
            [zhushicailiaobtn release];
            
            PicTextButton *loupanbtn = [[PicTextButton alloc] initWithFrame:CGRectMake(240*widthRate, 7*widthRate, 70*widthRate, 75*widthRate) withIamge:@"loupan" withText:@"我家楼盘"];
            loupanbtn.tag = 14;
            [loupanbtn addTarget:self action:@selector(buttonClicked2:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:loupanbtn];
            [loupanbtn release];
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
            
            UIImageView *backimage=[[UIImageView alloc]init];
            backimage.backgroundColor=[UIColor whiteColor];
            cell.backgroundView=backimage;
            [backimage release];
            
            
            
            UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 150*widthRate, 30)];
            titlelabel.text = @"知名设计师推荐";
            titlelabel.font=font(16);
            titlelabel.textAlignment=UITextAlignmentLeft;
            titlelabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:titlelabel];
            [titlelabel release];
            
            UILabel *numLabel=[[UILabel alloc]initWithFrame:CGRectMake(applicationwidth-120, 10, 70, 30)];
            numLabel.tag = 15;
            numLabel.text = @"123456";
            numLabel.textColor = [UIColor redColor];
            numLabel.font=font(12);
            numLabel.textAlignment=UITextAlignmentRight;
            numLabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:numLabel];
            [numLabel release];
            
            UILabel *gudinglabel=[[UILabel alloc]initWithFrame:CGRectMake(applicationwidth-50, 10, 50, 30)];
            gudinglabel.text = @" 人在线";
            gudinglabel.textColor = [UIColor lightGrayColor];
            gudinglabel.font=font(12);
            gudinglabel.textAlignment=UITextAlignmentLeft;
            gudinglabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:gudinglabel];
            [gudinglabel release];
        }
        
        UILabel *numlabel =(UILabel *)[cell.contentView viewWithTag:15];
        
        numlabel.text = @"123456";
        
        return cell;
    }
    else if(row ==3)
    {
        static NSString *CellIdentifier = @"Cell3";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor=[UIColor whiteColor];
            UIButton *firstBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, applicationwidth-10, 105*widthRate)];
            firstBtn.tag = 70;
            firstBtn.backgroundColor = [UIColor clearColor];
            [firstBtn setImage:[UIImage imageNamed:@"设计师首页大图"] forState:UIControlStateNormal];
            [firstBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:firstBtn];
            [firstBtn release];
            
        }
        
        return cell;
    }
    else if(row ==4)
    {
        static NSString *CellIdentifier = @"Cell4";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor=[UIColor whiteColor];
            
            UIButton *preBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 10, 24, 30)];
            preBtn.backgroundColor = [UIColor clearColor];
            [preBtn setImage:[UIImage imageNamed:@"小箭头"] forState:UIControlStateNormal];
            preBtn.transform = CGAffineTransformMakeRotation(M_PI);
            [preBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            preBtn.tag = 61;
            [cell.contentView addSubview:preBtn];
            [preBtn release];
            
            UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(applicationwidth-8-24, 10, 24, 30)];
            nextBtn.backgroundColor = [UIColor clearColor];
            [nextBtn setImage:[UIImage imageNamed:@"小箭头"] forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            nextBtn.tag = 62;
            [cell.contentView addSubview:nextBtn];
            [nextBtn release];
            
            UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(32, 0, applicationwidth-64, 50*widthRate)];
            scrollView.backgroundColor=[UIColor clearColor];
            scrollView.tag=2;
            self.designerscrollView=scrollView;
            [cell.contentView addSubview:scrollView];
            [scrollView release];
            
            scrollView.bounces=NO;
            scrollView.pagingEnabled = YES;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.scrollsToTop = NO;
            scrollView.delegate = self;
            
            self.designerscrollView.contentSize = CGSizeMake(50*widthRate * designerArray.count, designerscrollView.frame.size.height);
            
            for(UIView *v in self.designerscrollView.subviews)
                [v removeFromSuperview];
            for (int i=0; i<self.designerArray.count; i++) {
                NSString *imageName = [[designerArray objectAtIndex:i] objectForKey:@"image"];
                UIButton *imagebtn = [[UIButton alloc] initWithFrame:CGRectMake(5+50*i, 5, 40, 40)];
                [imagebtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                imagebtn.layer.cornerRadius = imagebtn.frame.size.width/2.0f;
                imagebtn.layer.masksToBounds = YES;
                imagebtn.tag = 100+i;
                [imagebtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.designerscrollView addSubview:imagebtn];
                [imagebtn release];
            }
            
        }
        
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor=[UIColor clearColor];
            
            UIView *mybackView = [[UIView alloc] initWithFrame:CGRectMake(0, 7*widthRate, applicationwidth, 135*widthRate)];
            mybackView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:mybackView];
            [mybackView release];
            
            UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5*widthRate, 150*widthRate, 30*widthRate)];
            titlelabel.text = @"著名家装公司";
            titlelabel.font=font(16);
            titlelabel.tag = 50;
            titlelabel.textAlignment=UITextAlignmentLeft;
            titlelabel.backgroundColor=[UIColor clearColor];
            [mybackView addSubview:titlelabel];
            [titlelabel release];
            
            UIImageView *leftimageview=[[UIImageView alloc]initWithFrame:CGRectMake(7*widthRate, 35*widthRate, 150*widthRate, 78*widthRate)];
            leftimageview.tag = 51;
            leftimageview.image=[UIImage imageNamed:@"家装公司小图"];
            [mybackView addSubview:leftimageview];
            [leftimageview release];
            UILabel *leftlabel=[[UILabel alloc]initWithFrame:CGRectMake(7*widthRate, 113*widthRate, 150*widthRate, 16*widthRate)];
            leftlabel.text = @"南京好利来设计公司";
            leftlabel.font=font(13);
            leftlabel.tag = 52;
            leftlabel.textAlignment=UITextAlignmentLeft;
            leftlabel.backgroundColor=[UIColor clearColor];
            [mybackView addSubview:leftlabel];
            [leftlabel release];
            
            UIImageView *rightimageview=[[UIImageView alloc]initWithFrame:CGRectMake(163*widthRate, 35*widthRate, 150*widthRate, 78*widthRate)];
            rightimageview.tag = 53;
            rightimageview.image=[UIImage imageNamed:@"家装公司小图2"];
            [mybackView addSubview:rightimageview];
            [rightimageview release];
            UILabel *rightlabel=[[UILabel alloc]initWithFrame:CGRectMake(163*widthRate, 113*widthRate, 150*widthRate, 16*widthRate)];
            rightlabel.tag = 54;
            rightlabel.text = @"南京艺术设计有限公司";
            rightlabel.font=font(13);
            rightlabel.textAlignment=UITextAlignmentLeft;
            rightlabel.backgroundColor=[UIColor clearColor];
            [mybackView addSubview:rightlabel];
            [rightlabel release];
        }
        UILabel *titleLabel = (UILabel*)[cell.contentView viewWithTag:50];
        UILabel *leftLabel = (UILabel*)[cell.contentView viewWithTag:52];
        UILabel *rightLabel = (UILabel*)[cell.contentView viewWithTag:54];
        UIImageView *leftImage = (UIImageView*)[cell.contentView viewWithTag:51];
        UIImageView *rightImage = (UIImageView*)[cell.contentView viewWithTag:53];
        if (row == 5) {
            titleLabel.text = @"著名家装公司";
        }else if (row==6){
            titleLabel.text = @"材料商";
        }else if (row==7){
            titleLabel.text = @"热门楼盘";
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
            return 160*widthRate;
            break;
        case 1:
            return 89*widthRate;
            break;
        case 2:
            return 40;
            break;
        case 3:
            return 105*widthRate;
            break;
        case 4:
            return 50*widthRate;
            break;
        case 5:
            return 142*widthRate;
            break;
        case 6:
            return 142*widthRate;
            break;
        case 7:
            return 142*widthRate;
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
    ZuopingLookViewController *zuopingLookViewController = [[ZuopingLookViewController alloc] init];
    [self.navigationController pushViewController:zuopingLookViewController animated:YES];
    [ZuopingLookViewController release];
}

-(void)buttonClicked2:(UIButton*)btn
{
    //我家楼盘
    FaxianViewController *faxian4 = [[FaxianViewController alloc] init];
    faxian4.contentType = 4;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self.navigationController pushViewController:faxian4 animated:YES];
    [faxian4 release];
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
            //设计师
            FaxianViewController *faxian = [[FaxianViewController alloc] init];
            faxian.contentType = 1;
            [self.navigationController pushViewController:faxian animated:YES];
            [faxian release];
        }
            break;
        case 12:
        {
            //装饰公司
            FaxianViewController *faxian = [[FaxianViewController alloc] init];
            faxian.contentType = 2;
            [self.navigationController pushViewController:faxian animated:YES];
            [faxian release];
        }
            break;
        case 13:
        {
            //装饰材料
            FaxianViewController *faxian = [[FaxianViewController alloc] init];
            faxian.contentType = 3;
            [self.navigationController pushViewController:faxian animated:YES];
            [faxian release];
        }
            break;
        case 14:
        {
            
        }
        case 33:
        {
            
        }
        case 70:
        {
            //设计师个人详情界面
            DesignerViewController *designerViewController = [[DesignerViewController alloc] init];
            [self.navigationController pushViewController:designerViewController animated:YES];
            [designerViewController release];
        }
            break;
        default:
        {
            //tag>=100
            int currIndex = btn.tag -100;
            DesignerViewController *designerViewController = [[DesignerViewController alloc] init];
            [self.navigationController pushViewController:designerViewController animated:YES];
            [designerViewController release];
        }
            break;
    }
}

@end
