//
//  DesignerViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/19.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "DesignerViewController.h"

@interface DesignerViewController ()

@end

@implementation DesignerViewController
@synthesize designerPicView,viewControllers,myscrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
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
    titlelabel.text=@"张大海";
    titlelabel.textAlignment=UITextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-10, 0, 60, 44);
    leftbtn.tag=1;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(designerbackViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    [self initHeaderComponents];
    [self initScrollComponents];
}

-(void)designerbackViewControllerBtnPressed:(UIButton*)btn
{
    if (btn.tag ==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initHeaderComponents
{
    UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    picView.backgroundColor = [UIColor clearColor];
    picView.image = [UIImage imageNamed:@"设计师头像1"];
    self.designerPicView = picView;
    [self.view addSubview:picView];
    [picView release];
    
    UILabel *zuoping = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 40, 20)];
    zuoping.text = @"作品:";
    zuoping.backgroundColor = [UIColor clearColor];
    zuoping.font = font(12);
    [self.view addSubview:zuoping];
    [zuoping release];
    UILabel *zuopingValue = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 30, 20)];
    zuopingValue.text = @"888";
    zuopingValue.backgroundColor = [UIColor clearColor];
    zuopingValue.font = font(12);
    [self.view addSubview:zuopingValue];
    [zuopingValue release];
    
    UILabel *jingping = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 40, 20)];
    jingping.text = @"精品:";
    jingping.backgroundColor = [UIColor clearColor];
    jingping.font = font(12);
    [self.view addSubview:jingping];
    [jingping release];
    UILabel *jingpingValue = [[UILabel alloc] initWithFrame:CGRectMake(210, 10, 30, 20)];
    jingpingValue.text = @"88";
    jingpingValue.backgroundColor = [UIColor clearColor];
    jingpingValue.font = font(12);
    [self.view addSubview:jingpingValue];
    [jingpingValue release];
    
    UILabel *qiandan = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 40, 20)];
    qiandan.text = @"签单:";
    qiandan.backgroundColor = [UIColor clearColor];
    qiandan.font = font(12);
    [self.view addSubview:qiandan];
    [qiandan release];
    UILabel *qiandanValue = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 30, 20)];
    qiandanValue.text = @"8";
    qiandanValue.backgroundColor = [UIColor clearColor];
    qiandanValue.font = font(12);
    [self.view addSubview:qiandanValue];
    [qiandanValue release];
    
    UILabel *jingyan = [[UILabel alloc] initWithFrame:CGRectMake(170, 30, 40, 20)];
    jingyan.text = @"经验:";
    jingyan.backgroundColor = [UIColor clearColor];
    jingyan.font = font(12);
    [self.view addSubview:jingyan];
    [jingyan release];
    UILabel *jiangyanValue = [[UILabel alloc] initWithFrame:CGRectMake(210, 30, 30, 20)];
    jiangyanValue.text = @"88";
    jiangyanValue.backgroundColor = [UIColor clearColor];
    jiangyanValue.font = font(12);
    [self.view addSubview:jiangyanValue];
    [jiangyanValue release];
    
    
    UIButton *yuyueBtn = [[UIButton alloc] initWithFrame:CGRectMake(235, 11, 75, 37)];
    yuyueBtn.backgroundColor = [UIColor clearColor];
    yuyueBtn.titleLabel.lineBreakMode = 0;
    yuyueBtn.titleLabel.font = font(11);
    yuyueBtn.titleLabel.textAlignment = UITextAlignmentCenter;
    [yuyueBtn setBackgroundImage:[UIImage imageNamed:@"预约"] forState:UIControlStateNormal];
    [yuyueBtn setContentEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
    [yuyueBtn setTitle:@"已被预约12次" forState:UIControlStateNormal];
    [yuyueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yuyueBtn addTarget:self action:@selector(orderClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yuyueBtn];
    [yuyueBtn release];
    
    UILabel *fengge = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 60, 20)];
    fengge.text = @"擅长风格:";
    fengge.backgroundColor = [UIColor clearColor];
    fengge.font = font(12);
    [self.view addSubview:fengge];
    [fengge release];
    UILabel *fenggeValue = [[UILabel alloc] initWithFrame:CGRectMake(160, 50, 50, 20)];
    fenggeValue.text = @"中式风格";
    fenggeValue.backgroundColor = [UIColor clearColor];
    fenggeValue.font = font(12);
    [self.view addSubview:fenggeValue];
    [fenggeValue release];
    
    UILabel *city = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 30, 20)];
    city.text = @"城市:";
    city.backgroundColor = [UIColor clearColor];
    city.font = font(12);
    [self.view addSubview:city];
    [city release];
    UILabel *cityValue = [[UILabel alloc] initWithFrame:CGRectMake(260, 50, 40, 20)];
    cityValue.text = @"南京";
    cityValue.backgroundColor = [UIColor clearColor];
    cityValue.font = font(12);
    [self.view addSubview:cityValue];
    [cityValue release];
    
    UILabel *zhuanye = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 60, 20)];
    zhuanye.text = @"设计专长:";
    zhuanye.backgroundColor = [UIColor clearColor];
    zhuanye.font = font(12);
    [self.view addSubview:zhuanye];
    [zhuanye release];
    UILabel *zhuanyeValue = [[UILabel alloc] initWithFrame:CGRectMake(160, 70, 50, 20)];
    zhuanyeValue.text = @"别墅豪宅";
    zhuanyeValue.backgroundColor = [UIColor clearColor];
    zhuanyeValue.font = font(12);
    [self.view addSubview:zhuanyeValue];
    [zhuanyeValue release];
    
    UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(220, 70, 30, 20)];
    type.text = @"类型:";
    type.backgroundColor = [UIColor clearColor];
    type.font = font(12);
    [self.view addSubview:type];
    [type release];
    UILabel *typeValue = [[UILabel alloc] initWithFrame:CGRectMake(260, 70, 50, 20)];
    typeValue.text = @"室内设计";
    typeValue.backgroundColor = [UIColor clearColor];
    typeValue.font = font(12);
    [self.view addSubview:typeValue];
    [typeValue release];
    
}

-(void)initScrollComponents
{
    UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(10, 103, applicationwidth-20, 27)];
    bannerView.backgroundColor = [UIColor myorangecolor];
    [self.view addSubview:bannerView];
    [bannerView release];
    
    UIView *yinying = [[UIView alloc] initWithFrame:CGRectMake(10, 4, 80, 20)];
    yinying.backgroundColor = [UIColor grayColor];
    shadow = yinying;
    yinying.layer.cornerRadius = 10;
    yinying.layer.masksToBounds = YES;
    [bannerView addSubview:yinying];
    [yinying release];
    
    UIButton *inroduce = [[UIButton alloc] initWithFrame:CGRectMake(10, 4, 80, 20)];
    inroduce.tag = 100;
    inroduce.titleLabel.font = font(16);
    [inroduce setTitle:@"个人介绍" forState:UIControlStateNormal];
    [inroduce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    inroduce.backgroundColor = [UIColor clearColor];
    [inroduce addTarget:self action:@selector(swichPanel:) forControlEvents:UIControlEventTouchUpInside];
    [bannerView addSubview:inroduce];
    [inroduce release];
    
    UIButton *zuoping = [[UIButton alloc] initWithFrame:CGRectMake(100, 4, 80, 20)];
    zuoping.tag = 101;
    zuoping.titleLabel.font = font(16);
    [zuoping setTitle:@"作品案例" forState:UIControlStateNormal];
    [zuoping setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zuoping.backgroundColor = [UIColor clearColor];
    [zuoping addTarget:self action:@selector(swichPanel:) forControlEvents:UIControlEventTouchUpInside];
    [bannerView addSubview:zuoping];
    [zuoping release];
    
    UIButton *article = [[UIButton alloc] initWithFrame:CGRectMake(190, 4, 80, 20)];
    article.tag = 102;
    article.titleLabel.font = font(16);
    [article setTitle:@"精彩博文" forState:UIControlStateNormal];
    [article setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    article.backgroundColor = [UIColor clearColor];
    [article addTarget:self action:@selector(swichPanel:) forControlEvents:UIControlEventTouchUpInside];
    [bannerView addSubview:article];
    [article release];
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 138, applicationwidth, applicationheight-49-44-138)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.tag=11;
    self.myscrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView release];
    scrollView.bounces=NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
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
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*3, scrollView.frame.size.height);
    [scrollView scrollRectToVisible:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    [self loadScrollViewWithPage:0];
    
}

- (void)loadScrollViewWithPage:(int)page2 {
    if (page2 < 0) return;
    if (page2 >= 3) return;
    
    // replace the placeholder if necessary
    UIView *controller = [viewControllers objectAtIndex:page2];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[UIView alloc] init];
        
        if (page2==0) {
            PersonIntroduceView *intr = [[PersonIntroduceView alloc] initWithFrame:CGRectMake(10, 0, myscrollView.frame.size.width-20, myscrollView.frame.size.height)];
            [controller addSubview:intr];
            [intr release];
            
        }else if (page2==1){
            //table2
            ZuopingView *intr = [[ZuopingView alloc] initWithFrame:CGRectMake(10, 0, myscrollView.frame.size.width-20, myscrollView.frame.size.height)];
            intr.currController = self.navigationController;
            [controller addSubview:intr];
            [intr release];
        }else{
            //table3
            ArticleView *intr = [[ArticleView alloc] initWithFrame:CGRectMake(0, 0, myscrollView.frame.size.width, myscrollView.frame.size.height)];
            intr.currController = self.navigationController;
            [controller addSubview:intr];
            [intr release];
        }
        
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
}

-(void)orderClicked:(UIButton*)btn
{
    
}

-(void)swichPanel:(UIButton*)btn
{
    int index = btn.tag -100;
//    [UIView animateWithDuration:0.35f animations:^{
//        CGRect myframe = shadow.frame;
//        //shadow.transform = CGAffineTransformMakeTranslation(10+90*index-myframe.origin.x, 0) ;
//        shadow.frame = CGRectMake(10+90*index, myframe.origin.y, myframe.size.width, myframe.size.height);
//        
//    } completion:^(BOOL succ){
//        
//    }];
    [self loadScrollViewWithPage:index - 1];
    [self loadScrollViewWithPage:index];
    [self loadScrollViewWithPage:index + 1];
    
    [myscrollView scrollRectToVisible:CGRectMake(myscrollView.frame.size.width*index, myscrollView.frame.origin.y, myscrollView.frame.size.width, myscrollView.frame.size.height) animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==11) {
        
        
        CGFloat pageWidth = myscrollView.frame.size.width;
        int page2 = floor((myscrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        [UIView animateWithDuration:0.15f animations:^{
            shadow.transform = CGAffineTransformMakeTranslation(90*page2, 0) ;
        } completion:^(BOOL succ){
            //shadow.transform = CGAffineTransformMakeTranslation(90*page2, 0) ;
        }];
        [self loadScrollViewWithPage:page2 - 1];
        [self loadScrollViewWithPage:page2];
        [self loadScrollViewWithPage:page2 + 1];
    }
}
@end
