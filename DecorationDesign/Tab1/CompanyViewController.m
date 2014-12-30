//
//  CompanyViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/15.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "CompanyViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController
@synthesize designerPicView,viewControllers,myscrollView,m_array,m_jsonArr,n_jsonArr;
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
    
    n_jsonArr = [[NSMutableArray alloc] initWithCapacity:1];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=[NSString stringWithFormat:@"%@",[m_array objectAtIndex:2]];
    self.titleLabel = titlelabel;
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
    
    //[self initHeaderComponents];
    //[self initScrollComponents];
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, applicationheight-49-44) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor clearColor];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
    [self initEgoRefreshComponent];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160)];
    [MBProgress setCenter:CGPointMake(applicationwidth/2.0, applicationheight/2)];
    [self.view addSubview:MBProgress];
    [MBProgress show:YES];
    [MBProgress setLabelText:@"刷新中"];
    
    [self loadRequest];
    [self loadWorklistRequest];
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

-(void)initEgoRefreshComponent
{
    UIView *touview=[[UIView alloc]initWithFrame:CGRectMake(0, -460, applicationwidth, 460-65)];
    touview.backgroundColor=[UIColor beijingcolor];
    [m_tableView addSubview:touview];
    [touview release];
    
    // 上拉加载视图 － RefreshView
    _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                          CGRectMake(0, m_tableView.frame.size.height, applicationwidth, 460)];
    _refreshFooterView.delegate = self;
    [m_tableView addSubview:_refreshFooterView];
    
    // 更新时间
    [_refreshFooterView refreshLastUpdatedDate];
    
    // 下拉加载视图 － RefreshView
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0, -65, applicationwidth, 65)];
    _refreshHeaderView.delegate = self;
    [m_tableView addSubview:_refreshHeaderView];
    
    // 更新时间
    [_refreshHeaderView refreshLastUpdatedDate];
    
    // 表示是否在加载
    _Headerreloading = YES;
    
    // page = 0;
    reloadormore = YES;
    mytime=@"";
}

-(void)loadRequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"获取中"];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"COMPANY-TWOPAGE",@"JUDGEMETHOD",[m_array objectAtIndex:1],@"COMPANYID", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress setHidden:YES];
            NSArray *infolist = [result objectForKey:@"COMPANYTWOPAGE"];
            self.m_jsonArr = infolist;
        }else {
            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
            NSLog(@"%@",errrDesc);
            [MBProgress settext:errrDesc aftertime:1.0];
        }
    }];
    [request setFailedBlock:^{
        NSLog(@"网络错误");
        [MBProgress settext:@"网络错误!" aftertime:1.0];
    }];
    [request startRequest];
}

-(void)loadWorklistRequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"获取中"];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"COMPANY-WORKSLIST-PAGE",@"JUDGEMETHOD",[m_array objectAtIndex:1],@"COMPANYID",[NSString stringWithFormat:@"%d",page++],@"GETTIMES", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            newList = [result objectForKey:@"COMPANYARTICLEINFO"];
            if ([newList count] > 0) {
                [MBProgress hide:YES];
                if (reloadormore) {
                    [n_jsonArr removeAllObjects];
                    [n_jsonArr addObjectsFromArray:newList];
                    reloadormore = NO;
                    [self performSelector:@selector(HeaderreloadFinish) withObject:nil afterDelay:0.f];
                    return;
                }
                else{
                    [n_jsonArr  addObjectsFromArray:newList];
                    [self performSelector:@selector(FooterreloadFinish) withObject:nil afterDelay:0.f];
                    return;
                }
            }
            else if([newList count] == 0){
                if (page>1) {
                    [MBProgress settext:@"没有更多了！" aftertime:1.0];
                }
                else
                {
                    [MBProgress settext:@"暂无数据!" aftertime:1.0];
                    [n_jsonArr removeAllObjects];
                }
                page --;
            }
        }else{
            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errrDesc delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        if (reloadormore) {
            [self performSelector:@selector(HeaderreloadFinish) withObject:nil afterDelay:0.f];
            reloadormore=NO;
        }
        else
        {
            [self performSelector:@selector(FooterreloadFinish) withObject:nil afterDelay:0.f];
            reloadormore=NO;
        }
    }];
    [request setFailedBlock:^{
        [MBProgress settext:@"网络错误，请检查网络连接！" aftertime:1.0];
        page--;
        
        if (reloadormore) {
            [self performSelector:@selector(HeaderreloadFinish) withObject:nil afterDelay:0.f];
            reloadormore=NO;
        }
        else
        {
            [self performSelector:@selector(FooterreloadFinish) withObject:nil afterDelay:0.f];
            reloadormore=NO;
        }
    }];
    [request startRequest];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n = n_jsonArr.count-1;
    if (n%8==6) {
        return n/8*6+n%8+3;
    }else if (n%8==7) {
        return n/8*6+n%8+2;
    }else{
        return n/8*6+n%8+4;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        static NSString *cellIdentific = @"cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            NSString *imageurl = [m_array objectAtIndex:0];
            UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
            picView.backgroundColor = [UIColor clearColor];
            [picView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"设计师头像1"]];
            self.designerPicView = picView;
            [cell.contentView addSubview:picView];
            [picView release];
            
            UILabel *zuoping = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 40, 20)];
            zuoping.text = @"作品:";
            zuoping.backgroundColor = [UIColor clearColor];
            zuoping.font = font(12);
            [cell.contentView addSubview:zuoping];
            [zuoping release];
            UILabel *zuopingValue = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 100, 20)];
            zuopingValue.text = @"888";
            worksLabel = zuopingValue;
            zuopingValue.tag = 11;
            zuopingValue.backgroundColor = [UIColor clearColor];
            zuopingValue.font = font(12);
            [cell.contentView addSubview:zuopingValue];
            [zuopingValue release];
            
            UILabel *jingping = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 40, 20)];
            jingping.text = @"精品:";
            jingping.backgroundColor = [UIColor clearColor];
            jingping.font = font(12);
            [cell.contentView addSubview:jingping];
            [jingping release];
            UILabel *jingpingValue = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 100, 20)];
            jingpingValue.text = @"88";
            good_workLabel = jingpingValue;
            jingpingValue.tag = 12;
            jingpingValue.backgroundColor = [UIColor clearColor];
            jingpingValue.font = font(12);
            [cell.contentView addSubview:jingpingValue];
            [jingpingValue release];
            
            
            
            UIButton *yuyueBtn = [[UIButton alloc] initWithFrame:CGRectMake(235, 11, 75, 37)];
            yuyueBtn.backgroundColor = [UIColor clearColor];
            [yuyueBtn setBackgroundImage:[UIImage imageNamed:@"预约"] forState:UIControlStateNormal];
            [yuyueBtn addTarget:self action:@selector(orderClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:yuyueBtn];
            [yuyueBtn release];
            
            UILabel *fengge = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 60, 20)];
            fengge.text = @"擅长风格:";
            fengge.backgroundColor = [UIColor clearColor];
            fengge.font = font(12);
            [cell.contentView addSubview:fengge];
            [fengge release];
            UILabel *fenggeValue = [[UILabel alloc] initWithFrame:CGRectMake(160, 50, 50, 20)];
            fenggeValue.text = @"中式风格";
            shanchangLabel = fenggeValue;
            fenggeValue.tag = 13;
            fenggeValue.backgroundColor = [UIColor clearColor];
            fenggeValue.font = font(12);
            [cell.contentView addSubview:fenggeValue];
            [fenggeValue release];
            
            UILabel *city = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 30, 20)];
            city.text = @"城市:";
            city.backgroundColor = [UIColor clearColor];
            city.font = font(12);
            [cell.contentView addSubview:city];
            [city release];
            UILabel *cityValue = [[UILabel alloc] initWithFrame:CGRectMake(260, 50, 60, 20)];
            cityValue.text = @"南京";
            cityLabel = cityValue;
            cityValue.tag = 14;
            cityValue.backgroundColor = [UIColor clearColor];
            cityValue.font = font(12);
            [cell.contentView addSubview:cityValue];
            [cityValue release];
            
            UILabel *zhuanye = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 60, 20)];
            zhuanye.text = @"设计专长:";
            zhuanye.backgroundColor = [UIColor clearColor];
            zhuanye.font = font(12);
            [cell.contentView addSubview:zhuanye];
            [zhuanye release];
            UILabel *zhuanyeValue = [[UILabel alloc] initWithFrame:CGRectMake(160, 70, 50, 20)];
            zhuanyeValue.text = @"别墅豪宅";
            professiorLabel = zhuanyeValue;
            zhuanyeValue.tag = 15;
            zhuanyeValue.backgroundColor = [UIColor clearColor];
            zhuanyeValue.font = font(12);
            [cell.contentView addSubview:zhuanyeValue];
            [zhuanyeValue release];
            
            UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(220, 70, 30, 20)];
            type.text = @"类型:";
            type.backgroundColor = [UIColor clearColor];
            type.font = font(12);
            [cell.contentView addSubview:type];
            [type release];
            UILabel *typeValue = [[UILabel alloc] initWithFrame:CGRectMake(260, 70, 60, 20)];
            typeValue.text = @"室内设计";
            typeLabel = typeValue;
            typeValue.tag = 16;
            typeValue.backgroundColor = [UIColor clearColor];
            typeValue.font = font(12);
            [cell.contentView addSubview:typeValue];
            [typeValue release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 99, 300, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
        }
        UILabel *lbl1 = (UILabel*)[cell.contentView viewWithTag:11];
        UILabel *lbl2 = (UILabel*)[cell.contentView viewWithTag:12];
        UILabel *lbl3 = (UILabel*)[cell.contentView viewWithTag:13];
        UILabel *lbl4 = (UILabel*)[cell.contentView viewWithTag:16];
        UILabel *lbl5 = (UILabel*)[cell.contentView viewWithTag:15];
        UILabel *lbl6 = (UILabel*)[cell.contentView viewWithTag:14];
        lbl1.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:1]];
        lbl2.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:2]];
        lbl3.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:3]];
        lbl4.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:4]];
        lbl5.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:5]];
        lbl6.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:7]];
        return cell;
    }else if (row == 1){
        static NSString *cellIdentific = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 30)];
            personTitle.text = @"公司简介";
            personTitle.font = font(18);
            [cell.contentView addSubview:personTitle];
            [personTitle release];
            
            UILabel *personName = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 300, 1000)];
            personName.font = font(13);
            personName.tag = 20;
            personName.numberOfLines = 0;
            personName.textColor = [UIColor grayColor];
            [cell.contentView addSubview:personName];
            [personName release];
            
            
            UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(applicationwidth-60, 10, 50, 25)];
            [detailBtn setImage:[UIImage imageNamed:@"xiangqing_btn_03"] forState:UIControlStateNormal];
            detailBtn.backgroundColor = [UIColor clearColor];
            detailBtn.tag = 23;
            [detailBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:detailBtn];
            [detailBtn release];
        }
        UILabel *lbl1 = (UILabel*)[cell.contentView viewWithTag:20];
        lbl1.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:0]];
        CGSize size = [lbl1.text sizeWithFont:font(13) constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        inroduceHeight = size.height;
        lbl1.frame = CGRectMake(lbl1.frame.origin.x, lbl1.frame.origin.y, 300, inroduceHeight) ;
        return cell;
    }
    else if (row == 2){
        static NSString *cellIdentific = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
            UIImageView *guanggao = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 300, 87)];
            guanggao.image = [UIImage imageNamed:@"Sjs_xiangqing_banner"];
            guanggao.tag = 30;
            [cell.contentView addSubview:guanggao];
            [guanggao release];
            
            UILabel *worksExample = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 120, 30)];
            worksExample.text = @"作品案例";
            worksExample.font = font(18);
            [cell.contentView addSubview:worksExample];
            [worksExample release];
        }
        NSString *imageurl = [m_jsonArr objectAtIndex:9];
        UIImageView *guangaoimage = (UIImageView*)[cell.contentView viewWithTag:30];
        [guangaoimage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_banner"]];
        return cell;
    }
    else{
        if ((row+4)%6==0) {
            static NSString *cellIdentific = @"cell4";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 1)];
                line.image = [UIImage imageNamed:@"线"];
                [cell.contentView addSubview:line];
                [line release];
                
                UIImageView *works1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 90, 80)];
                works1.image = [UIImage imageNamed:@"Sjs-xiangqing_img2"];
                works1.tag = 50;
                [cell.contentView addSubview:works1];
                [works1 release];
                
                UIImageView *works2 = [[UIImageView alloc] initWithFrame:CGRectMake(115, 5, 90, 80)];
                works2.image = [UIImage imageNamed:@"Sjs-xiangqing_img2"];
                works2.tag = 51;
                [cell.contentView addSubview:works2];
                [works2 release];
                
                UIImageView *works3 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 5, 90, 80)];
                works3.image = [UIImage imageNamed:@"Sjs-xiangqing_img2"];
                works3.tag = 52;
                [cell.contentView addSubview:works3];
                [works3 release];
                
            }
            UIImageView *works1Image = (UIImageView*)[cell.contentView viewWithTag:50];
            UIImageView *works2Image = (UIImageView*)[cell.contentView viewWithTag:51];
            UIImageView *works3Image = (UIImageView*)[cell.contentView viewWithTag:52];
            NSString *imageurl1 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)] objectAtIndex:2];
            NSString *imageurl2=@"";
            NSString *imageurl3=@"";
            if ((row-3)/6*2+row-2 <= n_jsonArr.count-1) {
                imageurl2 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-2)] objectAtIndex:2];
            }
            if ((row-3)/6*2+row-1 <= n_jsonArr.count-1) {
                imageurl3 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-1)] objectAtIndex:2];
            }
            [works1Image setImageWithURL:[NSURL URLWithString:imageurl1] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_img2"]];
            [works2Image setImageWithURL:[NSURL URLWithString:imageurl2] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_img2"]];
            [works3Image setImageWithURL:[NSURL URLWithString:imageurl3] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_img2"]];
            return cell;
        }else{
            static NSString *cellIdentific = @"cell3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
                cell.selectionStyle=UITableViewCellSelectionStyleGray;
                
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 1)];
                line.image = [UIImage imageNamed:@"线"];
                [cell.contentView addSubview:line];
                [line release];
                
                UIImageView *works = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 110, 70)];
                works.image = [UIImage imageNamed:@"Sjs_xiangqing_img1"];
                works.tag = 40;
                [cell.contentView addSubview:works];
                [works release];
                
                UILabel *m_title = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 180, 20)];
                m_title.text = @"玉树临风--卓越威刚明珠";
                m_title.font = font(15);
                m_title.tag = 41;
                m_title.textColor = [UIColor blackColor];
                [cell.contentView addSubview:m_title];
                [m_title release];
                
                UILabel *m_desc = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 180, 50)];
                m_desc.text = @"本次活动的主题为“微信·思维·智慧”。腾讯公司高级执行副总裁张小龙在开场的视频连线中表示，微信公众平台的口号是“再小的个体也有自己的品牌”，他从八个方面详细阐述了微信对于公众平台的理念和方向。";
                m_desc.font = font(13);
                m_desc.tag = 42;
                m_desc.numberOfLines = 0;
                m_desc.textColor = [UIColor grayColor];
                [cell.contentView addSubview:m_desc];
                [m_desc release];
            }
            UIImageView *worksImage = (UIImageView*)[cell.contentView viewWithTag:40];
            UILabel *l_title = (UILabel*)[cell.contentView viewWithTag:41];
            UILabel *l_desc = (UILabel*)[cell.contentView viewWithTag:42];
            
            NSString *imageurl = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)] objectAtIndex:2];
            [worksImage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_img1"]];
            l_title.text = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:3];
            l_desc.text = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:4];
            return cell;
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row==0) {
        return 100;
    }else if (row==1){
        return 50+[self cellHeight];
    }else if (row==2){
        return 140;
    }else{
        if ((row+4)%6==0)
        {
            return 90;
        }else{
            return 90;
        }
    }
    return 0;
}

-(CGFloat)cellHeight
{
    NSString *content = [m_jsonArr objectAtIndex:0];
    CGSize size = [content sizeWithFont:font(13) constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}

-(void)buttonClicked:(UIButton*)btn
{
    
}

-(void)orderClicked:(UIButton*)btn
{
    if ([UserInfo shared].m_isLogin) {
        BookingViewController *book = [[BookingViewController alloc] init];
        book.designerId=[m_array objectAtIndex:1];
        book.designerName = [m_jsonArr objectAtIndex:0];
        book.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:book animated:YES];
        [book release];
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        login.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:login animated:YES];
        [login release];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detail = [[DetailViewController alloc] init];
    NSInteger row = indexPath.row;
    detail.hidesBottomBarWhenPushed = YES;
    detail.method = @"COMPANY-WORKSINFO";
    detail.designerId =  [m_array objectAtIndex:1];
    detail.designer = [m_jsonArr objectAtIndex:0];
    detail.m_array = [n_jsonArr objectAtIndex:((row-3)/6*2+row-3)];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}


-(int)tablewheight
{
    NSInteger n = n_jsonArr.count-1;
    if (n%8==6) {
        return (n/8*6+n%8)*90+290+[self cellHeight];
    }else if (n%8==7) {
        return (n/8*6+n%8-1)*90+290+[self cellHeight];
    }else{
        return (n/8*6+n%8+1)*90+290+[self cellHeight];
    }
}

- (void)FooterreloadFinish
{
    if (_Headerreloading) {
        [m_tableView reloadData];
        if ([n_jsonArr count]==0) {
            m_tableView.contentSize=CGSizeMake(applicationwidth, m_tableView.frame.size.height);
            _refreshFooterView.frame=CGRectMake(0, m_tableView.frame.size.height, applicationwidth, 460);
        }
        else
        {
            if ([self tablewheight]<m_tableView.frame.size.height) {
                m_tableView.contentSize=CGSizeMake(applicationwidth, m_tableView.frame.size.height);
                _refreshFooterView.frame=CGRectMake(0, m_tableView.frame.size.height, applicationwidth, 460);
            }
            else
            {
                m_tableView.contentSize=CGSizeMake(applicationwidth, [self tablewheight]);
                _refreshFooterView.frame=CGRectMake(0, [self tablewheight], applicationwidth, 460);
            }
        }
        _refreshHeaderView.Frame=CGRectMake(0, -65, applicationwidth, 65);
        
    }
    
    // 数据加载完成
	[_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:m_tableView];
    
    _Headerreloading = NO;
}

- (void)HeaderreloadFinish
{
    if (_Headerreloading) {
        [m_tableView reloadData];
        if ([n_jsonArr count]==0) {
            m_tableView.contentSize=CGSizeMake(applicationwidth, m_tableView.frame.size.height);
            _refreshFooterView.frame=CGRectMake(0, m_tableView.frame.size.height, applicationwidth, 460);
        }
        else
        {
            if ([self tablewheight]<m_tableView.frame.size.height) {
                m_tableView.contentSize=CGSizeMake(applicationwidth, m_tableView.frame.size.height);
                _refreshFooterView.frame=CGRectMake(0, m_tableView.frame.size.height, applicationwidth, 460);
            }
            else
            {
                m_tableView.contentSize=CGSizeMake(applicationwidth, [self tablewheight]);
                _refreshFooterView.frame=CGRectMake(0, [self tablewheight], applicationwidth, 460);
            }
        }
        _refreshHeaderView.Frame=CGRectMake(0, -65, applicationwidth, 65);
    }
    
    // 数据加载完成
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:m_tableView];
    
    _Headerreloading = NO;
}

#pragma mark -
#pragma mark UIScrollView Delegate Methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:m_tableView];
    
    [_refreshFooterView egoRefreshScrollViewDidEndDragging:m_tableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableFooter Delegate Methods

// 开始更新
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView *)view
{
    //    [self performSelector:@selector(FooterreloadFinish) withObject:nil afterDelay:5.f];
    [self loadWorklistRequest];
    
    _Headerreloading = YES;   // 表示正处于加载更多数据状态
}

// 是否处于更新状态
- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView *)view {
    
	return _Headerreloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView *)view {
    
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark -
#pragma mark EGORefreshTableHeader Delegate Methods

// 开始更新
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    //    [self performSelector:@selector(HeaderreloadFinish) withObject:nil afterDelay:5.f];
    
    page=0;
    reloadormore=YES;
    [self loadWorklistRequest];
    _Headerreloading = YES;   // 表示正处于加载更多数据状态
}

// 是否处于更新状态
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
    
    return _Headerreloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view {
    
	return [NSDate date]; // should return date data source was last changed
}

@end
