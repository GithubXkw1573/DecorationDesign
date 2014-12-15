//
//  RegisterViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/9.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize timer;


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
    titlelabel.text=@"用户注册";
    
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
    [leftbtn addTarget:self action:@selector(RegisterControllerBackBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    [self initCellphoneField];
    [self initYZMBtn];
    [self initYZMField];
    [self initPwdField];
    [self initComfirmpwdField];
    [self initRegisterbtn];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160)];
    [MBProgress setCenter:CGPointMake(160, applicationheight/2-44)];
    [self.view addSubview:MBProgress];
    [MBProgress hide:YES];
}

-(void)RegisterControllerBackBtnPressed:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)initCellphoneField
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
    
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, 270, 43)];
    userField.backgroundColor = [UIColor clearColor];
    userField.placeholder = @"请输入您的手机号";
    userField.font = font(17);
    userField.tag = 22;
    cellField = userField;
    userField.delegate = self;
    userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userField.returnKeyType = UIReturnKeyNext;
    [backview addSubview:userField];
    [userField release];
}

-(void)initYZMField
{
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(16, 45+44, 159, 43)];
    backview.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f];
    [self.view addSubview:backview];
    [backview release];
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44+44, 160, 1)];
    line1.image = [UIImage imageNamed:@"线"];
    line1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line1];
    [line1 release];
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 88+44, 160, 1)];
    line2.image = [UIImage imageNamed:@"线"];
    line2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line2];
    [line2 release];
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44+44, 1, 44)];
    line3.image = [UIImage imageNamed:@"线"];
    line3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line3];
    [line3 release];
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(15+160, 44+44, 1, 44)];
    line4.image = [UIImage imageNamed:@"线"];
    line4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line4];
    [line4 release];
    
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, 140, 43)];
    userField.backgroundColor = [UIColor clearColor];
    userField.placeholder = @"请输入手机验证码";
    userField.font = font(17);
    userField.tag = 23;
    yzmField = userField;
    userField.delegate = self;
    userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userField.returnKeyType = UIReturnKeyNext;
    [backview addSubview:userField];
    [userField release];
}

-(void)initYZMBtn
{
    UIButton *yzmBtn = [[UIButton alloc] initWithFrame:CGRectMake(185, 88, 120, 44)];
    [yzmBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [yzmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    yzmBtn.titleLabel.font = font(16);
    yzmBtn.tag = 10;
    yanzhengbtn = yzmBtn;
    [yzmBtn addTarget:self action:@selector(mybtuttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [yzmBtn setBackgroundImage:[UIImage imageNamed:@"regsiter_bg_huoqu"] forState:UIControlStateNormal];
    [self.view addSubview:yzmBtn];
    [yzmBtn release];
}

-(void)initPwdField
{
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(16, 45+44+64, 289, 43)];
    backview.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f];
    [self.view addSubview:backview];
    [backview release];
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44+44+64, 290, 1)];
    line1.image = [UIImage imageNamed:@"线"];
    line1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line1];
    [line1 release];
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 88+44+64, 290, 1)];
    line2.image = [UIImage imageNamed:@"线"];
    line2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line2];
    [line2 release];
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44+44+64, 1, 44)];
    line3.image = [UIImage imageNamed:@"线"];
    line3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line3];
    [line3 release];
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(15+290, 44+44+64, 1, 44)];
    line4.image = [UIImage imageNamed:@"线"];
    line4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line4];
    [line4 release];
    
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, 270, 43)];
    userField.backgroundColor = [UIColor clearColor];
    userField.placeholder = @"请输入密码";
    userField.font = font(17);
    userField.tag = 24;
    passField = userField;
    userField.delegate = self;
    userField.secureTextEntry = YES;
    userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userField.returnKeyType = UIReturnKeyNext;
    [backview addSubview:userField];
    [userField release];
}

-(void)initComfirmpwdField
{
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(16, 45+44+128, 289, 43)];
    backview.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f];
    [self.view addSubview:backview];
    [backview release];
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44+44+128, 290, 1)];
    line1.image = [UIImage imageNamed:@"线"];
    line1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line1];
    [line1 release];
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 88+44+128, 290, 1)];
    line2.image = [UIImage imageNamed:@"线"];
    line2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line2];
    [line2 release];
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44+44+128, 1, 44)];
    line3.image = [UIImage imageNamed:@"线"];
    line3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line3];
    [line3 release];
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(15+290, 44+44+128, 1, 44)];
    line4.image = [UIImage imageNamed:@"线"];
    line4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line4];
    [line4 release];
    
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, 270, 43)];
    userField.backgroundColor = [UIColor clearColor];
    userField.placeholder = @"请再次输入密码";
    userField.font = font(17);
    userField.tag = 25;
    comfpassField = userField;
    userField.delegate = self;
    userField.secureTextEntry = YES;
    userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userField.returnKeyType = UIReturnKeyDone;
    [backview addSubview:userField];
    [userField release];
}

-(void)initRegisterbtn
{
    UIButton *yzmBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 300, 290, 45)];
    [yzmBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [yzmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    yzmBtn.titleLabel.font = font(18);
    yzmBtn.tag = 20;
    [yzmBtn addTarget:self action:@selector(mybtuttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [yzmBtn setBackgroundImage:[UIImage imageNamed:@"Tiwen_btn-bg"] forState:UIControlStateNormal];
    [self.view addSubview:yzmBtn];
    [yzmBtn release];
}

-(void)mybtuttonclicked:(UIButton*)btn
{
    if (btn.tag ==10) {
        //获取验证码
        if (![PublicFunction validateUserPhone:cellField.text]) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
            alert.tag = 61;
            [alert show];
        }
        else
        {
//            [self noterequest];
            time=60;
            [self.timer invalidate];
            self.timer=nil;
            [yanzhengbtn setTitle:@"60" forState:UIControlStateNormal];
            yanzhengbtn.userInteractionEnabled=NO;
            self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timegogo) userInfo:nil repeats:YES];
        }
    }else if (btn.tag ==20){
        //注册
        if([yzmField.text isEqualToString:@""]||!yzmField.text)
        {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
            alert.tag=62;
            [alert show];
        }else{
            if([passField.text isEqualToString:@""]||!passField.text)
            {
                UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
                alert.tag=63;
                [alert show];
            }else{
                if([comfpassField.text isEqualToString:@""]||!comfpassField.text)
                {
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"确认密码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
                    alert.tag=64;
                    [alert show];
                }else{
                    if (![passField.text isEqualToString:comfpassField.text]) {
                        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不一致!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
                        alert.tag=65;
                        [alert show];
                    }else{
                        //发起注册请求
                        [self startRegister];
                    }
                }
            }
        }
    }
}

-(void)startRegister
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"获取中"];
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"USER-REGIST",@"JUDGEMETHOD",cellField.text,@"USERID",passField.text,@"PASSWORD",yzmField.text,@"YZM", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            [MBProgress settext:@"注册成功!" aftertime:1.0];
            //保存账号
            NSDictionary *mydic = [NSDictionary dictionaryWithObjectsAndKeys:cellField.text,@"username",passField.text,@"pwd", nil];
            [[NSUserDefaults standardUserDefaults] setValue:mydic forKey:@"loginer"];
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0001"]){
            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
            NSLog(@"%@",errrDesc);
            [MBProgress settext:errrDesc aftertime:1.0];
        }else if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0002"]){
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

-(void)timegogo
{
    time--;
    [yanzhengbtn setTitle:[NSString stringWithFormat:@"%i",time] forState:UIControlStateNormal];
    if (time<=0) {
        [self.timer invalidate];
        self.timer=nil;
        [yanzhengbtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        yanzhengbtn.userInteractionEnabled=YES;
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == comfpassField) {
        [self movoTo:-40];
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==passField) {
        [comfpassField becomeFirstResponder];
    }else if (textField==cellField){
        [yzmField becomeFirstResponder];
    }else if (textField==yzmField){
        [passField becomeFirstResponder];
    }else if (textField==comfpassField){
        [self.view endEditing:YES];
        [self movoTo:64];
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
    [self movoTo:64];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag ==61) {
        [cellField becomeFirstResponder];
    }
    else if (alertView.tag ==62) {
        [yzmField becomeFirstResponder];
    }else if (alertView.tag ==63) {
        [passField becomeFirstResponder];
    }else if (alertView.tag ==64) {
        [comfpassField becomeFirstResponder];
    }else if (alertView.tag ==65) {
        [passField becomeFirstResponder];
    }
}

@end
