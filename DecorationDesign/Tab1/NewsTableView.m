//
//  NewsTableView.m
//  TGQ2
//
//  Created by 许开伟 on 14-8-22.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "NewsTableView.h"

@implementation NewsTableView
@synthesize m_newsArray;
@synthesize delegate;
@synthesize shaixuan;
@synthesize m_array;
@synthesize m_tableView;
@synthesize m_Dictionary;
@synthesize m_recommdArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_newsArray = [[NSMutableArray alloc] initWithCapacity:1];
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

-(void)reloadrequest
{
    NSURL *url=[NSURL URLWithString:[MineURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    HessianFormDataRequest *hessianrequest=[[HessianFormDataRequest alloc] initWithURL:url];
//    NSLog(@"HHH:%@",[Dictionary objectForKey:@"id"]);
    NSString *methodName = @"USER-LIST-PAGE";
    NSString *userType = @"USERTYPE";
    NSString *resultKey = @"USERLISTINFO";
    if (self.shaixuan ==1) {
        methodName=@"USER-LIST-PAGE";
        userType = @"USERTYPE";
        resultKey = @"USERLISTINFO";
    }else if (self.shaixuan ==2){
        methodName=@"USER-LIST-PAGE";
        userType = @"USERTYPE";
        resultKey = @"USERLISTINFO";
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
    [params setValue:[NSString stringWithFormat:@"%d",page++] forKey:@"GETTIMES"];
    hessianrequest.postData =  params;
    myrequest = hessianrequest;
    [hessianrequest setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            newList = [result objectForKey:resultKey];
            
            if ([newList count] > 0) {
                [MBProgress hide:YES];
                if (reloadormore) {
                    [m_newsArray removeAllObjects];
                    [m_newsArray addObjectsFromArray:newList];
                    reloadormore = NO;
                    [self performSelector:@selector(HeaderreloadFinish) withObject:nil afterDelay:0.f];
                    return;
                }
                else{
                    [m_newsArray  addObjectsFromArray:newList];
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
                    [m_newsArray removeAllObjects];
                }
                page --;
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
        
        [MBProgress settext:@"网络错误，请检查网络连接！" aftertime:1.0];
        page--;
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
    return m_newsArray.count*2+1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row==0) {
        static NSString *CellIdentifier3 = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) {
            cell = [[[BannerTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3] autorelease];
        }
        [(BannerTableCell*)cell setPlateType:[UserInfo shared].m_plateType];
        [(BannerTableCell*)cell setPlateCode:[self.m_array objectAtIndex:0]];
        [(BannerTableCell*)cell loadContent];
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
        return cell;
    }else{
        if (row%2==0) {
            static NSString *CellIdentifier3 = @"Cell0";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3] autorelease];
            }
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
            return cell;
        }
        else{
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
                [(DesignerListCell*)cell setCellData:[m_newsArray objectAtIndex:row/2]];
            }else if (self.shaixuan ==2){
                [(LoupanCell*)cell setCellData:[m_newsArray objectAtIndex:row/2]];
            }else if (self.shaixuan==3){
                [(CailiaoCell*)cell setCellData:[m_newsArray objectAtIndex:row/2]];
            }else if (self.shaixuan ==4){
                [(DesignerListCell*)cell setCellData:[m_newsArray objectAtIndex:row/2]];
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
        if (indexPath.row%2==0) {
            return  10;
        }else{
            if (self.shaixuan ==1) {
                return 80;
            }else if (self.shaixuan ==2){
                return 100;
            }else if (self.shaixuan==3){
                return 100;
            }else if (self.shaixuan ==4){
                return 80;
            }
            return 0;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [m_tableView deselectRowAtIndexPath:indexPath animated:NO];
    //[delegate NewsTableViewBtnPressed:0];
    [delegate NewsTableViewBtnPressed:[m_newsArray objectAtIndex:indexPath.row/2]];
}

-(NSInteger)tablewheight
{
    if (m_newsArray.count>0) {
        if (self.shaixuan ==1) {
            return 90*m_newsArray.count+160;
        }else if (self.shaixuan ==2){
            return 110*m_newsArray.count+160;
        }else if (self.shaixuan==3){
            return 110*m_newsArray.count+160;
        }else if (self.shaixuan ==4){
            return 90*m_newsArray.count+160;
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
