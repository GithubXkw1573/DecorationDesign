//
//  UserSettingDetailController.m
//  QSQ
//
//  Created by ssyz on 13-8-14.
//  Copyright (c) 2013年 luob. All rights reserved.
//

#import "UserSettingDetailController.h"

@implementation UserSettingDetailController
@synthesize myrequest;
@synthesize MBProgress;

-(void)dealloc
{
    [MBProgress release];
    [myrequest clearDelegatesAndCancel];
    [myrequest release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"标题栏%i.png",[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?7:6]] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.1843 green:0.7451 blue:0.8627 alpha:1.0];  
    
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-20, 0, 60, 44);
    leftbtn.tag=1;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
//    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回按下jpg"] forState:UIControlEventTouchDown];
    [leftbtn addTarget:self action:@selector(UserSettingDetailControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"修改密码";
    titlelabel.textAlignment=UITextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    UIImageView * textimage =[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 44)];
    textimage.image = [UIImage imageNamed:@"输入框.png"];
    [self.view addSubview:textimage];
    [textimage release];
    
    UIImageView * textimage1 =[[UIImageView alloc] initWithFrame:CGRectMake(10, 64, 300, 44)];
    textimage1.image = [UIImage imageNamed:@"输入框.png"];
    [self.view addSubview:textimage1];
    [textimage1 release];
    
    oneText =[[UITextField alloc] initWithFrame:CGRectMake(20, 10, 285, 44)];
    oneText.tag=1;
    oneText.delegate=self;
    oneText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    oneText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; 
    oneText.textColor=[UIColor blackColor];
    oneText.placeholder =@"旧密码";
    oneText.returnKeyType =UIReturnKeyNext;
    oneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    oneText.keyboardType=UIKeyboardTypeAlphabet;
    [self.view addSubview:oneText];
    
    twoText =[[UITextField alloc] initWithFrame:CGRectMake(20, 64, 285, 44)];
    twoText.tag=2;
    twoText.delegate=self;
    twoText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    twoText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; 
    twoText.textColor=[UIColor blackColor];
    twoText.placeholder =@"新密码:由6-16位的数字和英文组成";
    twoText.returnKeyType =UIReturnKeyDone;
    twoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    twoText.keyboardType=UIKeyboardTypeAlphabet;
    [self.view addSubview:twoText];
    
    UIButton *changeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame=CGRectMake(10, 118, 300, 44);
    changeBtn.tag=2;
    [changeBtn setTitle:@"确定修改" forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(UserSettingDetailControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"登陆按钮.png"] forState:UIControlStateNormal];
    [self.view addSubview:changeBtn];
    
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

-(void)UserSettingDetailControllerBtnPressed:(id)sender
{
    UIButton *Btn = (UIButton *)sender;
    switch (Btn.tag) {
        case 1:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 2:{
            [self beganchange];
        }
            break;
        default:
            break;
    }
}

-(void)changepasswordrequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"修改密码"];
    
    NSString *url_str=[NSString stringWithFormat:@"%@center/updatePwd",MineURL];
    NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *request=[[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
    [request setPostValue:[UserInfo shared].m_Id forKey:@"uid"];
    [request setPostValue:[MD5Hash md5:[NSString stringWithFormat:@"%@tx%@",[UserInfo shared].m_UserName,oneText.text]] forKey:@"oldPwd"];
    [request setPostValue:[MD5Hash md5:[NSString stringWithFormat:@"%@tx%@",[UserInfo shared].m_UserName,twoText.text]] forKey:@"pwd"];
    [self.myrequest cancel];
    self.myrequest=request;
    
    request.timeOutSeconds=ktimeOutSeconds;
    //异步请求
    [request setDelegate:self];  
    [request setDidFinishSelector:@selector(changepasswordrequestFinished:)];
    [request setDidFailSelector:@selector(changepasswordrequestFailed:)];
    [request startAsynchronous];
}

-(void)changepasswordrequestFinished:(ASIHTTPRequest *)request;
{
    NSDictionary *dic=[PublicFunction fixDictionary:[[request responseString] JSONValue]];
    if (dic) {
        NSLog(@"changepasswordrequestFinished:%@",dic);
        if ([[dic objectForKey:@"result"] isEqualToString:@"1"]) {
            [MBProgress settext:@"修改成功!" aftertime:1.0]; 
            
            [UserInfo shared].m_PassWord=twoText.text;
            [[UserInfo shared] saveUserInfo];
            
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.navigationController popViewControllerAnimated:YES];
            }); 
        }
        else if ([[dic objectForKey:@"result"] isEqualToString:@"0"])
        {
            [MBProgress hide:YES];
            
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
            alert.tag=3;
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

-(void)changepasswordrequestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"changepasswordrequestFailed");
    
    [MBProgress settext:@"网络错误!" aftertime:1.0];
}

-(void)beganchange
{
    NSLog(@"%@",oneText.text);
    NSLog(@"%@",twoText.text);
    
    if ([oneText.text isEqualToString:@""]||!oneText.text) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"旧密码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag=1;
        [alert show];
        [alert release];
        return;
    }
    else if([twoText.text isEqualToString:@""]||!twoText.text)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag=2;
        [alert show];
        [alert release];
        return;
    }
    else if(![oneText.text isEqualToString:[UserInfo shared].m_PassWord])
    {
        NSLog(@"%@",oneText.text);
        NSLog(@"%@",[UserInfo shared].m_PassWord);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"旧密码错误!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag=1;
        [alert show];
        [alert release];
        return;
    }
    else if([oneText.text isEqualToString:twoText.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新旧密码相同!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag=2;
        [alert show];
        [alert release];
        return;
    }
    else if (![PublicFunction validateUserPasswd:twoText.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码只能是6-16位的数字和英文组成!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag=2;
        [alert show];
        [alert release];
        return;
    }
    [self changepasswordrequest];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag ==1) {
        [oneText becomeFirstResponder];
    }
    else if(alertView.tag ==2)
    {
        [twoText becomeFirstResponder];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touchesBegan");
    [oneText resignFirstResponder];
    [twoText resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
        {
            [oneText resignFirstResponder];
            [twoText becomeFirstResponder];
        }
            break;
        case 2:
        {
            [oneText resignFirstResponder];
            [twoText resignFirstResponder];
        }
            break;
        default:
            break;
    }
    
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
