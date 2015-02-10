//
//  DetailViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/17.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize m_array,m_jsonArr,method,designer,designerId,worksId;


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
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.tag = 101;
    titlelabel.text=@"作品详情";
    titlelabel.textAlignment=UITextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-20, 0, 60, 44);
    leftbtn.tag=1;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(detailViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, applicationheight-50-44) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor clearColor];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160)];
    [MBProgress setCenter:CGPointMake(applicationwidth/2.0, applicationheight/2)];
    [self.view addSubview:MBProgress];
    [MBProgress show:YES];
    [MBProgress setLabelText:@"刷新中"];
    
    [self loadRequest];
    
    [self initBottom:[m_jsonArr objectAtIndex:0]];
}

-(void)initBottom:(NSString *)type
{
    if ([type isEqualToString:@"Z"] || [type isEqualToString:@"z"] || [type isEqualToString:@"1"]) {
        //作品
        UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, applicationheight-94, applicationwidth, 50)];
        commentView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
        [self.view addSubview:commentView];
        [commentView release];
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, .5)];
        line.image = [UIImage imageNamed:@"线"];
        [commentView addSubview:line];
        [line release];
        
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"ZP_tab_icon1",@"image",@"提问", @"text",nil];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"ZP_tab_icon2",@"image",@"评论", @"text",nil];
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"ZP_tab_icon3",@"image",@"分享", @"text",nil];
        NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"ZP_tab_icon4",@"image",@"预约", @"text",nil];
        NSMutableArray *list = [NSMutableArray arrayWithObjects:dic1,dic2,dic3,dic4, nil];
        [self createButtons:list addTo:commentView];
        
    }else{
        //博文
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
        inputField.returnKeyType = UIReturnKeySend;
        inputField.delegate = self;
        commentField = inputField;
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
        [detailBtn setTitle:[NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:4]] forState:UIControlStateNormal];
        [detailBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        detailBtn.backgroundColor = [UIColor clearColor];
        detailBtn.titleLabel.font = font(13);
        [detailBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        [detailBtn setBackgroundImage:[UIImage imageNamed:@"pinglun_btn_bg_03"] forState:UIControlStateNormal];
        detailBtn.tag = 23;
        [detailBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [commentView addSubview:detailBtn];
        [detailBtn release];
    }
}

-(void)createButtons:(NSArray*)list addTo:(UIView*)commentView
{
    for(int i=0;i<list.count;i++)
    {
        UIImageView *imge1 = [[UIImageView alloc] initWithFrame:CGRectMake(30+80*i, 10, 20, 20)];
        imge1.image = [UIImage imageNamed:[[list objectAtIndex:i] objectForKey:@"image"]];
        imge1.backgroundColor = [UIColor clearColor];
        [commentView addSubview:imge1];
        [imge1 release];
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(80*i, 30, 80, 20)];
        lbl1.text = [[list objectAtIndex:i] objectForKey:@"text"];
        lbl1.textColor = [UIColor grayColor];
        lbl1.font = font(12);
        lbl1.textAlignment = UITextAlignmentCenter;
        lbl1.backgroundColor = [UIColor clearColor];
        [commentView addSubview:lbl1];
        [lbl1 release];
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(80*i, 0, 80, 50)];
        btn1.backgroundColor = [UIColor clearColor];
        btn1.tag = 200+i;
        [btn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [commentView addSubview:btn1];
        [btn1 release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)detailViewControllerBtnPressed:(UIButton*)btn
{
    if (btn.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag ==2){
        
    }
}

-(void)openQuestion
{
    //新建一个遮罩层
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    zhezhaoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, applicationheight)];
    zhezhaoView.userInteractionEnabled = YES;
    [zhezhaoView addGestureRecognizer:tap];
    [tap release];
    zhezhaoView.image = [UIImage imageNamed:@"黑色半透明"];
    
    [self.view addSubview:zhezhaoView];
    
    //新建一个view
    shuomingView = [[UIView alloc] initWithFrame:CGRectMake(40, 100, 240, 165)];
    shuomingView.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0f];
    shuomingView.layer.borderWidth = 1.0f;
    shuomingView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    shuomingView.alpha = 1;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 180, 30)];
    titleLabel.text = @"提问";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = font(18);
    titleLabel.textColor = [UIColor redColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [shuomingView addSubview:titleLabel];
    [titleLabel release];
    
    UIButton *closebtn = [[UIButton alloc] initWithFrame:CGRectMake(210, 0, 30, 30)];
    [closebtn setBackgroundImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    closebtn.backgroundColor = [UIColor clearColor];
    [closebtn addTarget:self action:@selector(shuomingBtnCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [shuomingView addSubview:closebtn];
    [closebtn release];
    
    UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 240, 1)];
    lineimage.image=[UIImage imageNamed:@"线.png"];
    [shuomingView addSubview:lineimage];
    [lineimage release];
    
    contentView = [[UITextView alloc] initWithFrame:CGRectMake(10, 31, 220, 100)];
    contentView.text = @"有什么问题都可以这里咨询我吧...";
    contentView.textColor = [UIColor grayColor];
    contentView.font = font(14);
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.delegate = self;
    contentView.returnKeyType = UIReturnKeyDone;
    [shuomingView addSubview:contentView];
    [contentView release];
    
    UIButton *quxioaBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, 135, 50, 25)];
    [quxioaBtn setBackgroundImage:[UIImage imageNamed:@"index_btn2"]  forState:UIControlStateNormal];
    [quxioaBtn setTitle:@"取消" forState:UIControlStateNormal];
    [quxioaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    quxioaBtn.titleLabel.font = font(14);
    quxioaBtn.layer.cornerRadius = 4;
    quxioaBtn.layer.masksToBounds = YES;
    quxioaBtn.tag = 4544;
    [quxioaBtn addTarget:self action:@selector(sumbmit:) forControlEvents:UIControlEventTouchUpInside];
    [shuomingView addSubview:quxioaBtn];
    [quxioaBtn release];
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(155, 135, 50, 25)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"index_btn7"]  forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = font(14);
    submitBtn.layer.cornerRadius = 4;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.tag = 4545;
    [submitBtn addTarget:self action:@selector(sumbmit:) forControlEvents:UIControlEventTouchUpInside];
    [shuomingView addSubview:submitBtn];
    [submitBtn release];
    
    shuomingView.alpha = 0;
    zhezhaoView.alpha = 0;
    zhezhaoView.transform = CGAffineTransformMakeScale(1.3, 1.3) ;
    [UIView animateWithDuration:.35f animations:^{
        shuomingView.alpha = 1;
        zhezhaoView.alpha = 1;
        zhezhaoView.transform = CGAffineTransformMakeScale(1, 1) ;
    } completion:^(BOOL flag){
        
    }];
    
    [zhezhaoView addSubview:shuomingView];
    [zhezhaoView bringSubviewToFront:shuomingView];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    [self movoTo:-40];
    textView.textColor = [UIColor blackColor];
    return YES;
}

-(void)shuomingBtnCloseBtn:(UIButton*)btn
{
    
    [self dismissWithAnimated:1];
}

-(void)sumbmit:(UIButton*)btn
{
    
    if (btn.tag == 4544) {
        //取消
        
    }else if (btn.tag == 4545){
        //提交
        [self startQuestionrequest];
    }
    [self dismissWithAnimated:2];
}

-(void)startQuestionrequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"发送中..."];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"CUSTOM-QUESTION",@"JUDGEMETHOD",worksId,@"WORKSID",[UserInfo shared].m_Id,@"USERID",[m_jsonArr objectAtIndex:0],@"WORKSTYPE",contentView.text,@"QUESTION",[UserInfo shared].m_session,@"SESSION", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的提问已成功，我们会尽快回答您！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }else {
            [MBProgress hide:YES];
            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
            NSLog(@"%@",errrDesc);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errrDesc delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }];
    [request setFailedBlock:^{
        NSLog(@"网络错误");
        [MBProgress settext:@"网络错误!" aftertime:1.0];
    }];
    [request startRequest];
}

-(void)dismissWithAnimated:(NSInteger)type{
    if (type ==1) {
        shuomingView.alpha = 1;
        zhezhaoView.alpha = 1;
        [UIView animateWithDuration:.35f animations:^{
            shuomingView.alpha = 0;
            zhezhaoView.alpha = 0;
            zhezhaoView.transform = CGAffineTransformMakeScale(1.3, 1.3) ;
        } completion:^(BOOL flag){
            for (UIView *v in shuomingView.subviews) {
                [v removeFromSuperview];
            }
            [shuomingView removeFromSuperview];
            [zhezhaoView removeFromSuperview];
            [self movoTo:64];
        }];
    }else{
        shuomingView.alpha = 1;
        zhezhaoView.alpha = 1;
        [UIView animateWithDuration:.35f animations:^{
            shuomingView.alpha = 0;
            zhezhaoView.alpha = 0;
        } completion:^(BOOL flag){
            for (UIView *v in shuomingView.subviews) {
                [v removeFromSuperview];
            }
            [shuomingView removeFromSuperview];
            [zhezhaoView removeFromSuperview];
            [self movoTo:64];
        }];
    }
}

-(void)tap:(id)sender
{
    [self dismissWithAnimated:1];
}

-(void)buttonClicked:(UIButton*)btn
{
    if (btn.tag == 200) {
        //提问
        if ([UserInfo shared].m_isLogin) {
            [self openQuestion];
        }else{
            LoginViewController *login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            [login release];
        }
    }else if (btn.tag == 201){
        //评论
        if ([UserInfo shared].m_isLogin) {
            CommentViewController *comment = [[CommentViewController alloc] init];
            comment.designerId = designerId;
            comment.designerName = designer;
            comment.worksId = worksId;
            comment.commentNums = [m_jsonArr objectAtIndex:3];
            comment.worksDate = [m_jsonArr objectAtIndex:2];
            comment.commentTitle = [m_jsonArr objectAtIndex:1];
            comment.worksType = [m_jsonArr objectAtIndex:0];
            [self.navigationController pushViewController:comment animated:YES];
            [comment release];
        }else{
            LoginViewController *login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            [login release];
        }
        
    }else if (btn.tag == 202){
        //分享
        ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, applicationheight, applicationwidth, 220)];
        [self.view addSubview:shareView];
        [shareView show];
        [shareView release];
    }else if (btn.tag == 203){
        //预约
        if ([UserInfo shared].m_isLogin) {
            BookingViewController *book = [[BookingViewController alloc] init];
            book.designerId=designerId;
            book.designerName = designer;
            [self.navigationController pushViewController:book animated:YES];
            [book release];
        }else{
            LoginViewController *login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            [login release];
        }
    }else if (btn.tag ==23){
        //评论页
        if ([UserInfo shared].m_isLogin) {
            CommentViewController *comment = [[CommentViewController alloc] init];
            comment.designerId = designerId;
            comment.designerName = designer;
            comment.worksId = worksId;
            comment.commentNums = [m_jsonArr objectAtIndex:3];
            comment.worksDate = [m_jsonArr objectAtIndex:2];
            comment.commentTitle = [m_jsonArr objectAtIndex:1];
            comment.worksType = [m_jsonArr objectAtIndex:0];
            [self.navigationController pushViewController:comment animated:YES];
            [comment release];
        }else{
            LoginViewController *login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            [login release];
        }
    }
}

-(void)loadRequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"获取中"];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    if ([self.method isEqualToString:@"BUILDING-WAYACT-INFO"]) {
        request.postData = [NSDictionary dictionaryWithObjectsAndKeys:self.method,@"JUDGEMETHOD",[m_array objectAtIndex:3],@"CONTENTID", nil];
        self.worksId = [m_array objectAtIndex:3];
    }else{
        request.postData = [NSDictionary dictionaryWithObjectsAndKeys:self.method,@"JUDGEMETHOD",[m_array objectAtIndex:0],@"WORKSID", nil];
        self.worksId = [m_array objectAtIndex:0];
    }
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress setHidden:YES];
            NSString *resultKey = @"DESIGNERTHREEPAGE";
            if ([[UserInfo shared].m_plateType isEqualToString:@"S"]) {
                resultKey = @"DESIGNERTHREEPAGE";
            }else if ([[UserInfo shared].m_plateType isEqualToString:@"J"]){
                resultKey = @"COMPANYTHREEPAGE";
            }else if ([[UserInfo shared].m_plateType isEqualToString:@"C"]){
                resultKey = @"DESIGNERTHREEPAGE";
            }else if ([[UserInfo shared].m_plateType isEqualToString:@"L"]){
                resultKey = @"DESIGNERTHREEPAGE";
            }
            if ([self.method isEqualToString:@"BUILDING-WAYACT-INFO"]){
                resultKey = @"BUILDINGWAYACT";
            }
            NSArray *infolist = [result objectForKey:resultKey];
            self.m_jsonArr = infolist;
            UILabel *titleLabel = (UILabel*)self.navigationItem.titleView;
            if ([self.method isEqualToString:@"BUILDING-WAYACT-INFO"]){
                titleLabel.text = [[m_jsonArr objectAtIndex:0] isEqualToString:@"1"]?@"方案详情":@"活动详情";
            }else{
                titleLabel.text = [[m_jsonArr objectAtIndex:0] isEqualToString:@"Z"]?@"作品详情":@"博文详情";
                UIButton *detailBtn = (UIButton*)[self.view viewWithTag:23];
                [detailBtn setTitle:[NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:3]] forState:UIControlStateNormal];
            }
            
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.method isEqualToString:@"BUILDING-WAYACT-INFO"]){
        
        return m_jsonArr.count-4;
    }else{
        return m_jsonArr.count-3;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if ([self.method isEqualToString:@"BUILDING-WAYACT-INFO"]) {
        startIndex =row+4;
    }
    else{
        startIndex = row+3;
    }
    if (row == 0) {
        static NSString *cellIdentific = @"cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
            personTitle.text = @"设计没有好坏之分";
            personTitle.font = font(18);
            personTitle.tag = 10;
            [cell.contentView addSubview:personTitle];
            [personTitle release];
            
            UILabel *zuoping = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 120, 20)];
            zuoping.text =[NSString stringWithFormat:@"%@",self.designer];
            zuoping.backgroundColor = [UIColor clearColor];
            zuoping.font = font(13);
            zuoping.tag = 11;
            zuoping.textColor = [UIColor grayColor];
            [cell.contentView addSubview:zuoping];
            [zuoping release];
            
            UILabel *zuopingValue = [[UILabel alloc] initWithFrame:CGRectMake(140, 50, 80, 20)];
            zuopingValue.text = @"2014-10-1 12:45";
            zuopingValue.textColor = [UIColor grayColor];
            zuopingValue.tag = 12;
            zuopingValue.backgroundColor = [UIColor clearColor];
            zuopingValue.font = font(13);
            [cell.contentView addSubview:zuopingValue];
            [zuopingValue release];
            
            UILabel *jingping = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 90, 20)];
            jingping.text = @"545 评论";
            jingping.backgroundColor = [UIColor clearColor];
            jingping.font = font(13);
            jingping.tag = 13;
            jingping.textColor = [UIColor grayColor];
            [cell.contentView addSubview:jingping];
            [jingping release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 300, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
        }
        UILabel *lbl0 = (UILabel*)[cell.contentView viewWithTag:10];
        UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:11];
        UILabel *lbl2 = (UILabel*)[cell.contentView viewWithTag:12];
        UILabel *lbl3 = (UILabel*)[cell.contentView viewWithTag:13];
        NSString *timeStr = [self returnFormatTime:[NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:2]]];
        lbl3.text = [NSString stringWithFormat:@"%@ 评论",[m_jsonArr objectAtIndex:3]];
        if ([self.method isEqualToString:@"BUILDING-WAYACT-INFO"]) {
            timeStr = [self returnFormatTime:[NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:3]]];
            lbl3.text = [NSString stringWithFormat:@"%@ 评论",[m_jsonArr objectAtIndex:4]];
        }
        lbl0.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:1]];
        CGSize size = [nameLabel.text sizeWithFont:font(13) constrainedToSize:CGSizeMake(150, 20) lineBreakMode:NSLineBreakByWordWrapping];
        nameLabel.frame = CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y, size.width, nameLabel.frame.size.height);
        lbl2.frame = CGRectMake(20+size.width, lbl2.frame.origin.y, lbl2.frame.size.width, lbl2.frame.size.height);
        lbl3.frame = CGRectMake(100+size.width, lbl3.frame.origin.y, lbl3.frame.size.width, lbl3.frame.size.height);
        lbl2.text = [NSString stringWithFormat:@"%@",timeStr];
        
        return cell;
    }else{
        if ([self isShowText:row]) {
            static NSString *cellIdentific1 = @"cell_label";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific1];
            if (cell == nil) {
                cell = [[[LabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific1] autorelease];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            }
            [(LabelCell*)cell setContentwithText:[[m_jsonArr objectAtIndex:startIndex] substringFromIndex:2]];
            return cell;
        }else{
            NSString *cellIdentific2 = [NSString stringWithFormat:@"cell%li",row];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific2];
            if (cell == nil) {
                cell = [[[ImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific2] autorelease];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            [(ImageCell*)cell setContentImage:[[m_jsonArr objectAtIndex:startIndex] substringFromIndex:2]];
            return cell;
        }
    }
    return nil;
}

-(NSString*)returnFormatTime:(NSString *)timeStr
{
    NSString *month = [timeStr substringWithRange:NSMakeRange (4, 2)];
    NSString *day =[timeStr substringWithRange:NSMakeRange (6, 2)];
    NSString *hour = [timeStr substringWithRange:NSMakeRange (8, 2)];
    NSString *minit=@"00";
    if (timeStr.length>=12) {
        minit = [timeStr substringWithRange:NSMakeRange (10, 2)];
    }
    return [NSString stringWithFormat:@"%@-%@ %@:%@",month,day,hour,minit];
}

-(BOOL)isShowText:(NSInteger)row
{
    if ([self.method isEqualToString:@"BUILDING-WAYACT-INFO"]) {
        startIndex =row+4;
    }
    else{
        startIndex = row+3;
    }
    if ([[[m_jsonArr objectAtIndex:startIndex] substringToIndex:1] isEqualToString:@"0"]) {
        
        return YES;
    }else{
        return NO;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =indexPath.row;
    if (row==0) {
        return 90;
    }else{
        if ([self isShowText:row]) {
            LabelCell *cell = (LabelCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            return [cell cellHeight];
        }else{
            ImageCell *cell = (ImageCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            return [cell cellHeight];
        }
    }
    return 0;
}

-(void)dismissKeyBoard
{
    [self.view endEditing:YES];
    [self movoTo:64];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([UserInfo shared].m_isLogin) {
        [self movoTo:-200];
        return YES;
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        [login release];
        return NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //发送
    if (![commentField.text isEqualToString:@""]) {
        [self startCommonrequest];
        [textField resignFirstResponder];
        [self movoTo:64];
        return YES;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入评论内容!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return NO;
    }
}

-(void)startCommonrequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"评论中..."];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"CUSTOM-COMMENTTEXT",@"JUDGEMETHOD",worksId,@"ID",[UserInfo shared].m_Id,@"USERID",designerId,@"COMMENTEDID",[m_jsonArr objectAtIndex:0],@"WORKSTYPE",commentField.text,@"COMMENT",[UserInfo shared].m_session,@"SESSION", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            [self loadRequest];
            [m_tableView reloadData];
            commentField.text = @"";
        }else {
            [MBProgress hide:YES];
            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
            NSLog(@"%@",errrDesc);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errrDesc delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
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
@end
