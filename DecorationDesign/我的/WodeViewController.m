//
//  WodeViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/22.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "WodeViewController.h"

@interface WodeViewController ()

@end

@implementation WodeViewController
@synthesize mybackView,m_tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (iOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"首页切换图1.png"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.hidden = YES;
    UIImage *shadowimage=[[UIImage alloc]init];
    self.navigationController.navigationBar.shadowImage = shadowimage;//去掉navigationBar阴影黑线
    [shadowimage release];
    
    
    [self initComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
    if ([UserInfo shared].m_isLogin) {
        nameLabel.userInteractionEnabled = NO;
        nameLabel.text = [UserInfo shared].m_nikeName==nil?[UserInfo shared].m_UserName:[UserInfo shared].m_nikeName;
        [touPic setImage:[UserInfo shared].m_toupic==nil?[UIImage imageNamed:@"GR_touxiang"]:[UserInfo shared].m_toupic forState:UIControlStateNormal];
    }else{
        nameLabel.userInteractionEnabled = YES;
        nameLabel.text = @"点击登录";
        [touPic setImage:[UIImage imageNamed:@"GR_touxiang"] forState:UIControlStateNormal];
    }
}

-(void)initComponents
{
    self.m_tableView =[[[UITableView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, applicationheight-28.5) style:UITableViewStylePlain] autorelease];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor clearColor];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 178)];
    backImageView.image = [UIImage imageNamed:@"gr_bg_02.png"];
    backImageView.backgroundColor = [UIColor clearColor];
    m_tableView.backgroundView =backImageView;
    [backImageView release];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
    [m_tableView release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    if (row ==0) {
        static NSString *indentific = @"cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentific];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentific] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIButton *picview = [[UIButton alloc] initWithFrame:CGRectMake(125, 60, 70, 70)];
            picview.backgroundColor = [UIColor clearColor];
            [picview setImage:[UIImage imageNamed:@"GR_touxiang"] forState:UIControlStateNormal];
            picview.layer.cornerRadius = picview.frame.size.width/2.f;
            picview.layer.borderColor = [[UIColor whiteColor] CGColor];
            picview.layer.borderWidth = 2.f;
            picview.layer.masksToBounds = YES;
            picview.tag = 1;
            touPic = picview;
            [picview addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView  addSubview:picview];
            [picview release];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 140, 200, 30)];
            name.backgroundColor = [UIColor clearColor];
            name.text = @"点击登录";
            name.userInteractionEnabled = YES;
            name.textAlignment = UITextAlignmentCenter;
            name.font = font(16);
            name.textColor= [UIColor whiteColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [name addGestureRecognizer:tap];
            nameLabel = name;
            [cell.contentView addSubview:name];
            [name release];
        }
        return cell;
    }else if (row ==1){
        static NSString *indentific = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentific];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentific] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, applicationwidth-2*8, 132)];
            backView.backgroundColor = [UIColor whiteColor];
            backView.layer.borderWidth = 0.5f;
            backView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            [cell.contentView addSubview:backView];
            [backView release];
            
            UIImageView *messagePic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 22.5, 21)];
            messagePic.image = [UIImage imageNamed:@"GR_icon1"];
            messagePic.backgroundColor = [UIColor clearColor];
            [backView addSubview:messagePic];
            [messagePic release];
            
            UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(33, 0, 60, 44)];
            message.backgroundColor = [UIColor clearColor];
            message.text = @"消息";
            message.textAlignment = UITextAlignmentCenter;
            message.font = font(16);
            [backView addSubview:message];
            [message release];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(applicationwidth-35, 15, 7, 13)];
            arrow.image = [UIImage imageNamed:@"GR_icon4"];
            arrow.backgroundColor = [UIColor clearColor];
            [backView addSubview:arrow];
            [arrow release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 43, backView.frame.size.width-20, 1)];
            line.image = [UIImage imageNamed:@"线"];
            line.backgroundColor = [UIColor clearColor];
            [backView addSubview:line];
            [line release];
            
            UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, 44)];
            btn1.backgroundColor = [UIColor clearColor];
            btn1.tag = 11;
            [btn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn1];
            [btn1 release];
            
            
            
            
            UIImageView *collectPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11+44, 22.5, 21)];
            collectPic.image = [UIImage imageNamed:@"GR_icon2"];
            collectPic.backgroundColor = [UIColor clearColor];
            [backView addSubview:collectPic];
            [collectPic release];
            
            UILabel *collect = [[UILabel alloc] initWithFrame:CGRectMake(33, 0+44, 60, 44)];
            collect.backgroundColor = [UIColor clearColor];
            collect.text = @"收藏";
            collect.textAlignment = UITextAlignmentCenter;
            collect.font = font(16);
            [backView addSubview:collect];
            [collect release];
            
            UIImageView *arrow2 = [[UIImageView alloc] initWithFrame:CGRectMake(applicationwidth-35, 15+44, 7, 13)];
            arrow2.image = [UIImage imageNamed:@"GR_icon4"];
            arrow2.backgroundColor = [UIColor clearColor];
            [backView addSubview:arrow2];
            [arrow2 release];
            
            UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 43+44, backView.frame.size.width-20, 1)];
            line2.image = [UIImage imageNamed:@"线"];
            line2.backgroundColor = [UIColor clearColor];
            [backView addSubview:line2];
            [line2 release];
            
            UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 44, backView.frame.size.width, 44)];
            btn2.backgroundColor = [UIColor clearColor];
            btn2.tag = 12;
            [btn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn2];
            [btn2 release];
            
            
            
            
            UIImageView *guanzhuPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11+88, 22.5, 21)];
            guanzhuPic.image = [UIImage imageNamed:@"GR_icon3"];
            guanzhuPic.backgroundColor = [UIColor clearColor];
            [backView addSubview:guanzhuPic];
            [guanzhuPic release];
            
            UILabel *guanzhu = [[UILabel alloc] initWithFrame:CGRectMake(33, 88, 60, 44)];
            guanzhu.backgroundColor = [UIColor clearColor];
            guanzhu.text = @"关注";
            guanzhu.textAlignment = UITextAlignmentCenter;
            guanzhu.font = font(16);
            [backView addSubview:guanzhu];
            [guanzhu release];
            
            UIImageView *arrow3 = [[UIImageView alloc] initWithFrame:CGRectMake(applicationwidth-35, 15+88, 7, 13)];
            arrow3.image = [UIImage imageNamed:@"GR_icon4"];
            arrow3.backgroundColor = [UIColor clearColor];
            [backView addSubview:arrow3];
            [arrow3 release];
            
            UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 43+88, backView.frame.size.width-20, 1)];
            line3.image = [UIImage imageNamed:@"线"];
            line3.backgroundColor = [UIColor clearColor];
            [backView addSubview:line3];
            [line3 release];
            
            UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 88, backView.frame.size.width, 44)];
            btn3.backgroundColor = [UIColor clearColor];
            btn3.tag = 13;
            [btn3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn3];
            [btn3 release];
        }
        return cell;
    }else if (row ==2){
        static NSString *indentific = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentific];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentific] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(8, 10, applicationwidth-2*8, 180)];
            backView.backgroundColor = [UIColor whiteColor];
            backView.layer.borderWidth = 0.5f;
            backView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            [cell.contentView addSubview:backView];
            [backView release];
            
            PicTextButton *yuyuebtn = [[PicTextButton alloc] initWithFrame:CGRectMake(21*widthRate, 7*widthRate, 70*widthRate, 75*widthRate) withIamge:@"GR_icon8" withText:@"我的预约"];
            yuyuebtn.tag = 31;
            [yuyuebtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:yuyuebtn];
            [yuyuebtn release];
            
            PicTextButton *xuqiubtn = [[PicTextButton alloc] initWithFrame:CGRectMake(116*widthRate, 7*widthRate, 70*widthRate, 75*widthRate) withIamge:@"GR_icon9" withText:@"我的需求"];
            xuqiubtn.tag = 32;
            [xuqiubtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:xuqiubtn];
            [xuqiubtn release];
            
            PicTextButton *advicebtn = [[PicTextButton alloc] initWithFrame:CGRectMake(212*widthRate, 7*widthRate, 70*widthRate, 75*widthRate) withIamge:@"GR_icon10" withText:@"我的建议"];
            advicebtn.tag = 33;
            [advicebtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:advicebtn];
            [advicebtn release];
            
            PicTextButton *resetpwdBtn = [[PicTextButton alloc] initWithFrame:CGRectMake(21*widthRate, 90*widthRate, 70*widthRate, 75*widthRate) withIamge:@"GR_icon11" withText:@"修改密码"];
            resetpwdBtn.tag = 34;
            [resetpwdBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:resetpwdBtn];
            [resetpwdBtn release];
            
            PicTextButton *logoutBtn = [[PicTextButton alloc] initWithFrame:CGRectMake(116*widthRate, 90*widthRate, 70*widthRate, 75*widthRate) withIamge:@"GR_icon12" withText:@"退出登录"];
            logoutBtn.tag = 35;
            [logoutBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:logoutBtn];
            [logoutBtn release];
        }
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row==0) {
        return 178;
    }else if (row==1){
        return 140;
    }else{
        return 190;
    }
    return 0;
}


-(void)tap:(UITapGestureRecognizer*)tap
{
    LoginViewController *login = [[LoginViewController alloc] init];
    login.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:login animated:YES];
    [login release];
}

-(void)buttonClicked:(UIButton*)btn
{
    if (btn.tag >10 && btn.tag <14) {
        btn.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.f];
        [UIView animateWithDuration:0.3f animations:^{
            btn.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL flag){
            
        }];
    }else if (btn.tag ==1)
    {
        if ([UserInfo shared].m_isLogin) {
            GerenxinxiViewController *Gerenxinxi =[[GerenxinxiViewController alloc] init];
            Gerenxinxi.hidesBottomBarWhenPushed=YES;
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            [self.navigationController pushViewController:Gerenxinxi animated:YES];
            [Gerenxinxi release];
        }else{
            LoginViewController *login = [[LoginViewController alloc] init];
            login.hidesBottomBarWhenPushed= YES;
            [self.navigationController pushViewController:login animated:YES];
            [login release];
        }
        
    }
}


@end
