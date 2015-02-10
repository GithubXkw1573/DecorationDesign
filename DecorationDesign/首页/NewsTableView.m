//
//  NewsTableView.m
//  TGQ2
//
//  Created by 许开伟 on 14-8-22.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "NewsTableView.h"
#import "AdvertisingController.h"

@implementation NewsTableView
@synthesize m_newsArray;
@synthesize delegate;
@synthesize shaixuan;
@synthesize m_array;
@synthesize m_tableView;
@synthesize m_Dictionary;
@synthesize m_recommdArray;
@synthesize adverArray;
@synthesize newAdverList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_newsArray = [[NSMutableArray alloc] initWithCapacity:1];
        selectRecordList = [[NSMutableArray alloc] init];
        adverArray = [[NSMutableArray alloc] init];
        newAdverList = [[NSArray alloc] init];
        m_array = [[NSArray alloc] init];
        m_recommdArray = [[NSMutableArray alloc] initWithCapacity:0];
        m_Dictionary = [[NSDictionary alloc] init];
        m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, self.frame.size.height) style:UITableViewStylePlain];
        m_tableView.delegate =self;
        m_tableView.dataSource =self;
        m_tableView.backgroundColor=[UIColor clearColor];
        m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self addSubview:m_tableView];
        
        [self initEgoRefreshComponent];
        
        
    }
    return self;
}

-(void)ViewFrashData{
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [m_tableView setContentOffset:CGPointMake(0, -66) animated:YES];
        [self performSelector:@selector(doneManualRefresh) withObject:nil afterDelay:0.4];
    });
}

-(void)doneManualRefresh{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:m_tableView];
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:m_tableView];
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
    _Headerreloading = NO;
    
    // page = 0;
    reloadormore = YES;
    mytime=@"";
}

-(void)loadAdvertisimentList:(NSArray*)m_newList
{
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"GET_ADVERTMENT",@"JUDGEMETHOD",[UserInfo shared].m_plateType,@"PLATETYPE",[self.m_array objectAtIndex:0],@"PLATECODE",@"1",@"PAGEMARK",[NSString stringWithFormat:@"%d",page],@"GETTIMES", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            self.newAdverList = [result objectForKey:@"ADVERTLISTINFO"];
            [MBProgress setHidden:YES];
            if (reloadormore) {
                [adverArray removeAllObjects];
                if (m_newList.count==10) {
                    if (newAdverList.count==2) {
                        [adverArray addObjectsFromArray:newAdverList];
                    }else{
                        [adverArray addObject:[newAdverList objectAtIndex:0]];
                        [adverArray addObject:[newAdverList objectAtIndex:0]];
                    }
                }else if (m_newList.count>5){
                    [adverArray addObject:[newAdverList objectAtIndex:0]];
                }
                [self performSelector:@selector(HeaderreloadFinish) withObject:nil afterDelay:0.f];
                return;
            }
            else{
                if (m_newList.count==10) {
                    if (newAdverList.count==2) {
                        [adverArray addObjectsFromArray:newAdverList];
                    }else{
                        [adverArray addObject:[newAdverList objectAtIndex:0]];
                        [adverArray addObject:[newAdverList objectAtIndex:0]];
                    }
                }else if (m_newList.count>5){
                    [adverArray addObject:[newAdverList objectAtIndex:0]];
                }
                [self performSelector:@selector(FooterreloadFinish) withObject:nil afterDelay:0.f];
                return;
            }
        }else {
            if (m_newList.count==10) {
                if (newAdverList.count==2) {
                    [adverArray addObjectsFromArray:newAdverList];
                }else{
                    [adverArray addObject:[newAdverList objectAtIndex:0]];
                    [adverArray addObject:[newAdverList objectAtIndex:0]];
                }
            }else if (m_newList.count>5){
                [adverArray addObject:[newAdverList objectAtIndex:0]];
            }
            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
            NSLog(@"%@",errrDesc);
            [MBProgress settext:errrDesc aftertime:1.0];
        }
    }];
    [request setFailedBlock:^{
        if (m_newList.count==10) {
            if (newAdverList.count==2) {
                [adverArray addObjectsFromArray:newAdverList];
            }else{
                [adverArray addObject:[newAdverList objectAtIndex:0]];
                [adverArray addObject:[newAdverList objectAtIndex:0]];
            }
        }else if (m_newList.count>5){
            [adverArray addObject:[newAdverList objectAtIndex:0]];
        }
        NSLog(@"网络错误");
        [MBProgress settext:@"网络错误" aftertime:1.0];
    }];
    [request startRequest];
}

-(void)reloadrequest
{
    NSURL *url=[NSURL URLWithString:[MineURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    HessianFormDataRequest *hessianrequest=[[HessianFormDataRequest alloc] initWithURL:url];
    NSString *methodName = @"USER-LIST-PAGE";
    NSString *userType = @"USERTYPE";
    NSString *resultKey = @"USERLISTINFO";
    if (self.shaixuan ==1) {
        methodName=@"USER-LIST-PAGE";
        userType = @"USERTYPE";
        resultKey = @"USERLISTINFO";
    }else if (self.shaixuan ==2){
        methodName=@"BUILDING-LIST-PAGE";
        userType = @"BUILDINGTYPE";
        resultKey = @"BUILDINGLISTINFO";
    }else if (self.shaixuan==3){
        methodName=@"MERCHANT-LIST-PAGE";
        userType = @"COMPANYTYPE";
        resultKey = @"COMPANYLISTINFO";
    }else if (self.shaixuan ==4){
        methodName=@"COMPANY-LIST-PAGE";
        userType = @"COMPANYTYPE";
        resultKey = @"COMPANYLISTINFO";
    }
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%@",[self.m_array objectAtIndex:0]] forKey:userType];
    [params setValue:methodName forKey:@"JUDGEMETHOD"];
    [params setValue:[NSString stringWithFormat:@"%d",page] forKey:@"GETTIMES"];
    hessianrequest.postData =  params;
    [hessianrequest setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            newList = [result objectForKey:resultKey];
            for (NSInteger i=0; i<newList.count; i++) {
                [selectRecordList addObject:@"no"];
            }
            //加载广告列表
            [self loadAdvertisimentList:newList];
            page++;
            [MBProgress hide:YES];
            if (reloadormore) {
                nonAdverCount = 0;
                nonAdverCount+=newList.count;
                [m_newsArray removeAllObjects];
                [m_newsArray addObjectsFromArray:newList];
                reloadormore = NO;
                [self performSelector:@selector(HeaderreloadFinish) withObject:nil afterDelay:0.f];
                return;
            }
            else{
                nonAdverCount+=newList.count;
                [m_newsArray addObjectsFromArray:newList];
                [self performSelector:@selector(FooterreloadFinish) withObject:nil afterDelay:0.f];
                return;
            }
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
    [hessianrequest setFailedBlock:^{
        
        [MBProgress settext:@"网络错误，请检查网络连接！" aftertime:1.0];page--;
        NSLog(@"informationrequestFailed");
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
    [hessianrequest startRequest];
    [hessianrequest release];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return m_newsArray.count+adverArray.count+1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row==0) {
        static NSString *CellIdentifier3 = @"Cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) {
            cell = [[[BannerTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3] autorelease];
        }
        [(BannerTableCell*)cell setCurrController:self.currController];
        [(BannerTableCell*)cell setPlateType:[UserInfo shared].m_plateType];
        [(BannerTableCell*)cell setPlateCode:[self.m_array objectAtIndex:0]];
        [(BannerTableCell*)cell loadContent];
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
        return cell;
    }else{
        if (row%6!=0) {
            NSInteger dataIndex = row-(row/6+1);
            static NSString *CellIdentifier1 = @"Cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                if (self.shaixuan ==1) {
                    cell = [[[DesignerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
                }else if (self.shaixuan ==2){
                    cell = [[[LoupanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
                }else if (self.shaixuan==3){
                    cell = [[[CailiaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
                }else if (self.shaixuan ==4){
                    cell = [[[DesignerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
                }
            }
            if (self.shaixuan ==1) {
                [(DesignerListCell*)cell setCellData:[m_newsArray objectAtIndex:dataIndex] withSelected:selectRecordList withIndex:dataIndex];
            }else if (self.shaixuan ==2){
                [(LoupanCell*)cell setCellData:[m_newsArray objectAtIndex:dataIndex] withSelected:selectRecordList withIndex:dataIndex];
            }else if (self.shaixuan==3){
                [(CailiaoCell*)cell setCellData:[m_newsArray objectAtIndex:dataIndex] withSelected:selectRecordList withIndex:dataIndex];
            }else if (self.shaixuan ==4){
                [(DesignerListCell*)cell setCellData:[m_newsArray objectAtIndex:dataIndex] withSelected:selectRecordList withIndex:dataIndex];
            }
            return cell;
        }else{
            //广告位
            NSInteger dataIndex = row/6-1;
            static NSString *cellIdentific = @"cell2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
                cell.selectionStyle=UITableViewCellSelectionStyleGray;
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(8, 114, applicationwidth-16, 0.5)];
                line.image = [UIImage imageNamed:@"线"];
                [cell.contentView addSubview:line];
                [line release];
                
                UILabel *slogenLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 300, 25)];
                slogenLabel.font = font(14);
                slogenLabel.tag = 49;
                slogenLabel.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:slogenLabel];
                [slogenLabel release];
                
                UIImageView *works1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, 93.3, 70)];
                works1.tag = 50;
                [cell.contentView addSubview:works1];
                [works1 release];
                
                UIImageView *works2 = [[UIImageView alloc] initWithFrame:CGRectMake(113.3, 35, 93.3, 70)];
                works2.tag = 51;
                [cell.contentView addSubview:works2];
                [works2 release];
                
                UIImageView *works3 = [[UIImageView alloc] initWithFrame:CGRectMake(216.6, 35, 93.3, 70)];
                works3.tag = 52;
                [cell.contentView addSubview:works3];
                [works3 release];
                
            }
            UILabel *slogen = (UILabel*)[cell.contentView viewWithTag:49];
            slogen.text = [NSString stringWithFormat:@"%@",[[adverArray objectAtIndex:dataIndex] objectAtIndex:1]];
            for(NSInteger i=0;i<3;i++){
                UIImageView *worksImage = (UIImageView*)[cell.contentView viewWithTag:(50+i)];
                NSArray *picArray = [[[adverArray objectAtIndex:dataIndex] objectAtIndex:3] componentsSeparatedByString:@"&::&"];
                NSString *imageurl=[NSString stringWithFormat:@"%@",[picArray objectAtIndex:i]];
                [worksImage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_img2"]];
            }
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 160;
    }
    else{
        if (indexPath.row%6==0) {
            return  115;
        }else{
            if (self.shaixuan ==1) {
                return 85;
            }else if (self.shaixuan ==2){
                return 100;
            }else if (self.shaixuan==3){
                return 100;
            }else if (self.shaixuan ==4){
                return 85;
            }
            return 0;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [m_tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==0) {
        //广告
        AdvertisingController *adver = [[AdvertisingController alloc] init];
        adver.hidesBottomBarWhenPushed = YES;
        
    }else{
        NSInteger row = indexPath.row;
        if (row%6!=0) {
            [selectRecordList replaceObjectAtIndex:(row-(row/6+1)) withObject:@"yes"];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [delegate NewsTableViewBtnPressed:[m_newsArray objectAtIndex:(row-(row/6+1))] isAdver:NO];
        }else{
//            [selectRecordList replaceObjectAtIndex:(row/6-1) withObject:@"yes"];
//            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [delegate NewsTableViewBtnPressed:[adverArray objectAtIndex:(row/6-1)] isAdver:YES];
        }
        
    }
}

-(NSInteger)tablewheight
{
    if (m_newsArray.count>0) {
        if (self.shaixuan ==1) {
            return 85*nonAdverCount+115*adverArray.count+160;
        }else if (self.shaixuan ==2){
            return 100*nonAdverCount+115*adverArray.count+160;
        }else if (self.shaixuan==3){
            return 100*nonAdverCount+115*adverArray.count+160;
        }else if (self.shaixuan ==4){
            return 85*nonAdverCount+115*adverArray.count+160;
        }
        return 0;
    }else{
        return 160;
    }
}


- (void)FooterreloadFinish
{
    if (_Headerreloading) {
        [m_tableView reloadData];
        if ([m_newsArray count]==0) {
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
        if ([m_newsArray count]==0) {
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
    [self reloadrequest];
    
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
    [self reloadrequest];
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
