//
//  LoginViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/8.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"标题栏%i.png",[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?7:6]] forBarMetrics:UIBarMetricsDefault];
    
    UIImage *shadowimage=[[UIImage alloc]init];
    self.navigationController.navigationBar.shadowImage = shadowimage;//去掉navigationBar阴影黑线
    [shadowimage release];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"用户登录";
    
    titlelabel.textAlignment=UITextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-10, 0, 60, 44);
    leftbtn.tag =1;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(LoginControllerBackBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    //注册按钮
    UIView *rightbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 60, 44);
    rightbtn.tag = 2;
    [rightbtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(LoginControllerBackBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightbtnview addSubview:rightbtn];
    
    UIBarButtonItem *myrightitem = [[UIBarButtonItem alloc] initWithCustomView:rightbtnview];
    self.navigationItem.rightBarButtonItem = myrightitem;
    [myrightitem release];
    [rightbtnview release];
    
    [self initComponents];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160)];
    [MBProgress setCenter:CGPointMake(160, applicationheight/2-44)];
    [self.view addSubview:MBProgress];
    [MBProgress hide:YES];
}

-(void)LoginControllerBackBtnPressed:(UIButton*)btn
{
    if (btn.tag==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //注册
        RegisterViewController *regist = [[RegisterViewController alloc] init];
        [self.navigationController pushViewController:regist animated:YES];
        [regist release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"loginer"]) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginer"];
        UITextField *userfield = (UITextField*)[self.view viewWithTag:22];
        UITextField *pwdfield = (UITextField*)[self.view viewWithTag:23];
        userfield.text = [dic objectForKey:@"username"];
        pwdfield.text = [dic objectForKey:@"pwd"];
    }
}

-(void)initComponents
{
    
    [self initUserField];
    [self initPwdField];
    
    UIButton *forgotpwd = [[UIButton alloc] initWithFrame:CGRectMake(applicationwidth-100, 160, 100, 24)];
    [forgotpwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgotpwd setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    forgotpwd.titleLabel.font = font(14);
    forgotpwd.backgroundColor = [UIColor clearColor];
    forgotpwd.tag = 20;
    [forgotpwd addTarget:self action:@selector(mybtuttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotpwd];
    [forgotpwd release];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 290, 38)];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = font(20);
    loginBtn.tag = 10;
    [loginBtn addTarget:self action:@selector(mybtuttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_bg"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn release];
    
    UIImageView *leftline = [[UIImageView alloc] initWithFrame:CGRectMake(10, 265, 100, 1)];
    leftline.image = [UIImage imageNamed:@"线"];
    leftline.backgroundColor = [UIColor clearColor];
    [self.view addSubview:leftline];
    [leftline release];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 255, 100, 20)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.text = @"快 速 登 录";
    textLabel.font = font(14);
    textLabel.textColor = [UIColor grayColor];
    textLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:textLabel];
    [textLabel release];
    
    UIImageView *rightline = [[UIImageView alloc] initWithFrame:CGRectMake(210, 265, 100, 1)];
    rightline.image = [UIImage imageNamed:@"线"];
    rightline.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rightline];
    [rightline release];
    
    UIButton *qqbtn = [[UIButton alloc] initWithFrame:CGRectMake(17, 290, 135, 75)];
    [qqbtn setImage:[UIImage imageNamed:@"login_btn_QQ"] forState:UIControlStateNormal];
    qqbtn.backgroundColor = [UIColor clearColor];
    qqbtn.tag = 81;
    [qqbtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqbtn];
    [qqbtn release];
    
    UIButton *weixinbtn = [[UIButton alloc] initWithFrame:CGRectMake(168, 290, 135, 75)];
    [weixinbtn setImage:[UIImage imageNamed:@"login_btn_weixin"] forState:UIControlStateNormal];
    weixinbtn.backgroundColor = [UIColor clearColor];
    weixinbtn.tag = 82;
    [weixinbtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weixinbtn];
    [weixinbtn release];
}

-(void)initUserField
{
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(16, 45-20, 289, 43)];
    backview.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f];
    [self.view addSubview:backview];
    [backview release];
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44-20, 290, 1)];
    line1.image = [UIImage imageNamed:@"线"];
    line1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line1];
    [line1 release];
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 88-20, 290, 1)];
    line2.image = [UIImage imageNamed:@"线"];
    line2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line2];
    [line2 release];
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44-20, 1, 44)];
    line3.image = [UIImage imageNamed:@"线"];
    line3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line3];
    [line3 release];
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(15+290, 44-20, 1, 44)];
    line4.image = [UIImage imageNamed:@"线"];
    line4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line4];
    [line4 release];
    
    UIImageView *icon1 = [[UIImageView  alloc] initWithFrame:CGRectMake(12, 13, 16, 18)];
    icon1.image = [UIImage imageNamed:@"login_admin"];
    icon1.backgroundColor = [UIColor clearColor];
    [backview addSubview:icon1];
    [icon1 release];
    UIImageView *icon2 = [[UIImageView  alloc] initWithFrame:CGRectMake(38, 10, 1.5, 24)];
    icon2.image = [UIImage imageNamed:@"线"];
    icon2.backgroundColor = [UIColor clearColor];
    [backview addSubview:icon2];
    [icon2 release];
    
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 235, 43)];
    userField.backgroundColor = [UIColor clearColor];
    userField.placeholder = @"用户账号";
    userField.font = font(17);
    userField.tag = 22;
    userField.delegate = self;
    userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userField.returnKeyType = UIReturnKeyNext;
    [backview addSubview:userField];
    [userField release];
}

-(void)initPwdField
{
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(16, 121-20, 289, 43)];
    backview.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f];
    [self.view addSubview:backview];
    [backview release];
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 120-20, 290, 1)];
    line1.image = [UIImage imageNamed:@"线"];
    line1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line1];
    [line1 release];
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 164-20, 290, 1)];
    line2.image = [UIImage imageNamed:@"线"];
    line2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line2];
    [line2 release];
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 120-20, 1, 44)];
    line3.image = [UIImage imageNamed:@"线"];
    line3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line3];
    [line3 release];
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(15+290, 120-20, 1, 44)];
    line4.image = [UIImage imageNamed:@"线"];
    line4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line4];
    [line4 release];
    
    UIImageView *icon1 = [[UIImageView  alloc] initWithFrame:CGRectMake(12, 13, 16, 18)];
    icon1.image = [UIImage imageNamed:@"login_password"];
    icon1.backgroundColor = [UIColor clearColor];
    [backview addSubview:icon1];
    [icon1 release];
    UIImageView *icon2 = [[UIImageView  alloc] initWithFrame:CGRectMake(38, 10, 1.5, 24)];
    icon2.image = [UIImage imageNamed:@"线"];
    icon2.backgroundColor = [UIColor clearColor];
    [backview addSubview:icon2];
    [icon2 release];
    
    UITextField *pwdField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 235, 43)];
    pwdField.backgroundColor = [UIColor clearColor];
    pwdField.placeholder = @"密码";
    pwdField.secureTextEntry = YES;
    pwdField.font = font(17);
    pwdField.tag = 23;
    pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwdField.delegate = self;
    pwdField.returnKeyType = UIReturnKeyDone;
    [backview addSubview:pwdField];
    [pwdField release];
}

-(void)mybtuttonclicked:(UIButton*)btn
{
    switch (btn.tag) {
        case 10:
        {
            //登录
            [self startLogin];
        }
            break;
        case 20:
        {
            //忘记密码
        }
            break;
        default:
            break;
    }
}

-(void)otherLogin:(UIButton*)btn
{
    switch (btn.tag) {
        case 81:
        {
            //qq登录
            [QQkongjianApi shared].logindelegate=self;
            [[QQkongjianApi shared] QQlogin];
        }
            break;
        case 82:
        {
            //微信登录
            if ([[WXShareApi shared] isWXAppInstalled]) {
                [WXShareApi shared].logindelegate=self;
                [[WXShareApi shared] weixinlogin];
            }
            else
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请先下载微信客户端" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
                [alert show];
                [alert release];
            }
        }
            break;
        default:
            break;
    }
}

-(void)loginsuccessful:(NSString *)str OAuth:(id)OAuth userinfo:(NSDictionary *)dic
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"登录中"];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    
    NSString *userId = @"";
    if ([str isEqualToString:@"QQlogin"]) {
        userId = [NSString stringWithFormat:@"%@",[(TencentOAuth *)OAuth openId]];
        request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"Other_login",@"JUDGEMETHOD",
                            @"1",@"clientlogin.loginType",
                            userId,@"clientlogin.openId",
                            [(TencentOAuth *)OAuth accessToken],@"clientlogin.accessToken",
                            [dic objectForKey:@"nickname"],@"clientlogin.name",
                            [dic objectForKey:@"figureurl_2"],@"clientlogin.imageUrl",nil];
    }
    else if([str isEqualToString:@"WXlogin"])
    {
        userId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"unionid"]];
        request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"Other_login",@"JUDGEMETHOD",
                            @"2",@"clientlogin.loginType",
                            userId,@"clientlogin.openId",
                            [(NSDictionary *)OAuth objectForKey:@"access_token"],@"clientlogin.accessToken",
                            [dic objectForKey:@"nickname"],@"clientlogin.name",
                            [dic objectForKey:@"headimgurl"],@"clientlogin.imageUrl",nil];
    }
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress settext:@"登录成功!" aftertime:1.0];
            [UserInfo shared].m_isLogin = YES;
            [UserInfo shared].m_Id = userId;
            [UserInfo shared].m_UserName = userId;
            [UserInfo shared].m_PassWord = @"";
            [UserInfo shared].m_session = [result objectForKey:@"SESSION"];
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.navigationController popViewControllerAnimated:YES];
            });
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

-(void)loginfailed:(NSString *)str
{
    if ([str isEqualToString:@"QQlogin"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"QQ登陆失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if([str isEqualToString:@"WXlogin"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"微信登陆失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(void)startLogin
{
    UITextField *userfield = (UITextField*)[self.view viewWithTag:22];
    UITextField *pwdfield = (UITextField*)[self.view viewWithTag:23];
    [MBProgress show:YES];
    [MBProgress setLabelText:@"获取中"];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"USER-LOGIN",@"JUDGEMETHOD",userfield.text,@"USERID",pwdfield.text,@"PASSWORD",@"0",@"USERTYPE", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress settext:@"登录成功!" aftertime:1.0];
            [UserInfo shared].m_isLogin = YES;
            [UserInfo shared].m_Id = userfield.text;
            [UserInfo shared].m_UserName = userfield.text;
            [UserInfo shared].m_PassWord = pwdfield.text;
            [UserInfo shared].m_session = [result objectForKey:@"SESSION"];
            //保存账号
            NSDictionary *mydic = [NSDictionary dictionaryWithObjectsAndKeys:userfield.text,@"username",pwdfield.text,@"pwd", nil];
            [[NSUserDefaults standardUserDefaults] setValue:mydic forKey:@"loginer"];
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.navigationController popViewControllerAnimated:YES];
            });
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField *userfield = (UITextField*)[self.view viewWithTag:22];
    UITextField *pwdfield = (UITextField*)[self.view viewWithTag:23];
    if (textField==userfield) {
        [pwdfield becomeFirstResponder];
    }else if (textField==pwdfield){
        [self.view endEditing:YES];
    }
    return YES;
}

-(void)movoTo:(CGFloat)dh
{
    [UIView animateWithDuration:0.35f animations:^{
        self.view.frame = CGRectMake(0, dh, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
