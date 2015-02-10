//
//  CailiaoDetailController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/25.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "CailiaoDetailController.h"
#import "ShareView.h"
#import "CommentViewController.h"
#import "LoginViewController.h"

@interface CailiaoDetailController ()

@end

@implementation CailiaoDetailController
@synthesize m_array,m_jsonArr,n_jsonArr,l_jsonArr,productId,commentNum;

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
    titlelabel.text=@"产品详情";
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
    [leftbtn addTarget:self action:@selector(cailiaodetailViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    UIView *rightbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(10, 0, 60, 44);
    rightbtn.tag = 2;
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"分享.png"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(cailiaodetailViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
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
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160)];
    [MBProgress setCenter:CGPointMake(applicationwidth/2.0, applicationheight/2)];
    [self.view addSubview:MBProgress];
    [MBProgress show:YES];
    [MBProgress setLabelText:@"刷新中"];
    
    [self loadRequest];
    
    [self initBottom];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)cailiaodetailViewControllerBtnPressed:(UIButton*)btn
{
    if (btn.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag ==2){
        ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, applicationheight, applicationwidth, 220)];
        [self.view addSubview:shareView];
        [shareView show];
        [shareView release];
    }
}

-(void)loadRequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"获取中"];
    NSURL *url = [NSURL URLWithString:MineURL];
    self.productId = [m_array objectAtIndex:1];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"MERCHANT-PRODCUTINFO",@"JUDGEMETHOD",productId,@"PRODUCTID", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress setHidden:YES];
            
            self.m_jsonArr = [result objectForKey:@"GOODSBASEINFO"];
            self.n_jsonArr = [result objectForKey:@"GOODSBASEPARAM"];
            self.l_jsonArr = [result objectForKey:@"GOODSMANYPICTURE"];
            self.commentNum = [result objectForKey:@"COMMENTNUMS"];
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
    return 5;
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
            
            UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 265)];
            pic.backgroundColor = [UIColor clearColor];
            pic.tag = 3;
            [cell.contentView addSubview:pic];
            [pic release];
            
        }
        UIImageView *worksImage = (UIImageView*)[cell.contentView viewWithTag:3];
        [worksImage setImageWithURL:[NSURL URLWithString:[m_jsonArr objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"CAIxiang_img2"]];
        return cell;
    }else if (row == 1){
        static NSString *cellIdentific = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, applicationwidth-10, 40)];
            lbl.backgroundColor = [UIColor clearColor];
            lbl.font = font(15);
            lbl.numberOfLines = 2;
            lbl.tag = 13;
            [cell.contentView addSubview:lbl];
            [lbl release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(5, 59, 310, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
        }
        UILabel *title = (UILabel*)[cell.contentView viewWithTag:13];
        title.text = [m_jsonArr objectAtIndex:1];
        return cell;
    }else if (row == 2){
        static NSString *cellIdentific = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, applicationwidth-10, 25)];
            lbl1.backgroundColor = [UIColor clearColor];
            lbl1.font = font(16);
            lbl1.text = @"基本简介";
            [cell.contentView addSubview:lbl1];
            [lbl1 release];
            
            UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 100, 25)];
            lbl2.backgroundColor = [UIColor clearColor];
            lbl2.font = font(14);
            lbl2.tag = 31;
            lbl2.textColor = [UIColor redColor];
            [cell.contentView addSubview:lbl2];
            [lbl2 release];
            
            UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(105, 35, 80, 25)];
            lbl3.backgroundColor = [UIColor clearColor];
            lbl3.font = font(12);
            lbl3.tag = 32;
            lbl3.textColor = [UIColor grayColor];
            [cell.contentView addSubview:lbl3];
            [lbl3 release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(105, 47.5, 80, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
            
            UIImageView *zhixiao = [[UIImageView alloc] initWithFrame:CGRectMake(260, 38, 50, 15)];
            zhixiao.image = [UIImage imageNamed:@"xlxq_zhixiao_btn"];
            [cell.contentView addSubview:zhixiao];
            [zhixiao release];
            
            UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, applicationwidth-10, 40)];
            desc.backgroundColor = [UIColor clearColor];
            desc.font = font(13);
            desc.tag =33;
            desc.textColor = [UIColor grayColor];
            desc.numberOfLines = 0;
            [cell.contentView addSubview:desc];
            [desc release];
            
        }
        UILabel *lbl1 = (UILabel*)[cell.contentView viewWithTag:31];
        UILabel *lbl2 = (UILabel*)[cell.contentView viewWithTag:32];
        UILabel *desc = (UILabel*)[cell.contentView viewWithTag:33];
        lbl1.text = [NSString stringWithFormat:@"￥%@",[m_jsonArr objectAtIndex:2]];
        lbl2.text = [NSString stringWithFormat:@"￥%@",[m_jsonArr objectAtIndex:3]];
        desc.text = [m_jsonArr objectAtIndex:4];
        CGSize size = [desc.text sizeWithFont:font(13) constrainedToSize:CGSizeMake(310, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        inroduceHeight = size.height;
        desc.frame = CGRectMake(desc.frame.origin.x, desc.frame.origin.y, 310, inroduceHeight) ;
        return cell;
    }else if (row == 3){
        static NSString *cellIdentific = @"cell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
            
            UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, applicationwidth-10, 25)];
            lbl1.backgroundColor = [UIColor clearColor];
            lbl1.font = font(16);
            lbl1.text = @"商品参数";
            [cell.contentView addSubview:lbl1];
            [lbl1 release];
            
            for (int i=0; i<[n_jsonArr count]; i++) {
                UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 35+18*i, applicationwidth-10, 18)];
                lbl.backgroundColor = [UIColor clearColor];
                lbl.font = font(13);
                lbl.tag = 40+i;
                [cell.contentView addSubview:lbl];
                [lbl release];
            }
        }
        for (int i=0; i<[n_jsonArr count]; i++) {
            UILabel *lbl = (UILabel*)[cell.contentView viewWithTag:(40+i)];
            lbl.text = [NSString stringWithFormat:@"%@",[n_jsonArr objectAtIndex:i]];
        }
        return cell;
    }else if (row == 4){
        static NSString *cellIdentific = @"cell4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
            
            UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 310, 25)];
            lbl1.backgroundColor = [UIColor clearColor];
            lbl1.font = font(16);
            lbl1.text = @"商品图片";
            [cell.contentView addSubview:lbl1];
            [lbl1 release];
            
            for (int i=0; i<[l_jsonArr count]; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+105*i, 40, 100, 70)];
                imageView.tag = 300+i;
                imageView.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:imageView];
                [imageView release];
            }
            
            UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 119, 310, 1)];
            line2.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line2];
            [line2 release];
        }
        for (int i=0; i<[l_jsonArr count]; i++) {
            UIImageView *lbl = (UIImageView*)[cell.contentView viewWithTag:(300+i)];
            [lbl setImageWithURL:[NSURL URLWithString:[l_jsonArr objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"xlxq_img2"]];
        }
        return cell;
    }
    return nil;
}

-(CGFloat)cellHeight
{
    NSString *content = [m_jsonArr objectAtIndex:4];
    CGSize size = [content sizeWithFont:font(13) constrainedToSize:CGSizeMake(310, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =indexPath.row;
    if (row==0) {
        return 265;
    }else if (row==1){
        return 60;
    }else if (row==2){
        return 70+[self cellHeight];
    }
    else if (row==3){
        return 40+18*[n_jsonArr count];
    }
    else if (row==4){
        return 120;
    }
    return 0;
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
    textField = inputField;
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
    [detailBtn setTitle:[NSString stringWithFormat:@"%@",commentNum] forState:UIControlStateNormal];
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

-(void)buttonClicked:(UIButton*)btn
{
    if (btn.tag == 23) {
        //跳转评论页
        if ([UserInfo shared].m_isLogin) {
            CommentViewController *comment = [[CommentViewController alloc] init];
            comment.designerId = self.cailiaomerchantId;
            comment.designerName = self.cailiaomerchant;
            comment.worksId = productId;
            comment.worksDate = @"20150215102323";
            comment.commentTitle = [m_jsonArr objectAtIndex:1];
            comment.commentNums = commentNum;
            comment.worksType = @"C";
            [self.navigationController pushViewController:comment animated:YES];
            [comment release];
        }else{
            LoginViewController *login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            [login release];
        }
    }
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

-(BOOL)textFieldShouldReturn:(UITextField *)_textField
{
    //发送
    if (![textField.text isEqualToString:@""]) {
        [self startCommonrequest];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    [_textField resignFirstResponder];
    [self movoTo:64];
    return YES;
}

-(void)movoTo:(CGFloat)dh
{
    [UIView animateWithDuration:0.35f animations:^{
        self.view.frame = CGRectMake(0, dh, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}

-(void)startCommonrequest
{
    if ([UserInfo shared].m_isLogin) {
        [MBProgress show:YES];
        [MBProgress setLabelText:@"评论中..."];
        NSURL *url = [NSURL URLWithString:MineURL];
        HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
        request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"CUSTOM-COMMENTTEXT",@"JUDGEMETHOD",productId,@"ID",[UserInfo shared].m_Id,@"USERID",self.cailiaomerchantId,@"COMMENTEDID",@"",@"WORKSTYPE",textField.text,@"COMMENT",[UserInfo shared].m_session,@"SESSION", nil];
        [request setCompletionBlock:^(NSDictionary *result){
            if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
                //调用成功
                [MBProgress hide:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                textField.text = @"";
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
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        [login release];
    }
}

@end
