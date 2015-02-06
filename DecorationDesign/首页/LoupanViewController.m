//
//  LoupanViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/15.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "LoupanViewController.h"
#import "CompanyLoupanController.h"

@interface LoupanViewController ()

@end

@implementation LoupanViewController
@synthesize m_array,m_jsonArr,n_jsonArr;


- (void)viewDidLoad
{
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
    [leftbtn addTarget:self action:@selector(loupanViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    CGFloat viewHeight = self.hidesBottomBarWhenPushed?applicationheight-44:applicationheight-49-44;
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, viewHeight) style:UITableViewStylePlain];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)loupanViewControllerBtnPressed:(UIButton*)btn
{
    if (btn.tag ==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"BUILDING-TWO-PAGE",@"JUDGEMETHOD",[m_array objectAtIndex:1],@"BUILDINGID", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress setHidden:YES];
            NSArray *infolist = [result objectForKey:@"BUILDINGTWOPAGEUP"];
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
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"BUILDINGCOMPANY-TWO-PAGE",@"JUDGEMETHOD",[m_array objectAtIndex:1],@"BUILDINGID",[NSString stringWithFormat:@"%d",page++],@"GETTIMES", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            newList = [result objectForKey:@"BUILDINGCOMPANYLISTINFO"];
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
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 30)];
            personTitle.text = @"楼盘介绍";
            personTitle.font = font(18);
            [cell.contentView addSubview:personTitle];
            [personTitle release];
        }
        return cell;
    }else if (row == 1){
        static NSString *cellIdentific = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIImageView *fengmian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 110)];
            fengmian.backgroundColor = [UIColor clearColor];
            fengmian.tag = 21;
            fengmian.image = [UIImage imageNamed:@"loup_2_img1"];
            [cell.contentView addSubview:fengmian];
            [fengmian release];
            
            UILabel *personName = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 300, 1000)];
            personName.font = font(13);
            personName.tag = 30;
            personName.numberOfLines = 0;
            personName.textColor = [UIColor grayColor];
            [cell.contentView addSubview:personName];
            [personName release];
        }
        NSString *imageurl = [m_jsonArr objectAtIndex:0];
        UIImageView *guangaoimage = (UIImageView*)[cell.contentView viewWithTag:21];
        [guangaoimage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"loup_2_img1"]];
        
        UILabel *lbl1 = (UILabel*)[cell.contentView viewWithTag:30];
        lbl1.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:2]];
        CGSize size = [lbl1.text sizeWithFont:font(13) constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        inroduceHeight = size.height;
        lbl1.frame = CGRectMake(lbl1.frame.origin.x, lbl1.frame.origin.y, 300, inroduceHeight) ;
        return cell;
    }
    else if (row == 2){
        static NSString *cellIdentific = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 300, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
            
            UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 30)];
            personTitle.text = @"相关公司";
            personTitle.font = font(18);
            [cell.contentView addSubview:personTitle];
            [personTitle release];
        }
        
        return cell;
    }
    else{
        if ((row+4)%6==0) {
            static NSString *cellIdentific = @"cell4";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                UIImageView *works1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 93.3, 70)];
                works1.image = [UIImage imageNamed:@"CAIliao_img3"];
                works1.tag = 50;
                [cell.contentView addSubview:works1];
                [works1 release];
                
                UIImageView *works2 = [[UIImageView alloc] initWithFrame:CGRectMake(113.3, 5, 93.3, 70)];
                works2.image = [UIImage imageNamed:@"CAIliao_img4"];
                works2.tag = 51;
                [cell.contentView addSubview:works2];
                [works2 release];
                
                UIImageView *works3 = [[UIImageView alloc] initWithFrame:CGRectMake(216.7, 5, 93.3, 70)];
                works3.image = [UIImage imageNamed:@"CAIliao_img5"];
                works3.tag = 52;
                [cell.contentView addSubview:works3];
                [works3 release];
                
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 79, 300, 1)];
                line.image = [UIImage imageNamed:@"线"];
                [cell.contentView addSubview:line];
                [line release];
                
            }
            UIImageView *works1Image = (UIImageView*)[cell.contentView viewWithTag:50];
            UIImageView *works2Image = (UIImageView*)[cell.contentView viewWithTag:51];
            UIImageView *works3Image = (UIImageView*)[cell.contentView viewWithTag:52];
            NSString *imageurl1 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)] objectAtIndex:0];
            NSString *imageurl2=@"";
            NSString *imageurl3=@"";
            if ((row-3)/6*2+row-2 <= n_jsonArr.count-1) {
                imageurl2 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-2)] objectAtIndex:0];
            }
            if ((row-3)/6*2+row-1 <= n_jsonArr.count-1) {
                imageurl3 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-1)] objectAtIndex:0];
            }
            [works1Image setImageWithURL:[NSURL URLWithString:imageurl1] placeholderImage:[UIImage imageNamed:@"CAIliao_img3"]];
            [works2Image setImageWithURL:[NSURL URLWithString:imageurl2] placeholderImage:[UIImage imageNamed:@"CAIliao_img4"]];
            [works3Image setImageWithURL:[NSURL URLWithString:imageurl3] placeholderImage:[UIImage imageNamed:@"CAIliao_img5"]];
            return cell;
        }else{
            static NSString *cellIdentific = @"cell3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
                cell.selectionStyle=UITableViewCellSelectionStyleGray;
                
                UIImageView *works = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 78, 62)];
                works.image = [UIImage imageNamed:@"loup_2_img2"];
                works.tag = 40;
                [cell.contentView addSubview:works];
                [works release];
                
                UILabel *m_title = [[UILabel alloc] initWithFrame:CGRectMake(98, 8, 212, 25)];
                m_title.text = @"玉树临风--卓越威刚明珠";
                m_title.font = font(15);
                m_title.tag = 41;
                m_title.textColor = [UIColor blackColor];
                [cell.contentView addSubview:m_title];
                [m_title release];
                
                UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(98, 36, 212, 40)];
                desc.font = font(12);
                desc.tag = 42;
                desc.numberOfLines = 2;
                desc.textColor = [UIColor grayColor];
                [cell.contentView addSubview:desc];
                [desc release];
                
                
                UILabel *pinglun = [[UILabel alloc] initWithFrame:CGRectMake(98, 60, 212, 15)];
                pinglun.font = font(12);
                pinglun.tag = 44;
                pinglun.textAlignment = UITextAlignmentRight;
                pinglun.textColor = [UIColor grayColor];
                [cell.contentView addSubview:pinglun];
                [pinglun release];
                
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 79, 300, 1)];
                line.image = [UIImage imageNamed:@"线"];
                [cell.contentView addSubview:line];
                [line release];
            }
            UIImageView *worksImage = (UIImageView*)[cell.contentView viewWithTag:40];
            UILabel *l_title = (UILabel*)[cell.contentView viewWithTag:41];
            UILabel *desc = (UILabel*)[cell.contentView viewWithTag:42];
            UILabel *pinglun = (UILabel*)[cell.contentView viewWithTag:44];
            NSString *imageurl = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)] objectAtIndex:0];
            [worksImage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"CAIliao_img1"]];
            l_title.text = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:1];
            NSString *descString = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)] objectAtIndex:2];
            NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:descString];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:5];
            [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [descString length])];
            [desc setAttributedText:attributedString1];
            [desc sizeToFit];
            
            //desc.text = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:2];
            pinglun.text = [NSString stringWithFormat:@"%@ 评",[[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:3]];
            return cell;
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row==0) {
        return 40;
    }else if (row==1){
        return 120+[self cellHeight:2];
    }else if (row==2){
        return 40;
    }else{
        if ((row+4)%6==0)
        {
            return 80;
        }else{
            return 80;
        }
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    if (row>2) {
        if ((row+4)%6==0) {
            CompanyLoupanController *lou = [[CompanyLoupanController alloc] init];
            lou.m_array = [n_jsonArr objectAtIndex:((row-3)/6*2+row-3)];
            lou.buildId = [NSString stringWithFormat:@"%@",[m_array objectAtIndex:1]];
            lou.hidesBottomBarWhenPushed= YES;
            [self.navigationController pushViewController:lou animated:YES];
            [lou release];
        }else{
            CompanyLoupanController *lou = [[CompanyLoupanController alloc] init];
            lou.m_array = [n_jsonArr objectAtIndex:((row-3)/6*2+row-3)];
            lou.buildId = [NSString stringWithFormat:@"%@",[m_array objectAtIndex:1]];
            lou.hidesBottomBarWhenPushed= YES;
            [self.navigationController pushViewController:lou animated:YES];
            [lou release];
        }
    }
}

-(CGFloat)cellHeight:(NSInteger)index
{
    NSString *content = [m_jsonArr objectAtIndex:index];
    CGSize size = [content sizeWithFont:font(13) constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}

-(CGFloat)tablewheight
{
    NSInteger n = n_jsonArr.count-1;
    if (n%8==6) {
        return (n/8*6+n%8)*80+200+[self cellHeight:2];
    }else if (n%8==7) {
        return (n/8*6+n%8-1)*80+200+[self cellHeight:2];
    }else{
        return (n/8*6+n%8+1)*80+200+[self cellHeight:2];
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
