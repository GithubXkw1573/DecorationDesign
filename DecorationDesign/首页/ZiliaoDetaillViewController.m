//
//  ZiliaoDetaillViewController.m
//  TGQ
//
//  Created by 许开伟 on 13-12-24.
//  Copyright (c) 2013年 元元. All rights reserved.
//

#import "ZiliaoDetaillViewController.h"

@interface ZiliaoDetaillViewController ()

@end

@implementation ZiliaoDetaillViewController
@synthesize Dictionary;
@synthesize WebView;
@synthesize detailhttprequest;
@synthesize MBProgress;

-(void)dealloc
{
    [MBProgress release];
    [detailhttprequest clearDelegatesAndCancel];
    [detailhttprequest release];
    [WebView release];
    [Dictionary release];
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
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-20, 0, 60, 44);
    leftbtn.tag=1;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(ZiliaoDetaillViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    
    
    UIWebView *myneirongtext=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, applicationheight-44-49)];
    myneirongtext.tag=1;
    myneirongtext.delegate=self;
    myneirongtext.isAccessibilityElement =NO;
    myneirongtext.backgroundColor=[UIColor clearColor];
    myneirongtext.scrollView.backgroundColor=[UIColor clearColor];
    self.WebView=myneirongtext;
    [self.view addSubview:myneirongtext];
    [myneirongtext release];
    [self clearWebViewBackgroundWithColor];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    [MBProgress setCenter:CGPointMake(160, applicationheight/2-44)];
    [self.view addSubview:MBProgress];
    [MBProgress show:YES];
    [MBProgress setLabelText:@"刷新中"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self detailrequest];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)ZiliaoDetaillViewControllerBtnPressed:(id)sender
{
    UIButton *Btn = (UIButton *)sender;
    switch (Btn.tag) {
        case 1:
        {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
            break;
        
        default:
            break;
    }
}

-(void)detailrequest
{
    NSString *url_str=[NSString stringWithFormat:@"%@merchant/queryContentDetail",MineURL];
    NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *request=[[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
    [request setPostValue:@"20140808G602624" forKey:@"cid"];
    [self.detailhttprequest cancel];
    self.detailhttprequest=request;
    
    request.timeOutSeconds=ktimeOutSeconds;
    //异步请求
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(detailrequestFinished:)];
    [request setDidFailSelector:@selector(detailrequestFailed:)];
    [request startAsynchronous];
}

-(void)detailrequestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dic=[[request responseString] JSONValue];
    if (dic) {
//        NSLog(@"detailrequestFinished:%@",dic);
        [MBProgress hide:YES];
        
        NSMutableString *Strxml=[dic objectForKey:@"content"];
        
//        NSLog(@"Strxml:%@",Strxml);
        
        [WebView loadHTMLString:Strxml baseURL:nil];
        
    }
    else
    {
        NSLog(@"json解析错误!");
        [MBProgress hide:YES];
    }
}

-(void)detailrequestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"detailrequestFailed");
    
    [MBProgress settext:@"网络错误!" aftertime:1.0];
}

- (void)clearWebViewBackgroundWithColor{
    for (UIView *view in [self.WebView subviews]){
        if ([view isKindOfClass:[UIScrollView class]]){
            for (UIView *shadowView in view.subviews){
                // 上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                if ([shadowView isKindOfClass:[UIImageView class]]){
                    shadowView.hidden = YES;
                }
            }
        }
    }
}

@end
