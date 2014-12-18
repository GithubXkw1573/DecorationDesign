//
//  DesignerViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/19.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "DesignerViewController.h"

@interface DesignerViewController ()

@end

@implementation DesignerViewController
@synthesize designerPicView,viewControllers,myscrollView,m_array,m_jsonArr,n_jsonArr;
- (void)viewDidLoad {
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
    self.titleLabel = titlelabel;
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
    [leftbtn addTarget:self action:@selector(designerbackViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    //[self initHeaderComponents];
    //[self initScrollComponents];
    
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

-(void)designerbackViewControllerBtnPressed:(UIButton*)btn
{
    if (btn.tag ==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

-(void)initHeaderComponents
{
    
    
}

-(void)initPersonalInfo
{
    
    
}

-(void)worksExample
{
    UILabel *worksTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 120, 30)];
    worksTitle.text = @"作品案例";
    worksTitle.font = font(18);
    [self.view addSubview:worksTitle];
    [worksTitle release];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 175, 300, 1)];
    line.image = [UIImage imageNamed:@"线"];
    [self.view addSubview:line];
    [line release];
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
            NSString *imageurl = [m_array objectAtIndex:0];
            UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
            picView.backgroundColor = [UIColor clearColor];
            [picView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"设计师头像1"]];
            self.designerPicView = picView;
            [cell.contentView addSubview:picView];
            [picView release];
            
            UILabel *zuoping = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 40, 20)];
            zuoping.text = @"作品:";
            zuoping.backgroundColor = [UIColor clearColor];
            zuoping.font = font(12);
            [cell.contentView addSubview:zuoping];
            [zuoping release];
            UILabel *zuopingValue = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 30, 20)];
            zuopingValue.text = @"888";
            worksLabel = zuopingValue;
            zuopingValue.tag = 11;
            zuopingValue.backgroundColor = [UIColor clearColor];
            zuopingValue.font = font(12);
            [cell.contentView addSubview:zuopingValue];
            [zuopingValue release];
            
            UILabel *jingping = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 40, 20)];
            jingping.text = @"精品:";
            jingping.backgroundColor = [UIColor clearColor];
            jingping.font = font(12);
            [cell.contentView addSubview:jingping];
            [jingping release];
            UILabel *jingpingValue = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 30, 20)];
            jingpingValue.text = @"88";
            good_workLabel = jingpingValue;
            jingpingValue.tag = 12;
            jingpingValue.backgroundColor = [UIColor clearColor];
            jingpingValue.font = font(12);
            [cell.contentView addSubview:jingpingValue];
            [jingpingValue release];
            
            
            
            UIButton *yuyueBtn = [[UIButton alloc] initWithFrame:CGRectMake(235, 11, 75, 37)];
            yuyueBtn.backgroundColor = [UIColor clearColor];
            [yuyueBtn setBackgroundImage:[UIImage imageNamed:@"预约"] forState:UIControlStateNormal];
            [yuyueBtn addTarget:self action:@selector(orderClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:yuyueBtn];
            [yuyueBtn release];
            
            UILabel *fengge = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 60, 20)];
            fengge.text = @"擅长风格:";
            fengge.backgroundColor = [UIColor clearColor];
            fengge.font = font(12);
            [cell.contentView addSubview:fengge];
            [fengge release];
            UILabel *fenggeValue = [[UILabel alloc] initWithFrame:CGRectMake(160, 50, 50, 20)];
            fenggeValue.text = @"中式风格";
            shanchangLabel = fenggeValue;
            fenggeValue.tag = 13;
            fenggeValue.backgroundColor = [UIColor clearColor];
            fenggeValue.font = font(12);
            [cell.contentView addSubview:fenggeValue];
            [fenggeValue release];
            
            UILabel *city = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 30, 20)];
            city.text = @"城市:";
            city.backgroundColor = [UIColor clearColor];
            city.font = font(12);
            [cell.contentView addSubview:city];
            [city release];
            UILabel *cityValue = [[UILabel alloc] initWithFrame:CGRectMake(260, 50, 40, 20)];
            cityValue.text = @"南京";
            cityLabel = cityValue;
            cityValue.tag = 14;
            cityValue.backgroundColor = [UIColor clearColor];
            cityValue.font = font(12);
            [cell.contentView addSubview:cityValue];
            [cityValue release];
            
            UILabel *zhuanye = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 60, 20)];
            zhuanye.text = @"设计专长:";
            zhuanye.backgroundColor = [UIColor clearColor];
            zhuanye.font = font(12);
            [cell.contentView addSubview:zhuanye];
            [zhuanye release];
            UILabel *zhuanyeValue = [[UILabel alloc] initWithFrame:CGRectMake(160, 70, 50, 20)];
            zhuanyeValue.text = @"别墅豪宅";
            professiorLabel = zhuanyeValue;
            zhuanyeValue.tag = 15;
            zhuanyeValue.backgroundColor = [UIColor clearColor];
            zhuanyeValue.font = font(12);
            [cell.contentView addSubview:zhuanyeValue];
            [zhuanyeValue release];
            
            UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(220, 70, 30, 20)];
            type.text = @"类型:";
            type.backgroundColor = [UIColor clearColor];
            type.font = font(12);
            [cell.contentView addSubview:type];
            [type release];
            UILabel *typeValue = [[UILabel alloc] initWithFrame:CGRectMake(260, 70, 50, 20)];
            typeValue.text = @"室内设计";
            typeLabel = typeValue;
            typeValue.tag = 16;
            typeValue.backgroundColor = [UIColor clearColor];
            typeValue.font = font(12);
            [cell.contentView addSubview:typeValue];
            [typeValue release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 99, 300, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
        }
        UILabel *lbl1 = (UILabel*)[cell.contentView viewWithTag:11];
        UILabel *lbl2 = (UILabel*)[cell.contentView viewWithTag:12];
        UILabel *lbl3 = (UILabel*)[cell.contentView viewWithTag:13];
        UILabel *lbl4 = (UILabel*)[cell.contentView viewWithTag:14];
        UILabel *lbl5 = (UILabel*)[cell.contentView viewWithTag:15];
        UILabel *lbl6 = (UILabel*)[cell.contentView viewWithTag:16];
        lbl1.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:1]];
        lbl2.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:2]];
        lbl3.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:3]];
        lbl4.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:4]];
        lbl5.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:5]];
        lbl6.text = [NSString stringWithFormat:@"%@",[m_jsonArr objectAtIndex:7]];
        return cell;
    }else if (row == 1){
        static NSString *cellIdentific = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UILabel *personTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 30)];
            personTitle.text = @"个人信息";
            personTitle.font = font(18);
            [cell.contentView addSubview:personTitle];
            [personTitle release];
            UILabel *personName = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 110, 20)];
            personName.text = @"姓名：杰夫贝佐斯";
            personName.font = font(13);
            personName.tag = 20;
            personName.textColor = [UIColor grayColor];
            [cell.contentView addSubview:personName];
            [personName release];
            UILabel *m_typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 45, 100, 20)];
            m_typeLabel.text = @"类型：室内设计";
            m_typeLabel.font = font(13);
            m_typeLabel.tag = 21;
            m_typeLabel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:m_typeLabel];
            [m_typeLabel release];
            UILabel *loacationLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 45, 100, 20)];
            loacationLabel.text = @"所在地：南京";
            loacationLabel.font = font(13);
            loacationLabel.tag = 22;
            loacationLabel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:loacationLabel];
            [loacationLabel release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 79, 300, 1)];
            line.image = [UIImage imageNamed:@"线"];
            [cell.contentView addSubview:line];
            [line release];
            
            UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(applicationwidth-60, 15, 50, 20)];
            [detailBtn setTitle:@"详情" forState:UIControlStateNormal];
            [detailBtn setBackgroundImage:[UIImage imageNamed:@"Tiwen_text-bg"] forState:UIControlStateNormal];
            detailBtn.backgroundColor = [UIColor clearColor];
            detailBtn.layer.borderWidth = 1.0f;
            detailBtn.layer.backgroundColor = [[UIColor grayColor] CGColor];
            detailBtn.tag = 23;
            [detailBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:detailBtn];
            [detailBtn release];
        }
        UILabel *lbl1 = (UILabel*)[cell.contentView viewWithTag:20];
        UILabel *lbl2 = (UILabel*)[cell.contentView viewWithTag:21];
        UILabel *lbl3 = (UILabel*)[cell.contentView viewWithTag:22];
        lbl1.text = [NSString stringWithFormat:@"姓名：%@",[m_jsonArr objectAtIndex:0]];
        lbl2.text = [NSString stringWithFormat:@"类型：%@",[m_jsonArr objectAtIndex:5]];
        lbl3.text = [NSString stringWithFormat:@"所在地：%@",[m_jsonArr objectAtIndex:7]];
        return cell;
    }
    else if (row == 2){
        static NSString *cellIdentific = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *guanggao = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 300, 87)];
            guanggao.image = [UIImage imageNamed:@"Sjs_xiangqing_banner"];
            guanggao.tag = 30;
            [cell.contentView addSubview:guanggao];
            [guanggao release];
            
            UILabel *worksExample = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 120, 30)];
            worksExample.text = @"作品案例";
            worksExample.font = font(18);
            [cell.contentView addSubview:worksExample];
            [worksExample release];
        }
        NSString *imageurl = [m_jsonArr objectAtIndex:9];
        UIImageView *guangaoimage = (UIImageView*)[cell.contentView viewWithTag:30];
        [guangaoimage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_banner"]];
        return cell;
    }
    else{
        if ((row+4)%6==0) {
            static NSString *cellIdentific = @"cell4";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 300, 1)];
                line.image = [UIImage imageNamed:@"线"];
                [cell.contentView addSubview:line];
                [line release];
                
                UIImageView *works1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 90, 80)];
                works1.image = [UIImage imageNamed:@"Sjs-xiangqing_img2"];
                works1.tag = 50;
                [cell.contentView addSubview:works1];
                [works1 release];
                
                UIImageView *works2 = [[UIImageView alloc] initWithFrame:CGRectMake(115, 20, 90, 80)];
                works2.image = [UIImage imageNamed:@"Sjs-xiangqing_img2"];
                works2.tag = 51;
                [cell.contentView addSubview:works2];
                [works2 release];
                
                UIImageView *works3 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 20, 90, 80)];
                works3.image = [UIImage imageNamed:@"Sjs-xiangqing_img2"];
                works3.tag = 52;
                [cell.contentView addSubview:works3];
                [works3 release];
                
            }
            UIImageView *works1Image = (UIImageView*)[cell.contentView viewWithTag:50];
            UIImageView *works2Image = (UIImageView*)[cell.contentView viewWithTag:51];
            UIImageView *works3Image = (UIImageView*)[cell.contentView viewWithTag:52];
            NSString *imageurl1 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)] objectAtIndex:2];
            NSString *imageurl2=@"";
            NSString *imageurl3=@"";
            if ((row-3)/6*2+row-2 <= n_jsonArr.count-1) {
                imageurl2 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-2)] objectAtIndex:2];
            }
            if ((row-3)/6*2+row-1 <= n_jsonArr.count-1) {
                imageurl3 = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-1)] objectAtIndex:2];
            }
            [works1Image setImageWithURL:[NSURL URLWithString:imageurl1] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_img2"]];
            [works2Image setImageWithURL:[NSURL URLWithString:imageurl2] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_img2"]];
            [works3Image setImageWithURL:[NSURL URLWithString:imageurl3] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_img2"]];
            return cell;
        }else{
            static NSString *cellIdentific = @"cell3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentific];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentific];
                cell.selectionStyle=UITableViewCellSelectionStyleGray;
                
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 1)];
                line.image = [UIImage imageNamed:@"线"];
                [cell.contentView addSubview:line];
                [line release];
                
                UIImageView *works = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 110, 70)];
                works.image = [UIImage imageNamed:@"Sjs_xiangqing_img1"];
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
                
                UILabel *m_desc = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 180, 50)];
                m_desc.text = @"本次活动的主题为“微信·思维·智慧”。腾讯公司高级执行副总裁张小龙在开场的视频连线中表示，微信公众平台的口号是“再小的个体也有自己的品牌”，他从八个方面详细阐述了微信对于公众平台的理念和方向。";
                m_desc.font = font(13);
                m_desc.tag = 42;
                m_desc.numberOfLines = 0;
                m_desc.textColor = [UIColor grayColor];
                [cell.contentView addSubview:m_desc];
                [m_desc release];
            }
            UIImageView *worksImage = (UIImageView*)[cell.contentView viewWithTag:40];
            UILabel *l_title = (UILabel*)[cell.contentView viewWithTag:41];
            UILabel *l_desc = (UILabel*)[cell.contentView viewWithTag:42];
            
            NSString *imageurl = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)] objectAtIndex:2];
            [worksImage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"Sjs_xiangqing_img1"]];
            l_title.text = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:3];
            l_desc.text = [[n_jsonArr objectAtIndex:((row-3)/6*2+row-3)]  objectAtIndex:4];
            return cell;
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row==0) {
        return 100;
    }else if (row==1){
        return 80;
    }else if (row==2){
        return 140;
    }else{
         if ((row+4)%6==0)
         {
             return 110;
         }else{
             return 90;
         }
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detail = [[DetailViewController alloc] init];
    NSInteger row = indexPath.row;
    detail.hidesBottomBarWhenPushed = YES;
    detail.method = @"DESIGNER-WORKSINFO";
    detail.designerId =  [m_array objectAtIndex:1];
    detail.designer = [m_jsonArr objectAtIndex:0];
    detail.m_array = [n_jsonArr objectAtIndex:((row-3)/6*2+row-3)];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}


-(void)buttonClicked:(UIButton*)btn
{
    
}

-(void)initScrollComponents
{
    UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(10, 103, applicationwidth-20, 27)];
    bannerView.backgroundColor = [UIColor myorangecolor];
    [self.view addSubview:bannerView];
    [bannerView release];
    
    UIView *yinying = [[UIView alloc] initWithFrame:CGRectMake(10, 4, 80, 20)];
    yinying.backgroundColor = [UIColor grayColor];
    shadow = yinying;
    yinying.layer.cornerRadius = 10;
    yinying.layer.masksToBounds = YES;
    [bannerView addSubview:yinying];
    [yinying release];
    
    UIButton *inroduce = [[UIButton alloc] initWithFrame:CGRectMake(10, 4, 80, 20)];
    inroduce.tag = 100;
    inroduce.titleLabel.font = font(16);
    [inroduce setTitle:@"个人介绍" forState:UIControlStateNormal];
    [inroduce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    inroduce.backgroundColor = [UIColor clearColor];
    [inroduce addTarget:self action:@selector(swichPanel:) forControlEvents:UIControlEventTouchUpInside];
    [bannerView addSubview:inroduce];
    [inroduce release];
    
    UIButton *zuoping = [[UIButton alloc] initWithFrame:CGRectMake(100, 4, 80, 20)];
    zuoping.tag = 101;
    zuoping.titleLabel.font = font(16);
    [zuoping setTitle:@"作品案例" forState:UIControlStateNormal];
    [zuoping setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zuoping.backgroundColor = [UIColor clearColor];
    [zuoping addTarget:self action:@selector(swichPanel:) forControlEvents:UIControlEventTouchUpInside];
    [bannerView addSubview:zuoping];
    [zuoping release];
    
    UIButton *article = [[UIButton alloc] initWithFrame:CGRectMake(190, 4, 80, 20)];
    article.tag = 102;
    article.titleLabel.font = font(16);
    [article setTitle:@"精彩博文" forState:UIControlStateNormal];
    [article setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    article.backgroundColor = [UIColor clearColor];
    [article addTarget:self action:@selector(swichPanel:) forControlEvents:UIControlEventTouchUpInside];
    [bannerView addSubview:article];
    [article release];
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 138, applicationwidth, applicationheight-49-44-138)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.tag=11;
    self.myscrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView release];
    scrollView.bounces=NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
    
    for (int i=0; i<[viewControllers count]; i++) {
        UIView *controller = [viewControllers objectAtIndex:i];
        if ((NSNull *)controller == [NSNull null]) {
            
        }
        else
        {
            [controller removeFromSuperview];
            controller=nil;
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*3, scrollView.frame.size.height);
    [scrollView scrollRectToVisible:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    [self loadScrollViewWithPage:0];
    
}

- (void)loadScrollViewWithPage:(int)page2 {
    if (page2 < 0) return;
    if (page2 >= 3) return;
    
    // replace the placeholder if necessary
    UIView *controller = [viewControllers objectAtIndex:page2];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[UIView alloc] init];
        
        if (page2==0) {
            PersonIntroduceView *intr = [[PersonIntroduceView alloc] initWithFrame:CGRectMake(10, 0, myscrollView.frame.size.width-20, myscrollView.frame.size.height)];
            [controller addSubview:intr];
            [intr release];
            
        }else if (page2==1){
            //table2
            ZuopingView *intr = [[ZuopingView alloc] initWithFrame:CGRectMake(10, 0, myscrollView.frame.size.width-20, myscrollView.frame.size.height)];
            intr.currController = self.navigationController;
            [controller addSubview:intr];
            [intr release];
        }else{
            //table3
            ArticleView *intr = [[ArticleView alloc] initWithFrame:CGRectMake(0, 0, myscrollView.frame.size.width, myscrollView.frame.size.height)];
            intr.currController = self.navigationController;
            [controller addSubview:intr];
            [intr release];
        }
        
        [viewControllers replaceObjectAtIndex:page2 withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (nil == controller.superview) {
        CGRect frame = myscrollView.frame;
        frame.origin.x = frame.size.width * page2;
        frame.origin.y = 0;
        controller.frame = frame;
        [myscrollView addSubview:controller];
    }
}

-(void)orderClicked:(UIButton*)btn
{
    if ([UserInfo shared].m_isLogin) {
        BookingViewController *book = [[BookingViewController alloc] init];
        book.designerId=[m_array objectAtIndex:1];
        book.designerName = [m_jsonArr objectAtIndex:0];
        book.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:book animated:YES];
        [book release];
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        login.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:login animated:YES];
        [login release];
    }
    
}

-(void)swichPanel:(UIButton*)btn
{
    int index = btn.tag -100;
//    [UIView animateWithDuration:0.35f animations:^{
//        CGRect myframe = shadow.frame;
//        //shadow.transform = CGAffineTransformMakeTranslation(10+90*index-myframe.origin.x, 0) ;
//        shadow.frame = CGRectMake(10+90*index, myframe.origin.y, myframe.size.width, myframe.size.height);
//        
//    } completion:^(BOOL succ){
//        
//    }];
    [self loadScrollViewWithPage:index - 1];
    [self loadScrollViewWithPage:index];
    [self loadScrollViewWithPage:index + 1];
    
    [myscrollView scrollRectToVisible:CGRectMake(myscrollView.frame.size.width*index, myscrollView.frame.origin.y, myscrollView.frame.size.width, myscrollView.frame.size.height) animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==11) {
        
        
        CGFloat pageWidth = myscrollView.frame.size.width;
        int page2 = floor((myscrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        [UIView animateWithDuration:0.15f animations:^{
            shadow.transform = CGAffineTransformMakeTranslation(90*page2, 0) ;
        } completion:^(BOOL succ){
            //shadow.transform = CGAffineTransformMakeTranslation(90*page2, 0) ;
        }];
        [self loadScrollViewWithPage:page2 - 1];
        [self loadScrollViewWithPage:page2];
        [self loadScrollViewWithPage:page2 + 1];
    }
}
@end
