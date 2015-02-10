//
//  LockCellPhoneViewCtrl.m
//  TGQ2
//
//  Created by 许开伟 on 14-11-7.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "BangdingshoujiViewController.h"

@interface BangdingshoujiViewController ()

@end

@implementation BangdingshoujiViewController
@synthesize bangdinghttprequest;
@synthesize notehttprequest;
@synthesize zhanghaotext;
@synthesize yanzhengtext;
@synthesize yanzhengbtn;
@synthesize MBProgress;
@synthesize timer;

-(void)dealloc
{
    [timer release];
    [yanzhengbtn release];
    [bangdinghttprequest clearDelegatesAndCancel];
    [bangdinghttprequest release];
    [notehttprequest clearDelegatesAndCancel];
    [notehttprequest release];
    [zhanghaotext release];
    [yanzhengtext release];
    [MBProgress release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"标题栏%i.png",[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?7:6]] forBarMetrics:UIBarMetricsDefault];
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-20, 0, 60, 44);
    leftbtn.tag=1;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(BangdingshoujiViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"绑定手机号";
    titlelabel.textAlignment=UITextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    UIImageView *backImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入框.png"]];
    backImage.frame =CGRectMake(10, 10, 300, 44);
    backImage.userInteractionEnabled = YES;
    [self.view addSubview:backImage];
    [backImage release];
    
    zhanghaotext=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 285, 44)];
    zhanghaotext.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    zhanghaotext.textColor=[UIColor blackColor];
    zhanghaotext.placeholder = @"请输入手机号";
    zhanghaotext.delegate=self;
    zhanghaotext.tag=1;
    zhanghaotext.autocapitalizationType = UITextAutocapitalizationTypeNone;
    zhanghaotext.clearButtonMode = UITextFieldViewModeWhileEditing;
    zhanghaotext.returnKeyType=UIReturnKeyDone;
    zhanghaotext.keyboardType=UIKeyboardTypeNumberPad;
    zhanghaotext.backgroundColor=[UIColor clearColor];
    [backImage addSubview:zhanghaotext];
    
    UIImageView *backimage3=[[UIImageView alloc]initWithFrame:CGRectMake(10, 64, 150, 44)];
    backimage3.image =[UIImage imageNamed:@"验证码输入框.png"];
    backimage3.userInteractionEnabled=YES;
    [self.view addSubview:backimage3];
    [backimage3 release];
    
    yanzhengtext=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 135, 44)];
    yanzhengtext.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    yanzhengtext.textColor=[UIColor blackColor];
    yanzhengtext.delegate=self;
    yanzhengtext.tag=2;
    yanzhengtext.clearButtonMode = UITextFieldViewModeWhileEditing;
    yanzhengtext.placeholder =@"验证码";
    yanzhengtext.returnKeyType=UIReturnKeyNext;
    yanzhengtext.keyboardType=UIKeyboardTypeNumberPad;
    yanzhengtext.backgroundColor=[UIColor clearColor];
    [backimage3 addSubview:yanzhengtext];
    
    UIButton *huoqubtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    huoqubtn.frame=CGRectMake(190, 64, 120, 44);
    huoqubtn.tag=2;
    [huoqubtn setTitleColor:[UIColor colorWithRed:65/255.0 green:142/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
    [huoqubtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [huoqubtn setBackgroundImage:[UIImage imageNamed:@"输入验证码按钮"] forState:UIControlStateNormal];
    [huoqubtn addTarget:self action:@selector(BangdingshoujiViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.yanzhengbtn=huoqubtn;
    [self.view addSubview:huoqubtn];
    
    UIButton *bangdingbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    bangdingbtn.frame=CGRectMake(10, 118, 300, 44);
    bangdingbtn.tag=3;
    [bangdingbtn setTitle:@"确认绑定" forState:UIControlStateNormal];
    [bangdingbtn setBackgroundImage:[UIImage imageNamed:@"登陆按钮.png"] forState:UIControlStateNormal];
    [bangdingbtn addTarget:self action:@selector(BangdingshoujiViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bangdingbtn];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    [MBProgress setCenter:CGPointMake(160, applicationheight/2-44)];
    [self.view addSubview:MBProgress];
    [MBProgress hide:YES];
}

-(void)BangdingshoujiViewControllerBtnPressed:(id)sender
{
    UIButton *Btn = (UIButton *)sender;
    switch (Btn.tag) {
        case 1:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 2:
        {
            if (![PublicFunction validateUserName:zhanghaotext.text]) {
                UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
                alert.tag=1;
                [alert show];
            }
            else
            {
                [self noterequest];
                zhanghaotext.userInteractionEnabled=NO;
                time=60;
                [self.timer invalidate];
                self.timer=nil;
                [yanzhengbtn setTitle:@"60" forState:UIControlStateNormal];
                yanzhengbtn.userInteractionEnabled=NO;
                self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timegogo) userInfo:nil repeats:YES];
            }
        }
            break;
        case 3:
        {
            if([yanzhengtext.text isEqualToString:@""]||!yanzhengtext.text)
            {
                UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
                alert.tag=2;
                [alert show];
            }
            else
            {
                [self bangdingrequest];
            }
        }
            break;
        default:
            break;
    }
}

-(void)timegogo
{
    time--;
    [yanzhengbtn setTitle:[NSString stringWithFormat:@"%i",time] forState:UIControlStateNormal];
    if (time<=0) {
        [self.timer invalidate];
        self.timer=nil;
        [yanzhengbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        yanzhengbtn.userInteractionEnabled=YES;
    }
}

-(void)noterequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"获取中"];
    
    NSString *url_str=[NSString stringWithFormat:@"%@user/sendSmsCode",MineURL];
    NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *request=[[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
    [request setPostValue:zhanghaotext.text forKey:@"mobile"];
    [self.notehttprequest cancel];
    self.notehttprequest=request;
    
    request.timeOutSeconds=ktimeOutSeconds;
    //异步请求
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(noterequestFinished:)];
    [request setDidFailSelector:@selector(noterequestFailed:)];
    [request startAsynchronous];
}

-(void)noterequestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dic=[[request responseString] JSONValue];
    if (dic) {
        NSLog(@"noterequestFinished:%@",dic);
        if ([[dic objectForKey:@"result"] intValue]==1) {
            [MBProgress settext:@"获取成功!" aftertime:1.0];
        }
        else
        {
            [MBProgress settext:@"获取失败!" aftertime:1.0];
        }
    }
    else
    {
        NSLog(@"json解析错误!");
        [MBProgress hide:YES];
    }
}

-(void)noterequestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"noterequestFailed");
    
    [MBProgress settext:@"网络错误!" aftertime:1.0];
}

-(void)bangdingrequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"绑定中"];
    
    NSString *url_str=[NSString stringWithFormat:@"%@user/updatePhone",MineURL];
    NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *request=[[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
    [request setPostValue:[UserInfo shared].m_Id forKey:@"uid"];
    [request setPostValue:zhanghaotext.text forKey:@"phone"];
    [request setPostValue:yanzhengtext.text forKey:@"validcode"];
    [self.bangdinghttprequest cancel];
    self.bangdinghttprequest=request;
    
    request.timeOutSeconds=ktimeOutSeconds;
    //异步请求
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(bangdingrequestFinished:)];
    [request setDidFailSelector:@selector(bangdingrequestFailed:)];
    [request startAsynchronous];
}

-(void)bangdingrequestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dic=[PublicFunction fixDictionary:[[request responseString] JSONValue]];
    if (dic) {
        NSLog(@"bangdingrequestFinished:%@",dic);
        
        if ([[dic objectForKey:@"result"] isEqualToString:@"1"])
        {
            [MBProgress settext:@"绑定成功!" aftertime:1.0];
            
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else if ([[dic objectForKey:@"result"] isEqualToString:@"0"])
        {
            [MBProgress hide:YES];
            
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"绑定失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
            [alert show];
        }
        else
        {
            [MBProgress settext:@"网络错误!" aftertime:1.0];
        }
    }
    else
    {
        NSLog(@"json解析错误!");
        
        [MBProgress hide:YES];
    }
}

-(void)bangdingrequestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"bangdingrequestFailed");
    
    [MBProgress settext:@"网络错误!" aftertime:1.0];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag ==1) {
        [zhanghaotext becomeFirstResponder];
    }
    else if (alertView.tag ==2) {
        [yanzhengtext becomeFirstResponder];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touchesBegan");
    [zhanghaotext resignFirstResponder];
    [yanzhengtext resignFirstResponder];
}

@end
