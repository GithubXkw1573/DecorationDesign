//
//  SearchViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 15/1/19.
//  Copyright (c) 2015年 许开伟. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize searchList;



- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    
    searchList = [[NSMutableArray alloc] initWithCapacity:0];
    selectRecordList = [[NSMutableArray alloc] init];
    
    UIImageView *searchBackImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 27)];
    searchBackImage.backgroundColor=[UIColor clearColor];
    searchBackImage.userInteractionEnabled = YES;
    searchBackImage.image = [UIImage imageNamed:@"search_03"];
    [PublicFunction addImageTo:searchBackImage Rect:CGRectMake(7, 6, 15, 15) Image:@"search_btn" SEL:nil Responsder:nil Tag:0];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(28, 1, 212, 25)];
    textField.backgroundColor = [UIColor clearColor];
    textField.textColor = [UIColor blackColor];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = font(13);
    if (self.searchType ==1) {
        textField.placeholder = @"设计师姓名";
    }else if (self.searchType ==2){
        textField.placeholder = @"楼盘名称";
    }else if (self.searchType==3){
        textField.placeholder = @"材料商名称";
    }else {
        textField.placeholder = @"装饰公司名称";
    }
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchField = textField;
    
    [searchBackImage addSubview:textField];
    self.navigationItem.titleView=searchBackImage;
    [textField release];
    [searchBackImage release];
    
    UIView *rightview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 50, 44);
    rightbtn.tag=51;
    [rightbtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(NewSearchClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightview addSubview:rightbtn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightview];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    [rightview release];
    
    [self initTableComponent];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)NewSearchClicked:(UIButton*)btn
{
    if (btn.tag == 50) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag ==51)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if (btn.tag ==586)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您将清除历史搜索记录，您确认清除吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = 99;
        [alert show];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (![searchField.text isEqualToString:@""]) {
        page =0;
        reloadormore=YES;
        _Headerreloading = YES;
        [self reloadrequest];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入关键字!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    return YES;
}


-(void)initTableComponent
{
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, applicationwidth, applicationheight-44) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor clearColor];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [m_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:m_tableView];
    [self initEgoRefreshComponent];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    [MBProgress setCenter:CGPointMake(160, applicationheight/2-120)];
    [self.view addSubview:MBProgress];
    [MBProgress hide:NO];
    [MBProgress setLabelText:@"刷新中"];
    
    
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
    NSString *methodName = @"SELECT_DESINGER";
    NSString *userType = @"USERTYPE";
    NSString *resultKey = @"USERLISTINFO";
    if (self.searchType ==1) {
        methodName=@"SELECT_DESINGER";
        userType = @"USERTYPE";
        resultKey = @"USERLISTINFO";
    }else if (self.searchType ==2){
        methodName=@"SELECT_BUILDING";
        userType = @"BUILDINGTYPE";
        resultKey = @"BUILDINGLISTINFO";
    }else if (self.searchType==3){
        methodName=@"SELECT_MERCHANT";
        userType = @"COMPANYTYPE";
        resultKey = @"COMPANYLISTINFO";
    }else if (self.searchType ==4){
        methodName=@"SELECT_COMPANY";
        userType = @"COMPANYTYPE";
        resultKey = @"COMPANYLISTINFO";
    }
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%@",@"1"] forKey:userType];
    [params setValue:searchField.text forKey:@"CONDITION"];
    [params setValue:methodName forKey:@"JUDGEMETHOD"];
    [params setValue:[NSString stringWithFormat:@"%d",page++] forKey:@"GETTIMES"];
    hessianrequest.postData =  params;
    queryListRequest = hessianrequest;
    [hessianrequest setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            newList = [result objectForKey:resultKey];
            for (NSInteger i = 0; i<newList.count; i++) {
                [selectRecordList addObject:@"no"];
            }
            if ([newList count] > 0) {
                [MBProgress hide:YES];
                if (reloadormore) {
                    [searchList removeAllObjects];
                    [searchList addObjectsFromArray:newList];
                    reloadormore = NO;
                    [self performSelector:@selector(HeaderreloadFinish) withObject:nil afterDelay:0.f];
                    return;
                }
                else{
                    [searchList  addObjectsFromArray:newList];
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
                    [searchList removeAllObjects];
                }
                page --;
            }
        }else{
            NSString *errdesc = [NSString stringWithFormat:@"%@",[result objectForKey:@"ERRORDESTRIPTION"]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errdesc delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==99) {
        if (buttonIndex==0) {
            //清除历史记录
            NSMutableArray *record = [NSMutableArray arrayWithArray:searchList];
            [record removeAllObjects];
            [[NSUserDefaults standardUserDefaults] setObject:record forKey:[NSString stringWithFormat:@"merchantSearch%@",[UserInfo shared].m_Id]];
            [searchList removeAllObjects];
            [m_tableView reloadData];
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return searchList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    static NSString *CellIdentifier1 = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (cell == nil) {
        if (self.searchType ==1) {
            cell = [[[DesignerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
        }else if (self.searchType ==2){
            cell = [[[LoupanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
        }else if (self.searchType==3){
            cell = [[[CailiaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
        }else if (self.searchType ==4){
            cell = [[[DesignerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
        }
    }
    
    if (self.searchType ==1) {
        [(DesignerListCell*)cell setCellData:[searchList objectAtIndex:row] withSelected:selectRecordList withIndex:row];
    }else if (self.searchType ==2){
        [(LoupanCell*)cell setCellData:[searchList objectAtIndex:row] withSelected:selectRecordList withIndex:row];
    }else if (self.searchType==3){
        [(CailiaoCell*)cell setCellData:[searchList objectAtIndex:row] withSelected:selectRecordList withIndex:row];
    }else if (self.searchType ==4){
        [(DesignerListCell*)cell setCellData:[searchList objectAtIndex:row] withSelected:selectRecordList withIndex:row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchType ==1) {
        return 80;
    }else if (self.searchType ==2){
        return 100;
    }else if (self.searchType==3){
        return 100;
    }else if (self.searchType ==4){
        return 80;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [m_tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *dic=[searchList objectAtIndex:indexPath.row];
    NSInteger row = indexPath.row;
    [selectRecordList replaceObjectAtIndex:row withObject:@"yes"];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    if ([[UserInfo shared].m_plateType isEqualToString:@"S"]) {
        DesignerViewController *designer = [[DesignerViewController alloc] init];
        designer.m_array = dic;
        designer.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:designer animated:YES];
        [designer release];
    }else if ([[UserInfo shared].m_plateType isEqualToString:@"J"]){
        CompanyViewController *company = [[CompanyViewController alloc] init];
        company.m_array = dic;
        company.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:company animated:YES];
        [company release];
    }else if ([[UserInfo shared].m_plateType isEqualToString:@"C"]){
        CailiaoViewController *cailiao = [[CailiaoViewController alloc] init];
        cailiao.m_array = dic;
        cailiao.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:cailiao animated:YES];
        [cailiao release];
    }else if ([[UserInfo shared].m_plateType isEqualToString:@"L"]){
        LoupanViewController *loupan = [[LoupanViewController alloc]init];
        loupan.m_array = dic;
        loupan.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:loupan animated:YES];
        [loupan release];
    }
}

-(NSInteger)tablewheight
{
    if (self.searchType ==1) {
        return 80*searchList.count;
    }else if (self.searchType ==2){
        return 100*searchList.count;
    }else if (self.searchType==3){
        return 100*searchList.count;
    }else if (self.searchType ==4){
        return 80*searchList.count;
    }
    return 0;
}


- (void)FooterreloadFinish
{
    if (_Headerreloading) {
        [m_tableView reloadData];
        if ([searchList count]==0) {
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
        if ([searchList count]==0) {
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
