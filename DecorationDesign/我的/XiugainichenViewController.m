//
//  XiugainichenViewController.m
//  TGQ
//
//  Created by 元元 on 14-4-20.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "XiugainichenViewController.h"

@interface XiugainichenViewController ()

@end

@implementation XiugainichenViewController
@synthesize TextField;
@synthesize Xiugaihttprequest;
@synthesize MBProgress;
@synthesize Dictionary;
@synthesize delegate;

-(void)dealloc
{
    delegate=nil;
    [Dictionary release];
    [Xiugaihttprequest clearDelegatesAndCancel];
    [Xiugaihttprequest release];
    [MBProgress release];
    [TextField release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回按下jpg"] forState:UIControlEventTouchDown];
    [leftbtn addTarget:self action:@selector(XiugainichenViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"修改昵称";
    titlelabel.textAlignment=UITextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    UIImageView *zhanghaoimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入框.png"]];
    zhanghaoimage.frame =CGRectMake(10, 10, 300, 44);
    zhanghaoimage.userInteractionEnabled = YES;
    [self.view addSubview:zhanghaoimage];
    [zhanghaoimage release];
    
    TextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 285, 44)];
    TextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    TextField.textColor=[UIColor blackColor];
    TextField.text=[Dictionary objectForKey:@"nickName"];
    TextField.delegate=self;
    TextField.tag=1;
    TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    TextField.returnKeyType=UIReturnKeyDone;
    TextField.backgroundColor=[UIColor whiteColor];
    [zhanghaoimage addSubview:TextField];
    
    UIButton *denglubtn=[UIButton buttonWithType:UIButtonTypeCustom];
    denglubtn.frame=CGRectMake(10, 64, 300, 44);
    denglubtn.tag=2;
    [denglubtn setTitle:@"确定" forState:UIControlStateNormal];
    [denglubtn setBackgroundImage:[UIImage imageNamed:@"登陆按钮.png"] forState:UIControlStateNormal];
//    [denglubtn setBackgroundImage:[UIImage imageNamed:@"返回按下jpg"] forState:UIControlEventTouchDown];
    [denglubtn addTarget:self action:@selector(XiugainichenViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:denglubtn];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    [MBProgress setCenter:CGPointMake(160, applicationheight/2-44)];
    [self.view addSubview:MBProgress];
    [MBProgress hide:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)XiugainichenViewControllerBtnPressed:(id)sender
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
            if (TextField.text) {
                NSRange tuirange;
                tuirange=[TextField.text rangeOfString:@"推"];
                
                NSRange xiangrange;
                xiangrange=[TextField.text rangeOfString:@"享"];
                
                if (tuirange.length!=0&&xiangrange.length!=0) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能同时包含\"推\"\"享\"关键字!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
                else
                {
                    [self Xiugairequest];
                }
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
        default:
            break;
    }
}

-(void)Xiugairequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"保存中"];
    
    NSString *url_str=[NSString stringWithFormat:@"%@center/updateNickname",MineURL];
    NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *request=[[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
    [request setPostValue:[UserInfo shared].m_Id forKey:@"uid"];
    [request setPostValue:TextField.text forKey:@"name"];
    [UserInfo shared].m_nikeName = TextField.text;
    [self.Xiugaihttprequest cancel];
    self.Xiugaihttprequest=request;
    
    request.timeOutSeconds=ktimeOutSeconds;
    //异步请求
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(XiugairequestFinished:)];
    [request setDidFailSelector:@selector(XiugairequestFailed:)];
    [request startAsynchronous];
}

-(void)XiugairequestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dic=[PublicFunction fixDictionary:[[request responseString] JSONValue]];
    if (dic) {
        NSLog(@"XiugairequestFinished:%@",dic);
        
        if ([[dic objectForKey:@"result"] isEqualToString:@"1"])
        {
            [MBProgress settext:@"保存成功!" aftertime:1.0];
            
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [delegate XiugainichenViewDelegateBtnPressed:TextField.text];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [MBProgress settext:@"保存失败!" aftertime:1.0];
        }
    }
    else
    {
        NSLog(@"json解析错误!");
        
        [MBProgress hide:YES];
    }
}

-(void)XiugairequestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"XiugairequestFailed");
    
    [MBProgress settext:@"网络错误!" aftertime:1.0];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [TextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [TextField resignFirstResponder];
    
    return YES;
}

@end
