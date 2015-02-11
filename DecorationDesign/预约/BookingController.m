//
//  BookingController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "BookingController.h"
#import "FaxianViewController.h"

@interface BookingController ()

@end

@implementation BookingController
@synthesize MBProgress;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNaviWithTitle:@"预约"];
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
}

-(void)initComponents
{
    CGFloat backHeight = 0;
    if (IS_IPHONE5) {
        backHeight = 268;
    }else{
        backHeight = 268-88;
    }
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, backHeight)];
    backImageView= imageV;
    imageV.backgroundColor = [UIColor clearColor];
    imageV.image = [UIImage imageNamed:@"yuyue_img_02"];
    [self.view addSubview:imageV];
    [imageV release];
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, applicationheight-49-44) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor clearColor];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160)];
    [MBProgress setCenter:CGPointMake(applicationwidth/2.0, applicationheight/2)];
    [self.view addSubview:MBProgress];
    [MBProgress hide:YES];
    [MBProgress setLabelText:@"加载中"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row==0) {
        static NSString *identifierCell = @"cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }else{
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell] autorelease];
            cell.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1.f];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIButton *shejishiBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 30, 143, 108)];
            [shejishiBtn setTitle:@"预约设计师" forState:UIControlStateNormal];
            [shejishiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [shejishiBtn setTitleEdgeInsets:UIEdgeInsetsMake(70, 0, 0, 0)];
            shejishiBtn.titleLabel.font = font(16);
            [shejishiBtn setBackgroundImage:[UIImage imageNamed:@"yuyue_btn_05"] forState:UIControlStateNormal];
            shejishiBtn.backgroundColor = [UIColor clearColor];
            shejishiBtn.tag = 11;
            [shejishiBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:shejishiBtn];
            [shejishiBtn release];
            
            UIButton *gongsiBtn = [[UIButton alloc] initWithFrame:CGRectMake(169, 30, 143, 108)];
            [gongsiBtn setTitle:@"预约装修公司" forState:UIControlStateNormal];
            [gongsiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [gongsiBtn setTitleEdgeInsets:UIEdgeInsetsMake(70, 0, 0, 0)];
            gongsiBtn.titleLabel.font = font(16);
            [gongsiBtn setBackgroundImage:[UIImage imageNamed:@"yuyue_btn_07"] forState:UIControlStateNormal];
            gongsiBtn.backgroundColor = [UIColor clearColor];
            gongsiBtn.tag = 12;
            [gongsiBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:gongsiBtn];
            [gongsiBtn release];
        }
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return IS_IPHONE5?268:268-88;
    }else{
        return 200;
    }
}

-(void)buttonClicked:(UIButton*)btn
{
    if (btn.tag ==11) {
        //设计师
        [MBProgress show:YES];
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            FaxianViewController *faxian = [[FaxianViewController alloc] init];
            faxian.contentType = 1;
            [UserInfo shared].m_plateType = @"S";
            [self.navigationController pushViewController:faxian animated:YES];
            [faxian release];
            [MBProgress hide:YES];
        });
        
    }else if (btn.tag ==12){
        //装修公司
        [MBProgress show:YES];
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            FaxianViewController *faxian = [[FaxianViewController alloc] init];
            faxian.contentType = 4;
            [UserInfo shared].m_plateType = @"J";
            [self.navigationController pushViewController:faxian animated:YES];
            [faxian release];
            [MBProgress hide:YES];
        });
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //拖动图片放大效果
    if (scrollView.contentOffset.y<0) {
        backImageView.frame=CGRectMake(0+scrollView.contentOffset.y, 0, 320-scrollView.contentOffset.y*2, 268-scrollView.contentOffset.y*2);
    }
    else
    {
        CGRect frame = backImageView.frame;
        frame.origin.y = - (scrollView.contentOffset.y);
        backImageView.frame = frame;
    }
}

@end
