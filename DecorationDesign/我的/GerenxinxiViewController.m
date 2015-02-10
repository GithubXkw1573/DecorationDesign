//
//  GerenxinxiViewController.m
//  TGQ
//
//  Created by 元元 on 14-4-20.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "GerenxinxiViewController.h"

@interface GerenxinxiViewController ()

@end

@implementation GerenxinxiViewController
@synthesize m_tableView;
@synthesize MutableDictionary;
@synthesize MBProgress;
@synthesize upimagehttprequest;
@synthesize gerenxinxihttprequest;

-(void)dealloc
{
    [gerenxinxihttprequest clearDelegatesAndCancel];
    [gerenxinxihttprequest release];
    [upimagehttprequest clearDelegatesAndCancel];
    [upimagehttprequest release];
    [MBProgress release];
    [pickerController release];
    [MutableDictionary release];
    [m_tableView release];
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
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"标题栏%i.png",[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?7:6]] forBarMetrics:UIBarMetricsDefault];
    
    MutableDictionary=[[NSMutableDictionary alloc]initWithCapacity:1];
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-20, 0, 60, 44);
    leftbtn.tag=1;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(GerenxinxiViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"账户信息";
    titlelabel.textAlignment=UITextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, applicationheight-44) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor clearColor];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
    
    MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    [MBProgress setCenter:CGPointMake(160, applicationheight/2-44)];
    [self.view addSubview:MBProgress];
    [MBProgress show:YES];
    [MBProgress setLabelText:@"刷新中"];
    
    [self gerenxinxirequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)GerenxinxiViewControllerBtnPressed:(id)sender
{
    UIButton *Btn = (UIButton *)sender;
    switch (Btn.tag) {
        case 1:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)XiugainichenViewDelegateBtnPressed:(NSString *)nickName
{
    [MutableDictionary removeObjectForKey:@"nickName"];
    if([nickName isEqualToString:@""])
    {
        [MutableDictionary setObject:[UserInfo shared].m_UserName forKey:@"nickName"];
    }
    else
    {
        [MutableDictionary setObject:nickName forKey:@"nickName"];
    }
    [self.m_tableView reloadData];
}

-(void)gerenxinxirequest
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"刷新中"];
    
    NSString *url_str=[NSString stringWithFormat:@"%@center/queryAccountInfo",MineURL];
    NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *request=[[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
    [request setPostValue:[UserInfo shared].m_Id forKey:@"uid"];
    [self.gerenxinxihttprequest cancel];
    self.gerenxinxihttprequest=request;
    
    request.timeOutSeconds=ktimeOutSeconds;
    //异步请求
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(gerenxinxirequestFinished:)];
    [request setDidFailSelector:@selector(gerenxinxirequestFailed:)];
    [request startAsynchronous];
}

-(void)gerenxinxirequestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dic=[PublicFunction fixDictionary:[[request responseString] JSONValue]];
    if (dic) {
        NSLog(@"gerenxinxirequestFinished:%@",dic);
        
        [MBProgress hide:YES];
        
        self.MutableDictionary=[NSMutableDictionary dictionaryWithDictionary:dic];
        
        [self.m_tableView reloadData];
    }
    else
    {
        NSLog(@"json解析错误!");
        
        [MBProgress hide:YES];
    }
}

-(void)gerenxinxirequestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"gerenxinxirequestFailed");
    
    [MBProgress settext:@"网络错误!" aftertime:1.0];
}

-(void)upimagerequest:(NSData *)data
{
    [MBProgress show:YES];
    [MBProgress setLabelText:@"上传图片中"];
    
    NSString *url_str=[NSString stringWithFormat:@"%@center/uploadImgForIOS?uid=%@",MineURL,[UserInfo shared].m_Id];
    NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *request=[[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
    [request appendPostData:data];
    [self.upimagehttprequest cancel];
    self.upimagehttprequest=request;
    
    request.timeOutSeconds=ktimeOutSeconds;
    //异步请求
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(upimagerequestFinished:)];
    [request setDidFailSelector:@selector(upimagerequestFailed:)];
    [request startAsynchronous];
}

-(void)upimagerequestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dic=[PublicFunction fixDictionary:[[request responseString] JSONValue]];
    if (dic) {
        NSLog(@"upimagerequestFinished:%@",dic);
        
        if ([[dic objectForKey:@"result"] isEqualToString:@"1"])
        {
            [MBProgress settext:@"上传成功!" aftertime:1.0];
            
            NSString *imageurl=[dic objectForKey:@"personImgUrl"];
            
            [MutableDictionary setObject:imageurl forKey:@"personImgUrl"];
            
            [self.m_tableView reloadData];
        }
        else
        {
            [MBProgress settext:@"上传失败!" aftertime:1.0];
        }
    }
    else
    {
        NSLog(@"json解析错误!");
        
        [MBProgress hide:YES];
    }
}

-(void)upimagerequestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"upimagerequestFailed");
    
    [MBProgress settext:@"网络错误!" aftertime:1.0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    
    if (row==0||row==2||row==5||row==8) {
        static NSString *CellIdentifier = @"Cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor=[UIColor clearColor];
        }
        
        return cell;
    }
    else if(row==3||row==4||row==6||row==7)
    {
        static NSString *CellIdentifier = @"Cell2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            
            UIImageView *backimage=[[UIImageView alloc]init];
            backimage.backgroundColor=[UIColor whiteColor];
            cell.backgroundView=backimage;
            [backimage release];
            
            UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
            lineimage.image=[UIImage imageNamed:@"线.png"];
            [cell.contentView addSubview:lineimage];
            [lineimage release];
            
            UIImageView *jiantouimage=[[UIImageView alloc]initWithFrame:CGRectMake(290, 14, 10, 15)];
            jiantouimage.tag=3;
            jiantouimage.image=[UIImage imageNamed:@"小箭头.png"];
            [cell.contentView addSubview:jiantouimage];
            [jiantouimage release];
            
            UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 100, 20)];
            titlelabel.tag=1;
            titlelabel.font=[UIFont systemFontOfSize:14];
            titlelabel.textAlignment=UITextAlignmentLeft;
            titlelabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:titlelabel];
            [titlelabel release];
            
            UILabel *contlabel=[[UILabel alloc]initWithFrame:CGRectMake(68, 12, 150, 20)];
            contlabel.tag=2;
            contlabel.font=[UIFont systemFontOfSize:14];
            contlabel.textAlignment=UITextAlignmentLeft;
            contlabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:contlabel];
            [contlabel release];
            
            UILabel *nichenlabel=[[UILabel alloc]initWithFrame:CGRectMake(150, 12, 130, 20)];
            nichenlabel.tag=4;
            nichenlabel.font=[UIFont systemFontOfSize:14];
            nichenlabel.textAlignment=UITextAlignmentRight;
            nichenlabel.backgroundColor=[UIColor clearColor];
            nichenlabel.textColor=[UIColor grayColor];
            [cell.contentView addSubview:nichenlabel];
            [nichenlabel release];
        }
        
        UILabel *titlelabel =(UILabel *)[cell.contentView viewWithTag:1];
        UILabel *contlabel =(UILabel *)[cell.contentView viewWithTag:2];
        UIImageView *jiantouimage =(UIImageView *)[cell.contentView viewWithTag:3];
        UILabel *nichenlabel =(UILabel *)[cell.contentView viewWithTag:4];
        contlabel.hidden=YES;
        jiantouimage.hidden=YES;
        nichenlabel.hidden=YES;
        
        switch (row) {
            case 3:
            {
                titlelabel.text=@"账号:";
                contlabel.hidden=NO;
                contlabel.text=[MutableDictionary objectForKey:@"tel"];
            }
                break;
            case 4:
            {
                titlelabel.text=@"手机号";
                contlabel.hidden=YES;
                jiantouimage.hidden=NO;
                nichenlabel.hidden=NO;
                if ([MutableDictionary objectForKey:@"tel"]&&![[MutableDictionary objectForKey:@"tel"] isEqualToString:@""]) {
                    nichenlabel.text=@"已绑定";
                }
                else
                {
                    nichenlabel.text=@"未绑定";
                }
            }
                break;
            case 6:
            {
                titlelabel.text=@"修改昵称";
                jiantouimage.hidden=NO;
                nichenlabel.hidden=NO;
                contlabel.text=@"";
                if ([MutableDictionary objectForKey:@"nickName"]) {
                    nichenlabel.text=[MutableDictionary objectForKey:@"nickName"];
                }
            }
                break;
            case 7:
            {
                titlelabel.text=@"修改密码";
                jiantouimage.hidden=NO;
                contlabel.text=@"";
            }
                break;
            default:
                break;
        }
        
        return cell;
    }
    if (row==1) {
        static NSString *CellIdentifier = @"Cell3";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            
            UIImageView *backimage=[[UIImageView alloc]init];
            backimage.backgroundColor=[UIColor whiteColor];
            cell.backgroundView=backimage;
            [backimage release];
            
            UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 87, 320, 1)];
            lineimage.image=[UIImage imageNamed:@"线.png"];
            [cell.contentView addSubview:lineimage];
            [lineimage release];
            
            UIImageView *touimage=[[UIImageView alloc]initWithFrame:CGRectMake(250, 19, 50, 50)];
            touimage.tag=1;
            touimage.image=[UIImage imageNamed:@"账户数据.png"];
            touimage.layer.masksToBounds = YES;
            touimage.layer.cornerRadius = 25;
            [cell.contentView addSubview:touimage];
            [touimage release];
            
            UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 29, 150, 30)];
            titlelabel.font=[UIFont systemFontOfSize:16];
            titlelabel.textAlignment=UITextAlignmentLeft;
            titlelabel.text=@"头像";
            titlelabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:titlelabel];
            [titlelabel release];
        }
        
        UIImageView *touimage=(UIImageView *)[cell.contentView viewWithTag:1];
        
        if ([MutableDictionary objectForKey:@"personImgUrl"]) {
            [touimage setImageWithURL:[NSURL URLWithString:[MutableDictionary objectForKey:@"personImgUrl"]] placeholderImage:[UIImage imageNamed:@"账户数据.png"]];
        }
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    
    if (row==0||row==2||row==5||row==8) {
        return 20;
    }
    else if(row==3||row==4||row==6||row==7)
    {
        return 44;
    }
    else if(row==1)
    {
        return 88;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger row=[indexPath row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (row==1) {
        UIActionSheet *action =[[[UIActionSheet alloc] initWithTitle:@"图片来自" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil] autorelease];
        [action showInView:self.view];
    }
    else if(row==4)
    {
        if ([[MutableDictionary objectForKey:@"tel"] isEqualToString:@""]) {
            BangdingshoujiViewController *BangdingshoujiView=[[BangdingshoujiViewController alloc]init];
            BangdingshoujiView.hidesBottomBarWhenPushed=YES;
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            [self.navigationController pushViewController:BangdingshoujiView animated:YES];
            [BangdingshoujiView release];
        }
        else
        {
            UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否重新绑定手机号?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            AlertView.tag=1;
            [AlertView show];
            [AlertView release];
        }
    }
    else if(row==6)
    {
        XiugainichenViewController *Xiugainichen=[[XiugainichenViewController alloc]init];
        Xiugainichen.hidesBottomBarWhenPushed=YES;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
        Xiugainichen.Dictionary=self.MutableDictionary;
        Xiugainichen.delegate=self;
        [self.navigationController pushViewController:Xiugainichen animated:YES];
        [Xiugainichen release];
    }
    else if(row==7)
    {
        UserSettingDetailController *userSettingCtr=[[UserSettingDetailController alloc]init];
        userSettingCtr.hidesBottomBarWhenPushed=YES;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
        [self.navigationController pushViewController:userSettingCtr animated:YES];
        [userSettingCtr release];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0)
    {
        if (pickerController == nil) {
            pickerController = [[UIImagePickerController alloc] init];
            pickerController.delegate = self;
            [pickerController setEditing:NO];
            pickerController.allowsEditing=YES;
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == YES) {
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentModalViewController:pickerController animated:YES];
        }
        else
        {
            UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"照片库不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [AlertView show];
            [AlertView release];
        }
    }
    else if (buttonIndex ==1)
    {
        if (pickerController == nil) {
            pickerController = [[UIImagePickerController alloc] init];
            pickerController.delegate = self;
            [pickerController setEditing:NO];
            pickerController.allowsEditing=YES;
        }
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:pickerController animated:YES];
        }
        else
        {
            UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"照相功能不可用!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [AlertView show];
            [AlertView release];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        if (buttonIndex==1) {
            BangdingshoujiViewController *BangdingshoujiView=[[BangdingshoujiViewController alloc]init];
            BangdingshoujiView.hidesBottomBarWhenPushed=YES;
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            [self.navigationController pushViewController:BangdingshoujiView animated:YES];
            [BangdingshoujiView release];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
//    NSLog(@"editingInfo:%@",editingInfo);
    [picker dismissModalViewControllerAnimated:YES];
	if (image) {
        [UserInfo shared].m_toupic = image;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data =  UIImageJPEGRepresentation (image,0.01);
            [self upimagerequest:data];
        });
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

@end
