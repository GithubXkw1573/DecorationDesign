//
//  CailiaoDetailController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/25.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "CailiaoDetailController.h"

@interface CailiaoDetailController ()

@end

@implementation CailiaoDetailController
@synthesize m_array,m_jsonArr;

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
    leftbtn.frame=CGRectMake(-10, 0, 60, 44);
    leftbtn.tag=1;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(cailiaodetailViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
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
    
    //[self loadRequest];
    
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
        
    }
}

//-(void)loadRequest
//{
//    [MBProgress show:YES];
//    [MBProgress setLabelText:@"获取中"];
//    NSURL *url = [NSURL URLWithString:MineURL];
//    self.worksId = [m_array objectAtIndex:0];
//    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
//    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:self.method,@"JUDGEMETHOD",[m_array objectAtIndex:0],@"WORKSID", nil];
//    [request setCompletionBlock:^(NSDictionary *result){
//        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
//            //调用成功
//            [MBProgress setHidden:YES];
//            NSString *resultKey = @"DESIGNERTHREEPAGE";
//            if ([[UserInfo shared].m_plateType isEqualToString:@"S"]) {
//                resultKey = @"DESIGNERTHREEPAGE";
//            }else if ([[UserInfo shared].m_plateType isEqualToString:@"J"]){
//                resultKey = @"COMPANYTHREEPAGE";
//            }else if ([[UserInfo shared].m_plateType isEqualToString:@"C"]){
//                resultKey = @"DESIGNERTHREEPAGE";
//            }else if ([[UserInfo shared].m_plateType isEqualToString:@"L"]){
//                resultKey = @"DESIGNERTHREEPAGE";
//            }
//            NSArray *infolist = [result objectForKey:resultKey];
//            self.m_jsonArr = infolist;
//            UILabel *titleLabel = (UILabel*)self.navigationItem.titleView;
//            titleLabel.text = [[m_jsonArr objectAtIndex:0] isEqualToString:@"Z"]?@"作品详情":@"博文详情";
//            UIButton *detailBtn = (UIButton*)[self.view viewWithTag:23];
//            [detailBtn setTitle:[NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:3]] forState:UIControlStateNormal];
//        }else {
//            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
//            NSLog(@"%@",errrDesc);
//            [MBProgress settext:errrDesc aftertime:1.0];
//        }
//    }];
//    [request setFailedBlock:^{
//        NSLog(@"网络错误");
//        [MBProgress settext:@"网络错误!" aftertime:1.0];
//    }];
//    [request startRequest];
//}

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
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
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
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, applicationwidth-10, 40)];
            lbl.backgroundColor = [UIColor clearColor];
            lbl.font = font(15);
            lbl.numberOfLines = 2;
            lbl.tag = 13;
            [cell.contentView addSubview:lbl];
            [lbl release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(5, 59, 300, 1)];
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
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 265)];
            pic.backgroundColor = [UIColor clearColor];
            pic.tag = 3;
            [cell.contentView addSubview:pic];
            [pic release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 300, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
        }
        UIImageView *worksImage = (UIImageView*)[cell.contentView viewWithTag:3];
        [worksImage setImageWithURL:[NSURL URLWithString:[m_jsonArr objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"CAIxiang_img2"]];
        return cell;
    }else if (row == 3){
        static NSString *cellIdentific = @"cell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 265)];
            pic.backgroundColor = [UIColor clearColor];
            pic.tag = 3;
            [cell.contentView addSubview:pic];
            [pic release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 300, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
        }
        UIImageView *worksImage = (UIImageView*)[cell.contentView viewWithTag:3];
        [worksImage setImageWithURL:[NSURL URLWithString:[m_jsonArr objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"CAIxiang_img2"]];
        return cell;
    }else if (row == 4){
        static NSString *cellIdentific = @"cell4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 265)];
            pic.backgroundColor = [UIColor clearColor];
            pic.tag = 3;
            [cell.contentView addSubview:pic];
            [pic release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 300, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
        }
        UIImageView *worksImage = (UIImageView*)[cell.contentView viewWithTag:3];
        [worksImage setImageWithURL:[NSURL URLWithString:[m_jsonArr objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"CAIxiang_img2"]];
        return cell;
    }
    return nil;
}

-(NSString*)returnFormatTime:(NSString *)timeStr
{
    NSString *month = [timeStr substringWithRange:NSMakeRange (4, 2)];
    NSString *day =[timeStr substringWithRange:NSMakeRange (6, 2)];
    NSString *hour = [timeStr substringWithRange:NSMakeRange (8, 2)];
    NSString *minit = [timeStr substringWithRange:NSMakeRange (10, 2)];
    return [NSString stringWithFormat:@"%@-%@ %@:%@",month,day,hour,minit];
}

-(BOOL)isShowText:(NSInteger)row
{
    if ([[[m_jsonArr objectAtIndex:(row+3)] substringToIndex:1] isEqualToString:@"0"]) {
        
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
    [detailBtn setTitle:[NSString stringWithFormat:@"%@",@""] forState:UIControlStateNormal];
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
        
    }
}

-(void)dismissKeyBoard
{
    [self.view endEditing:YES];
    [self movoTo:64];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self movoTo:-200];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //发送
    [textField resignFirstResponder];
    [self movoTo:64];
    return YES;
}

-(void)movoTo:(CGFloat)dh
{
    [UIView animateWithDuration:0.35f animations:^{
        self.view.frame = CGRectMake(0, dh, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}

@end
