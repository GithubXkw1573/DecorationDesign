//
//  LoupanZhuantiController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/29.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "LoupanZhuantiController.h"
#import "ShareView.h"
#import "DetailViewController.h"

@interface LoupanZhuantiController ()

@end

@implementation LoupanZhuantiController
@synthesize m_array,m_jsonArr,n_jsonArr,buildingId,companyName,companyId;


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
    fangangCount = 0;
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=[NSString stringWithFormat:@"%@",@"楼盘专题"];
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
    [leftbtn addTarget:self action:@selector(louzhuantiViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
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
    [rightbtn addTarget:self action:@selector(louzhuantiViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightbtnview addSubview:rightbtn];
    
    UIBarButtonItem *myrightitem = [[UIBarButtonItem alloc] initWithCustomView:rightbtnview];
    self.navigationItem.rightBarButtonItem = myrightitem;
    [myrightitem release];
    [rightbtnview release];
    CGFloat viewHeight = self.hidesBottomBarWhenPushed?applicationheight-44:applicationheight-49-44;
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, viewHeight) style:UITableViewStylePlain];
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
    [self loadWorklistRequest];
    [self loadActivistRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)louzhuantiViewControllerBtnPressed:(UIButton*)btn
{
    if (btn.tag ==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag==2){
        //分享
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
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"BUILDING-TWO-PAGE",@"JUDGEMETHOD",buildingId,@"BUILDINGID", nil];
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
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"BUILDING-ACT-LIST-PAGE",@"JUDGEMETHOD",[m_array objectAtIndex:4],@"CONTENTID",@"0",@"GETTIMES", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            newList = [result objectForKey:@"SUBJECTACTLISTINFO"];
            fangangCount = [newList count];
            if ([newList count] > 0) {
                [MBProgress hide:YES];
                [n_jsonArr removeAllObjects];
                [n_jsonArr addObjectsFromArray:newList];
            }
            else if([newList count] == 0){
                [MBProgress settext:@"暂无数据!" aftertime:1.0];
                [n_jsonArr removeAllObjects];
            }
        }else{
            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
            NSLog(@"%@",errrDesc);
            [MBProgress settext:errrDesc aftertime:1.0];
        }
    }];
    [request setFailedBlock:^{
        [MBProgress settext:@"网络错误，请检查网络连接！" aftertime:1.0];
        
    }];
    [request startRequest];
}

-(void)loadActivistRequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"获取中"];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"BUILDING-ACTCONT-LIST-PAGE",@"JUDGEMETHOD",[m_array objectAtIndex:4],@"CONTENTID",@"0",@"GETTIMES", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            newList = [result objectForKey:@"SUBJECTACTLISTINFO"];
            if ([newList count] > 0) {
                [MBProgress hide:YES];
                [n_jsonArr addObjectsFromArray:newList];
            }
            else if([newList count] == 0){
                [MBProgress settext:@"暂无数据!" aftertime:1.0];
                [n_jsonArr removeAllObjects];
            }
        }else{
            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
            NSLog(@"%@",errrDesc);
            [MBProgress settext:errrDesc aftertime:1.0];
        }
    }];
    [request setFailedBlock:^{
        [MBProgress settext:@"网络错误，请检查网络连接！" aftertime:1.0];
        
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
            
            
            UIImageView *banner = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 60)];
            banner.tag = 12;
            banner.image = [UIImage imageNamed:@"loup_4_img1"];
            [cell.contentView addSubview:banner];
            [banner release];
        }
        UIImageView *imagev = (UIImageView*)[cell.contentView viewWithTag:12];
        [imagev setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[m_array objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"loup_4_img1"]];
        return cell;
    }else if (row == 1){
        static NSString *cellIdentific = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 310, 120)];
            backView.backgroundColor = [UIColor colorWithRed:220/255.f green:220/255.f blue:220/255.f alpha:1.f];
            backView.tag = 13;
            [cell.contentView addSubview:backView];
            [backView release];
            
            UIImageView *zhaiyao = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 38, 21)];
            zhaiyao.image = [UIImage imageNamed:@"loup_4_btn2"];
            [backView addSubview:zhaiyao];
            [zhaiyao release];
            
            UILabel *personName = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, 300, 1000)];
            personName.font = font(14);
            personName.tag = 14;
            personName.numberOfLines = 0;
            [backView addSubview:personName];
            [personName release];
            
        }
        UILabel *lbl1 = (UILabel*)[cell.contentView viewWithTag:14];
        lbl1.text = [NSString stringWithFormat:@"           %@",[m_jsonArr objectAtIndex:2]];
        CGSize size = [lbl1.text sizeWithFont:font(14) constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        inroduceHeight = size.height;
        lbl1.frame = CGRectMake(lbl1.frame.origin.x, lbl1.frame.origin.y, 300, inroduceHeight) ;
        UIView *backView = (UIView*)[cell.contentView viewWithTag:13];
        backView.frame = CGRectMake(backView.frame.origin.x, backView.frame.origin.y, 310, inroduceHeight+20) ;
        return cell;
    }
    else if (row == 2){
        static NSString *cellIdentific = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, applicationwidth, 30)];
            personTitle.text = @"  热点方案";
            personTitle.font = font(16);
            personTitle.backgroundColor = [UIColor colorWithRed:241/255.f green:221/255.f blue:223/255.f alpha:1.f];
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
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 1)];
                line.image = [UIImage imageNamed:@"线"];
                [cell.contentView addSubview:line];
                [line release];
                
                UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, applicationwidth, 30)];
                personTitle.text = @"  热点活动";
                personTitle.font = font(16);
                personTitle.hidden = YES;
                personTitle.tag = 111;
                personTitle.backgroundColor = [UIColor colorWithRed:241/255.f green:221/255.f blue:223/255.f alpha:1.f];
                [cell.contentView addSubview:personTitle];
                [personTitle release];
                
                
                
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
                
                UIImageView *works3 = [[UIImageView alloc] initWithFrame:CGRectMake(216.6, 5, 93.3, 70)];
                works3.image = [UIImage imageNamed:@"CAIliao_img5"];
                works3.tag = 52;
                [cell.contentView addSubview:works3];
                [works3 release];
                
            }
            if (fangangCount==(row-3)/6*2+row-2 || fangangCount==(row-3)/6*2+row-1 || fangangCount==(row-3)/6*2+row) {
                UILabel *titleLabel = (UILabel*)[cell.contentView viewWithTag:111];
                titleLabel.hidden = NO;
            }else{
                UILabel *titleLabel = (UILabel*)[cell.contentView viewWithTag:112];
                titleLabel.hidden = YES;
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
                
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 1)];
                line.image = [UIImage imageNamed:@"线"];
                [cell.contentView addSubview:line];
                [line release];
                
                UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, applicationwidth, 30)];
                personTitle.text = @"  热点活动";
                personTitle.font = font(16);
                personTitle.hidden = YES;
                personTitle.tag =112;
                personTitle.backgroundColor = [UIColor colorWithRed:241/255.f green:221/255.f blue:223/255.f alpha:1.f];
                [cell.contentView addSubview:personTitle];
                [personTitle release];
                
                
                UIImageView *works = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 78, 62)];
                works.image = [UIImage imageNamed:@"CAIliao_img1"];
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
                
                UILabel *pinpai = [[UILabel alloc] initWithFrame:CGRectMake(98, 36, 212, 40)];
                pinpai.font = font(12);
                pinpai.tag = 42;
                pinpai.numberOfLines = 2;
                pinpai.textColor = [UIColor grayColor];
                [cell.contentView addSubview:pinpai];
                [pinpai release];
                
            }
            if (fangangCount==(row-3)/6*2+row-2) {
                UILabel *titleLabel = (UILabel*)[cell.contentView viewWithTag:112];
                titleLabel.hidden = NO;
            }else{
                UILabel *titleLabel = (UILabel*)[cell.contentView viewWithTag:112];
                titleLabel.hidden = YES;
            }
            UIImageView *worksImage = (UIImageView*)[cell.contentView viewWithTag:40];
            UILabel *l_title = (UILabel*)[cell.contentView viewWithTag:41];
            UILabel *pinpai = (UILabel*)[cell.contentView viewWithTag:42];;
            NSString *imageurl = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)] objectAtIndex:0];
            [worksImage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"CAIliao_img1"]];
            l_title.text = [NSString stringWithFormat:@"%@",[[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:1]];
            NSString *descString = [NSString stringWithFormat:@"%@",[[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:2]];
            NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:descString];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:5];
            [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [descString length])];
            [pinpai setAttributedText:attributedString1];
            [pinpai sizeToFit];
            return cell;
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row==0) {
        return 60;
    }else if (row==1){
        return 20+[self cellHeight:2];
    }else if (row==2){
        return 40;
    }else{
        if ((row+4)%6==0)
        {
            if (fangangCount==(row-3)/6*2+row-2 || fangangCount==(row-3)/6*2+row-1 || fangangCount==(row-3)/6*2+row) {
                return 110;
            }
            return 80;
        }else{
            if (fangangCount==(row-3)/6*2+row-2) {
                return 110;
            }
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
            DetailViewController *detail = [[DetailViewController alloc] init];
            detail.hidesBottomBarWhenPushed = YES;
            detail.method = @"BUILDING-WAYACT-INFO";
            detail.designer = companyName;
            detail.designerId = companyId;
            detail.m_array = [n_jsonArr objectAtIndex:((row-3)/6*2+row-3)];
            [self.navigationController pushViewController:detail animated:YES];
            [detail release];
        }else{
            DetailViewController *detail = [[DetailViewController alloc] init];
            detail.hidesBottomBarWhenPushed = YES;
            detail.method = @"BUILDING-WAYACT-INFO";
            detail.designer = companyName;
            detail.designerId = companyId;
            detail.m_array = [n_jsonArr objectAtIndex:((row-3)/6*2+row-3)];
            [self.navigationController pushViewController:detail animated:YES];
            [detail release];
        }
    }
}

-(void)buttonCliked:(UIButton*)btn
{
    
}

-(CGFloat)cellHeight:(NSInteger)index
{
    NSString *content = [m_jsonArr objectAtIndex:index];
    CGSize size = [content sizeWithFont:font(14) constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}

@end
