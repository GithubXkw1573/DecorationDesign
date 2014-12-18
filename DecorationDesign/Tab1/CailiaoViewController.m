//
//  CailiaoViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/15.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "CailiaoViewController.h"

@interface CailiaoViewController ()

@end

@implementation CailiaoViewController
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
    [leftbtn addTarget:self action:@selector(cailiaoViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, applicationheight-49-44) style:UITableViewStylePlain];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)cailiaoViewControllerBtnPressed:(UIButton*)btn
{
    if (btn.tag ==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)loadRequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"获取中"];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"DESIGNER-TWOPAGE",@"JUDGEMETHOD",[m_array objectAtIndex:1],@"USERID", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress setHidden:YES];
            NSArray *infolist = [result objectForKey:@"DESIGNERTWOPAGE"];
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
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"DESIGNER-WORKSLIST",@"JUDGEMETHOD",[m_array objectAtIndex:1],@"USERID", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress setHidden:YES];
            NSArray *infolist = [result objectForKey:@"WORKSARTICLEINFO"];
            self.n_jsonArr = infolist;
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
            
            
        }
        UILabel *lbl1 = (UILabel*)[cell.contentView viewWithTag:20];
        lbl1.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:0]];
        CGSize size = [lbl1.text sizeWithFont:font(13) constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        inroduceHeight = size.height;
        lbl1.frame = CGRectMake(lbl1.frame.origin.x, lbl1.frame.origin.y, 300, inroduceHeight) ;
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
            
            UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 30)];
            personTitle.text = @"主营产品";
            personTitle.font = font(18);
            [cell.contentView addSubview:personTitle];
            [personTitle release];
            
            UILabel *personName = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 300, 1000)];
            personName.font = font(13);
            personName.tag = 21;
            personName.numberOfLines = 0;
            personName.textColor = [UIColor grayColor];
            [cell.contentView addSubview:personName];
            [personName release];
            
            
        }
        UILabel *lbl1 = (UILabel*)[cell.contentView viewWithTag:21];
        lbl1.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:1]];
        CGSize size = [lbl1.text sizeWithFont:font(13) constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        productHeight = size.height;
        lbl1.frame = CGRectMake(lbl1.frame.origin.x, lbl1.frame.origin.y, 300, productHeight) ;
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
            
            
            UILabel *contactorTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
            contactorTitle.text = @"联系人：";
            contactorTitle.font = bold_font(15);
            [cell.contentView addSubview:contactorTitle];
            [contactorTitle release];
            UILabel *contactor = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 200, 20)];
            contactor.font = font(14);
            contactor.tag = 31;
            contactor.textColor = [UIColor grayColor];
            [cell.contentView addSubview:contactor];
            [contactor release];
            
            UILabel *telTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 80, 20)];
            telTitle.text = @"联系电话：";
            telTitle.font = bold_font(15);
            [cell.contentView addSubview:telTitle];
            [telTitle release];
            UILabel *tel = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 200, 20)];
            tel.font = font(14);
            tel.tag = 32;
            tel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:tel];
            [tel release];
            
            UILabel *addrTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 80, 20)];
            addrTitle.text = @"公司地址：";
            addrTitle.font = bold_font(15);
            [cell.contentView addSubview:addrTitle];
            [addrTitle release];
            myLabel *addr = [[myLabel alloc] initWithFrame:CGRectMake(90, 53, 240, 40)];
            addr.font = font(14);
            addr.tag = 33;
            addr.verticalAlignment = VerticalAlignmentTop_m;
            addr.textColor = [UIColor grayColor];
            addr.numberOfLines = 0;
            [cell.contentView addSubview:addr];
            [addr release];
        }
        UILabel *lbl1 = (UILabel*)[cell.contentView viewWithTag:31];
        UILabel *lbl2 = (UILabel*)[cell.contentView viewWithTag:32];
        UILabel *lbl3 = (UILabel*)[cell.contentView viewWithTag:33];
        lbl1.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:0]];
        lbl2.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:1]];
        lbl3.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:2]];
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
                
                UIImageView *works1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 90, 80)];
                works1.image = [UIImage imageNamed:@"CAIliao_img3"];
                works1.tag = 50;
                [cell.contentView addSubview:works1];
                [works1 release];
                
                UIImageView *works2 = [[UIImageView alloc] initWithFrame:CGRectMake(115, 20, 90, 80)];
                works2.image = [UIImage imageNamed:@"CAIliao_img4"];
                works2.tag = 51;
                [cell.contentView addSubview:works2];
                [works2 release];
                
                UIImageView *works3 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 20, 90, 80)];
                works3.image = [UIImage imageNamed:@"CAIliao_img5"];
                works3.tag = 52;
                [cell.contentView addSubview:works3];
                [works3 release];
                
            }
            UIImageView *works1Image = (UIImageView*)[cell.contentView viewWithTag:50];
            UIImageView *works2Image = (UIImageView*)[cell.contentView viewWithTag:51];
            UIImageView *works3Image = (UIImageView*)[cell.contentView viewWithTag:52];
            NSString *imageurl1 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)] objectAtIndex:2];
            NSString *imageurl2 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-2)] objectAtIndex:2];
            NSString *imageurl3 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-1)] objectAtIndex:2];
            [works1Image setImageWithURL:[NSURL URLWithString:imageurl1] placeholderImage:[UIImage imageNamed:@"CAIliao_img3"]];
            [works2Image setImageWithURL:[NSURL URLWithString:imageurl2] placeholderImage:[UIImage imageNamed:@"CAIliao_img4"]];
            [works3Image setImageWithURL:[NSURL URLWithString:imageurl3] placeholderImage:[UIImage imageNamed:@"CAIliao_img5"]];
            return cell;
        }else{
            static NSString *cellIdentific = @"cell3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 1)];
                line.image = [UIImage imageNamed:@"线"];
                [cell.contentView addSubview:line];
                [line release];
                
                UIImageView *works = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 110, 70)];
                works.image = [UIImage imageNamed:@"CAIliao_img1"];
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
                
                UILabel *pinpai = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 180, 17)];
                pinpai.font = font(14);
                pinpai.tag = 42;
                pinpai.textColor = [UIColor grayColor];
                [cell.contentView addSubview:pinpai];
                [pinpai release];
                
                UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(130, 47, 180, 17)];
                type.font = font(14);
                type.tag = 43;
                type.textColor = [UIColor grayColor];
                [cell.contentView addSubview:type];
                [type release];
                
                UILabel *chandi = [[UILabel alloc] initWithFrame:CGRectMake(130, 64, 180, 17)];
                chandi.font = font(14);
                chandi.tag = 44;
                chandi.textColor = [UIColor grayColor];
                [cell.contentView addSubview:chandi];
                [chandi release];
            }
            UIImageView *worksImage = (UIImageView*)[cell.contentView viewWithTag:40];
            UILabel *l_title = (UILabel*)[cell.contentView viewWithTag:41];
            UILabel *pinpai = (UILabel*)[cell.contentView viewWithTag:42];
            UILabel *type = (UILabel*)[cell.contentView viewWithTag:43];
            UILabel *chandi = (UILabel*)[cell.contentView viewWithTag:44];
            NSString *imageurl = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)] objectAtIndex:2];
            [worksImage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"CAIliao_img1"]];
            l_title.text = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:3];
            pinpai.text = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:4];
            type.text = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:4];
            chandi.text = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:4];
            return cell;
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row==0) {
        return 50+[self cellHeight:0];
    }else if (row==1){
        return 50+[self cellHeight:1];
    }else if (row==2){
        return 80;
    }else{
        if ((row+4)%6==0)
        {
            return 100;
        }else{
            return 100;
        }
    }
    return 0;
}

-(CGFloat)cellHeight:(NSInteger)index
{
    NSString *content = [m_jsonArr objectAtIndex:index];
    CGSize size = [content sizeWithFont:font(13) constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}

@end
