//
//  BookingViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/18.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "BookingViewController.h"

@interface BookingViewController ()

@end

@implementation BookingViewController
@synthesize othersField,nameField,telField,areaField,typeField,qqField,cityField,designerId,designerName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNaviWithTitle:@"预约"];
    [self initComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)initNaviWithTitle:(NSString*)title
{
    if (iOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"标题栏%i.png",[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?7:6]] forBarMetrics:UIBarMetricsDefault];
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80*widthRate, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=title;
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-20, 0, 60, 44);
    leftbtn.tag=1;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(yuyueViewControllerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
}

-(void)initComponents
{
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 40)];
    tipLabel.text = [NSString stringWithFormat:@"  请留下你的信息，让%@联系你",designerName];
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.font = font(16);
    [self.view addSubview:tipLabel];
    [tipLabel release];
    
    
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 50, applicationwidth, applicationheight-44-50) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor whiteColor];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
    
    MyPickerView *pickerr = [[MyPickerView alloc] initWithFrame:CGRectMake(0, applicationheight-44, applicationwidth, 220)];
    pickerr.backgroundColor = [UIColor whiteColor];
    pickerr.dataList = @[@"普通住宅",@"单身公寓",@"花园别墅",@"家庭住宅"];
    pickerr.selectItemAtIndex = ^(NSInteger index){
        NSLog(@"%li",index);
        if (self.typeField) {
            self.typeField.text = [NSString stringWithFormat:@"%@",[pickerr.dataList objectAtIndex:index]];
        }
    };
    pickerView = pickerr;
    [self.view addSubview:pickerr];
    [pickerr release];
}

-(void)yuyueViewControllerBtnPressed:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row<7) {
        static NSString *identifierCell = @"cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 75, 44)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = font(15);
            titleLabel.tag =11;
            [cell.contentView addSubview:titleLabel];
            [titleLabel release];
            
            UITextField *contentField = [[UITextField alloc] initWithFrame:CGRectMake(95, 7, 205, 30)];
            contentField.font = font(15);
            contentField.tag = 12;
            contentField.delegate = self;
            contentField.layer.borderColor = [[UIColor grayColor] CGColor];
            contentField.layer.borderWidth=0.5f;
            contentField.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:contentField];
            [contentField release];
        }
        UILabel *titleLabel = (UILabel*)[cell.contentView viewWithTag:11];
        UITextField *contentField = (UITextField*)[cell.contentView viewWithTag:12];
        if (row==0) {
            titleLabel.text = @"您的姓名：";
            contentField.placeholder = @"必填";
            self.nameField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==1){
            titleLabel.text = @"您的电话：";
            contentField.placeholder = @"必填";
            self.telField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==2){
            titleLabel.text = @"您的QQ：";
            contentField.placeholder = @"可不填";
            self.qqField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==3){
            titleLabel.text = @"装修面积：";
            contentField.placeholder = @"必填";
            self.areaField = contentField;
            contentField.returnKeyType = UIReturnKeyDone;
        }else if (row==4){
            titleLabel.text = @"项目类型：";
            contentField.placeholder = @"必填";
            self.typeField = contentField;
            contentField.returnKeyType = UIReturnKeyDone;
        }else if (row==5){
            titleLabel.text = @"所在城市：";
            contentField.placeholder = @"必填";
            self.cityField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==6){
            titleLabel.text = @"其他说明：";
            contentField.placeholder = @"可不填";
            self.othersField = contentField;
            contentField.returnKeyType = UIReturnKeyDone;
        }
        return cell;
    }else{
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            UIButton *fabuBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
            [fabuBtn setImage:[UIImage imageNamed:@"yuyue_btn"] forState:UIControlStateNormal];
            fabuBtn.backgroundColor = [UIColor clearColor];
            [fabuBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:fabuBtn];
            [fabuBtn release];
        }
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<7) {
        return 44;
    }else{
        return 80;
    }
}

-(BOOL)validateNotNull
{
    if ([nameField.text isEqualToString:@""] || [telField.text isEqualToString:@""] || [cityField.text isEqualToString:@""] || [areaField.text isEqualToString:@""] || [typeField.text isEqualToString:@""]) {
        return NO;
    }else{
        return YES;
    }
}

-(void)resetFields
{
    nameField.text = @"";
    telField.text = @"";
    qqField.text = @"";
    areaField.text = @"";
    typeField.text = @"";
    cityField.text = @"";
    othersField.text = @"";
}

-(void)startDisappoint
{
    if ([UserInfo shared].m_isLogin) {
        if ([self validateNotNull]) {
            NSURL *url = [NSURL URLWithString:MineURL];
            HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
            //NSLog(@"%@_%@__%@___%@___%@___%@__%@",[UserInfo shared].m_Id,@"USERID",nameField.text,telField.text,bugetField.text,areaField.text,[UserInfo shared].m_session);
            request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"SEND_APPOINTMENT",@"JUDGEMETHOD",[UserInfo shared].m_Id,@"USERID",nameField.text,@"USERNAME",telField.text,@"PHONE",qqField.text,@"QQ", cityField.text,@"CITY",areaField.text,@"AREA",typeField.text,@"PROJECTTYPE",othersField.text,@"REMARK",[UserInfo shared].m_session,@"SESSION",nil];
            [request setCompletionBlock:^(NSDictionary *result){
                if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
                    //调用成功
                    [self resetFields];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"预约成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    [alert release];
                }else {
                    NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
                    NSLog(@"%@",errrDesc);
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errrDesc delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    [alert release];
                }
            }];
            [request setFailedBlock:^{
                NSLog(@"网络错误");
            }];
            [request startRequest];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"信息不完整,请填写完整信息再预约!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }else{
        //登录
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        [login release];
    }
    
}

-(void)buttonClicked:(UIButton*)btn
{
    [self startDisappoint];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.typeField){
        [pickerView show];
        return NO;
    }else if (textField==self.cityField){
        [self movoTo:-120];
    }else if (textField==self.othersField){
        [self movoTo:-150];
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.nameField) {
        [self.telField becomeFirstResponder];
        [self movoTo:0];
    }else if (textField==self.telField){
        [self.qqField  becomeFirstResponder];
        [self movoTo:0];
    }else if (textField==self.qqField){
        [self.areaField becomeFirstResponder];
        [self movoTo:0];
    }else if (textField==self.areaField){
        [self.areaField resignFirstResponder];
        [self movoTo:64];
    }else if (textField==self.typeField){
        [self.cityField becomeFirstResponder];
        [self movoTo:-60];
    }else if (textField==self.cityField){
        [self.othersField becomeFirstResponder];
        [self movoTo:-120];
    }else if (textField==self.othersField){
        [self.view endEditing:YES];
        [self movoTo:64];
        return NO;
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

@end
