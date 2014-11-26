//
//  FaxianViewController.m
//  TGQ2
//
//  Created by 元元 on 14-7-15.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "FaxianViewController.h"

@interface FaxianViewController ()

@end

@implementation FaxianViewController
@synthesize m_dictionary;

-(void)dealloc
{
    [queryMenuListRequest clearDelegatesAndCancel];
    [queryMenuListRequest release];
    [queryNewsListRequest clearDelegatesAndCancel];
    [queryNewsListRequest release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (iOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"标题栏%i.png",[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?7:6]] forBarMetrics:UIBarMetricsDefault];
    
    UIImage *shadowimage=[[UIImage alloc]init];
    self.navigationController.navigationBar.shadowImage = shadowimage;//去掉navigationBar阴影黑线
    [shadowimage release];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"设计师";
    titlelabel.textAlignment=UITextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-10, 0, 60, 44);
    leftbtn.tag =1;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(DesignerControllerBackBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    //搜索按钮
    UIView *rightbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 60, 44);
    rightbtn.tag = 2;
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"导航搜索.png"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(DesignerControllerBackBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightbtnview addSubview:rightbtn];
    
    UIBarButtonItem *myrightitem = [[UIBarButtonItem alloc] initWithCustomView:rightbtnview];
    self.navigationItem.rightBarButtonItem = myrightitem;
    [myrightitem release];
    [rightbtnview release];
    
    _menuList = [[NSMutableArray alloc] initWithCapacity:1];
    scrollMenu = [[ScrollMenu alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 44.5)];
    
    //[self.view addSubview:scrollMenu];
    
    [self.view insertSubview:scrollMenu atIndex:99];
    
    newsScrollView = [[NewsScrollView alloc] initWithFrame:CGRectMake(0, 82-37.5, applicationwidth, applicationheight-44-44-49)];
    newsScrollView.navigationScrollView = scrollMenu;
    newsScrollView.t_delegate = self;
    //[self.view addSubview:newsScrollView];
    [self.view insertSubview:newsScrollView atIndex:97];
    scrollMenu.newsScrollView = newsScrollView;
    
    scrollMenu.myDelegate = newsScrollView;
    
    //更多视图
    UIView *addView = [[UIView alloc] initWithFrame:CGRectMake(0, 44-125, applicationwidth, 125)];
    addView.backgroundColor = [UIColor grayColor];
    addView.alpha = 0.9f;
    addView.hidden = YES;
    moreView = addView;
    //[self.view addSubview:addView];
    [self.view insertSubview:addView atIndex:98];
    [addView release];
    [self.view bringSubviewToFront:scrollMenu];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160)];
    [MBProgress setCenter:CGPointMake(applicationwidth/2.0, applicationheight/2)];
    [self.view addSubview:MBProgress];
    [MBProgress show:YES];
    [MBProgress setLabelText:@"刷新中"];
    
    [self reloadMenuRequest];
}

-(void)DesignerControllerBackBtnPressed:(UIButton*)btn
{
    if (btn.tag ==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //搜索
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"reloadfaxianview"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"reloadfaxianview"];
        [self reloadMenuRequest];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)reloadMenuRequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"刷新中"];
    NSString *url_str=[NSString stringWithFormat:@"%@foundActivity/getFoundTrade",MineURL];
    NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *asiReq=[[ASIFormDataRequest alloc] initWithURL:url];
    [queryMenuListRequest cancel];
    queryMenuListRequest = asiReq;
    [asiReq setCompletionBlock:^{
        NSDictionary *dic=[[asiReq responseString] JSONValue];
        NSLog(@"已完成：%@",dic);
        if (dic) {
            _menuList = [dic objectForKey:@"result"];
            NSDictionary *first = [NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"name",@"0",@"id", nil];
            [_menuList insertObject:first atIndex:0];
            [scrollMenu updateListItem:_menuList];
            //更多按钮设置
            [self addMoreButton:_menuList];
            //更新newsscroll
            [newsScrollView reloadscrollview:_menuList];
            if ([_menuList count] > 0) {
                [MBProgress hide:YES];
            }
            else if([_menuList count] == 0){
                [MBProgress settext:@"暂无数据!" aftertime:1.0];
                [_menuList removeAllObjects];
            }
        }else{
            NSLog(@"json解析错误!");
            [MBProgress settext:@"网络异常！" aftertime:1.0];
        }
    }];
    [asiReq setFailedBlock:^{
        //[MBProgress settext:@"网络错误，请检查网络连接！" aftertime:1.0];
        [MBProgress setHidden:YES];
        NSLog(@"informationrequestFailed");
        
    }];
    asiReq.timeOutSeconds = ktimeOutSeconds;
    [asiReq startAsynchronous];
    [asiReq release];
}

-(void)addMoreButton:(NSMutableArray*)array
{
    if (array.count*64 > self.view.frame.size.width) {
        //添加更多按钮
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(applicationwidth-50, 0, 50, 44)];
        v.backgroundColor = [UIColor whiteColor];
        UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 22)];
        moreBtn.backgroundColor = [UIColor whiteColor];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"下箭头"] forState:UIControlStateNormal];
        [self initMoreViewContent:array];
        [moreBtn addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
        moreButton = moreBtn;
        [v addSubview:moreBtn];
        [self.view addSubview:v];
        [moreBtn release];
        [v release];
    }
}

-(void)initMoreViewContent:(NSMutableArray*)array
{
    for (UIView *v in moreView.subviews) {
        [v removeFromSuperview];
    }
    for (int i=0; i<3; i++) {
        for (int j=0; j<4; j++) {
            if (i*4+j+1<=array.count) {
                CityItem *item = [[CityItem alloc] initWithFrame:CGRectMake(20+72*j*widthRate, 20+35*i, 50*widthRate, 25)];
                item.tag = 200+ i*4+j;
                item.layer.cornerRadius = 12.5;
                item.layer.masksToBounds = YES;
                NSDictionary *dic =[PublicFunction fixDictionary:[array objectAtIndex:(i*4+j)]] ;
                item.city = [dic objectForKey:@"name"];
                item.cityId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
                [item addTarget:self action:@selector(ItemClicked:) forControlEvents:UIControlEventTouchUpInside];
                [moreView addSubview:item];
                [item release];
            }
            
        }
    }
}

-(void)ItemClicked:(UIButton*)btn
{
    moreView.frame = CGRectMake(0, 44.5, applicationwidth, 125);
    [UIView animateWithDuration:0.35f animations:^{
        moreView.frame = CGRectMake(0, 44.5-125, applicationwidth, 125);
        moreButton.transform =CGAffineTransformIdentity;
    } completion:^(BOOL success){
        moreView.hidden = YES;
    }];
    [scrollMenu selectItem:btn];
}

-(void)showMore:(UIButton*)btn
{
    if (moreView.hidden) {
        moreView.hidden = NO;
        moreView.frame = CGRectMake(0, 44.5-125, applicationwidth, 125);
        [UIView animateWithDuration:0.35f animations:^{
            moreView.frame = CGRectMake(0, 44.5, applicationwidth, 125);
            btn.transform =CGAffineTransformMakeRotation(M_PI);
        }];
    }else{
        moreView.frame = CGRectMake(0, 44.5, applicationwidth, 125);
        [UIView animateWithDuration:0.35f animations:^{
            moreView.frame = CGRectMake(0, 44.5-125, applicationwidth, 125);
            btn.transform =CGAffineTransformIdentity;
        } completion:^(BOOL success){
            moreView.hidden = YES;
        }];
    }
}

-(void)NewsTableViewBtnPressed:(NSDictionary *)dic
{
    DesignerViewController *designer = [[DesignerViewController alloc] init];
    [self.navigationController pushViewController:designer animated:YES];
    [designer release];
}

-(void)selectItemButton:(UIButton *)btn withData:(NSDictionary *)dic
{
    
}

@end
