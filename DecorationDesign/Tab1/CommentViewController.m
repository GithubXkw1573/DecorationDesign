//
//  CommentViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/16.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize m_array,m_jsonArr,worksId,worksType,designerId;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor=[UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"标题栏%i.png",[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?7:6]] forBarMetrics:UIBarMetricsDefault];
    
    UIImage *shadowimage=[[UIImage alloc]init];
    self.navigationController.navigationBar.shadowImage = shadowimage;//去掉navigationBar阴影黑线
    [shadowimage release];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"杨家匠";
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
    [leftbtn addTarget:self action:@selector(commentControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    UIView *rightbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 60, 44);
    rightbtn.tag = 2;
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"loup_4_btn.png"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(commentControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightbtnview addSubview:rightbtn];
    
    UIBarButtonItem *myrightitem = [[UIBarButtonItem alloc] initWithCustomView:rightbtnview];
    self.navigationItem.rightBarButtonItem = myrightitem;
    [myrightitem release];
    [rightbtnview release];
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, applicationheight-50-44) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor clearColor];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
    
    [self initBottom];
    
    [self loadRequest];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160)];
    [MBProgress setCenter:CGPointMake(applicationwidth/2.0, applicationheight/2)];
    [self.view addSubview:MBProgress];
//    [MBProgress show:YES];
//    [MBProgress setLabelText:@"刷新中"];
}

-(void)loadRequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"获取中"];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"GET-COMMENTTEXT",@"JUDGEMETHOD",worksId,@"ID", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress setHidden:YES];
            commentNums = [NSString stringWithFormat:@"%@",[result objectForKey:@"COMMENTTEXTNUMS"]];
            NSArray *infolist = [result objectForKey:@"COMMENTTEXTINFO"];
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

-(void)initBottom
{
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, applicationheight-94, applicationwidth, 150)];
    commentView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
    [self.view addSubview:commentView];
    [commentView release];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, .5)];
    line.image = [UIImage imageNamed:@"线"];
    [commentView addSubview:line];
    [line release];
    
    UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 220, 30)];
    inputField.placeholder = @" 我也说两句";
    [inputField setBackground:[UIImage imageNamed:@"PingLun_bg"]];
    inputField.font = font(15);
    commentField = inputField;
    inputField.returnKeyType = UIReturnKeySend;
    inputField.delegate = self;
    [commentView addSubview:inputField];
    [inputField release];
    //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [btnSpace release];
    [doneButton release];
    [topView setItems:buttonsArray];
    [inputField setInputAccessoryView:topView];
    [topView release];
    
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 10, 60, 30)];
    [detailBtn setTitle:@"原 文" forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    detailBtn.backgroundColor = [UIColor clearColor];
    [detailBtn setBackgroundImage:[UIImage imageNamed:@"PingLun_bg_btn"] forState:UIControlStateNormal];
    detailBtn.tag = 23;
    [detailBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:detailBtn];
    [detailBtn release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)commentControllerBtnPressed:(UIButton*)btn
{
    if (btn.tag ==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag ==2){
        //分享
        ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, applicationheight, applicationwidth, 220)];
        [self.view addSubview:shareView];
        [shareView show];
        [shareView release];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3+m_jsonArr.count;
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
            UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
            personTitle.text = @"设计没有好坏之分";
            personTitle.font = font(18);
            [cell.contentView addSubview:personTitle];
            [personTitle release];
            
            UILabel *zuoping = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 80, 20)];
            zuoping.text = @"凯瑞丽";
            zuoping.backgroundColor = [UIColor clearColor];
            zuoping.font = font(13);
            zuoping.textColor = [UIColor grayColor];
            [cell.contentView addSubview:zuoping];
            [zuoping release];
            
            UILabel *zuopingValue = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 120, 20)];
            zuopingValue.text = @"2014-10-1 12:45";
            zuopingValue.textColor = [UIColor grayColor];
            zuopingValue.tag = 11;
            zuopingValue.backgroundColor = [UIColor clearColor];
            zuopingValue.font = font(13);
            [cell.contentView addSubview:zuopingValue];
            [zuopingValue release];
            
            UILabel *jingping = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 90, 20)];
            jingping.text = @"545 评论";
            jingping.backgroundColor = [UIColor clearColor];
            jingping.font = font(13);
            jingping.textColor = [UIColor grayColor];
            [cell.contentView addSubview:jingping];
            [jingping release];
        }
        return cell;
    }else if (row == 1){
        static NSString *cellIdentific = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
            
            UIImageView *fengmian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 300, 120)];
            fengmian.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1.0];
            [cell.contentView addSubview:fengmian];
            [fengmian release];
            
            UIImageView *face1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 60, 60)];
            face1.backgroundColor = [UIColor clearColor];
            face1.image = [UIImage imageNamed:@"Pinglun_img1"];
            [fengmian addSubview:face1];
            [face1 release];
            UILabel *desc1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 30)];
            desc1.font = font(16);
            desc1.tag = 21;
            desc1.textAlignment = UITextAlignmentCenter;
            [fengmian addSubview:desc1];
            [desc1 release];
            
            UIImageView *face2 = [[UIImageView alloc] initWithFrame:CGRectMake(120, 15, 60, 60)];
            face2.backgroundColor = [UIColor clearColor];
            face2.image = [UIImage imageNamed:@"Pinglun_img2"];
            [fengmian addSubview:face2];
            [face2 release];
            UILabel *desc2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 100, 30)];
            desc2.font = font(16);
            desc2.tag = 22;
            desc2.textAlignment = UITextAlignmentCenter;
            [fengmian addSubview:desc2];
            [desc2 release];
            
            UIImageView *face3 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 15, 60, 60)];
            face3.backgroundColor = [UIColor clearColor];
            face3.image = [UIImage imageNamed:@"Pinglun_img3"];
            [fengmian addSubview:face3];
            [face3 release];
            UILabel *desc3 = [[UILabel alloc] initWithFrame:CGRectMake(200, 80, 100, 30)];
            desc3.font = font(16);
            desc3.tag = 23;
            desc3.textAlignment = UITextAlignmentCenter;
            [fengmian addSubview:desc3];
            [desc3 release];
        }
        UILabel *desc1 = (UILabel*)[cell.contentView viewWithTag:21];
        UILabel *desc2 = (UILabel*)[cell.contentView viewWithTag:22];
        UILabel *desc3 = (UILabel*)[cell.contentView viewWithTag:23];
        desc1.text = [NSString stringWithFormat:@"%d 满意",123];
        desc2.text = [NSString stringWithFormat:@"%d 基本满意",123];
        desc3.text = [NSString stringWithFormat:@"%d 不满意",123];
        return cell;
    }
    else if (row == 2){
        static NSString *cellIdentific = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.frame = CGRectMake(10, 0, 300, 40);
            
            UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 18, 26.5)];
            logo.image = [UIImage imageNamed:@"Pinglun_img4"];
            [cell.contentView addSubview:logo];
            [logo release];
            
            UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(28, 10, 160, 20)];
            personTitle.text =[NSString stringWithFormat:@"最新评论(%@)",commentNums];
            personTitle.font = font(18);
            personTitle.textColor = [UIColor grayColor];
            [cell.contentView addSubview:personTitle];
            [personTitle release];
        }
        
        return cell;
    }
    else{
        static NSString *cellIdentific = @"cell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = (CommentCell*)[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        [(CommentCell*)cell setCell:[m_jsonArr objectAtIndex:(row-3)] withRow:row];
        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row==0) {
        return 80;
    }else if (row==1){
        return 150;
    }else if (row==2){
        return 40;
    }else{
        CommentCell *cell = (CommentCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [cell cellHeight];
    }
    return 0;
}

-(void)buttonClicked:(UIButton*)btn
{
    
}

-(void)dismissKeyBoard
{
    [self.view endEditing:YES];
    [self movoTo:64];
}

-(CGFloat)cellHeight:(NSInteger)index
{
    NSString *content = [m_array objectAtIndex:index];
    CGSize size = [content sizeWithFont:font(13) constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self movoTo:-200];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //发送
    if (![commentField.text isEqualToString:@""]) {
        [self startCommonrequest];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论不能为空!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    [textField resignFirstResponder];
    [self movoTo:64];
    return YES;
}


-(void)startCommonrequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"评论中..."];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"CUSTOM-COMMENTTEXT",@"JUDGEMETHOD",worksId,@"ID",[UserInfo shared].m_Id,@"USERID",designerId,@"COMMENTEDID",worksType,@"WORKSTYPE",@"1",@"COMMENTTYPE",commentField.text,@"COMMENT",[UserInfo shared].m_session,@"SESSION", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress settext:@"评论成功!" aftertime:1.0];
            commentField.text = @"";
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

-(void)movoTo:(CGFloat)dh
{
    [UIView animateWithDuration:0.35f animations:^{
        self.view.frame = CGRectMake(0, dh, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self movoTo:64];
}
@end
