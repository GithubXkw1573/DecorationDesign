//
//  DistributeController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "DistributeController.h"
#import "LoginViewController.h"

@interface DistributeController ()

@end

@implementation DistributeController
@synthesize onlineNum,nameField,telField,areaField,bugetField,typeField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNaviWithTitle:@"发布需求"];
    [self initComponents];
    
    
}

-(void)startDistribute
{
    if ([UserInfo shared].m_isLogin) {
        if ([self validateNotNull]) {
            NSURL *url = [NSURL URLWithString:MineURL];
            HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
            //NSLog(@"%@_%@__%@___%@___%@___%@__%@",[UserInfo shared].m_Id,@"USERID",nameField.text,telField.text,bugetField.text,areaField.text,[UserInfo shared].m_session);
            request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"SEND_REQUIRE",@"JUDGEMETHOD",[UserInfo shared].m_Id,@"USERID",nameField.text,@"USERNAME",telField.text,@"PHONE", bugetField.text,@"MONEY",areaField.text,@"AREA",typeField.text,@"PROJECTTYPE",[UserInfo shared].m_session,@"SESSION",nil];
            [request setCompletionBlock:^(NSDictionary *result){
                if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
                    //调用成功
                    [self resetFields];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"信息不完整,请填写完整信息再发布!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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

-(BOOL)validateNotNull
{
    if ([nameField.text isEqualToString:@""] || [telField.text isEqualToString:@""] || [bugetField.text isEqualToString:@""] || [areaField.text isEqualToString:@""] || [typeField.text isEqualToString:@""]) {
        return NO;
    }else{
        return YES;
    }
}

-(void)resetFields
{
    nameField.text = @"";
    telField.text = @"";
    bugetField.text = @"";
    areaField.text = @"";
    typeField.text = @"";
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
    
}

-(void)initComponents
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 142*widthRate)];
    imageView.image = [UIImage imageNamed:@"GR_bg"];
    imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageView];
    [imageView release];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 142*widthRate, applicationwidth, 40)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView release];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    tipLabel.text = @"亲，目前已有";
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.font = font(16);
    [backView addSubview:tipLabel];
    [tipLabel release];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 100, 40)];
    numLabel.text = @"1236547";
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.font = font(16);
    self.onlineNum = numLabel;
    numLabel.textColor = [UIColor redColor];
    [backView addSubview:numLabel];
    [numLabel release];
    
    CGSize size = [numLabel.text sizeWithFont:font(16) constrainedToSize:CGSizeMake(100, 40) lineBreakMode:NSLineBreakByWordWrapping];
    numLabel.frame= CGRectMake(110, 0, size.width+5, 40);
    
    UILabel *tip2Label = [[UILabel alloc] initWithFrame:CGRectMake(110+size.width, 0, 100, 40)];
    tip2Label.text = @"人发布需求";
    tip2Label.backgroundColor = [UIColor clearColor];
    tip2Label.font = font(16);
    [backView addSubview:tip2Label];
    [tip2Label release];
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 142*widthRate+40, applicationwidth, applicationheight-49-44-142*widthRate-40) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor whiteColor];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row<5) {
        static NSString *identifierCell = @"cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 44)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = font(15);
            titleLabel.tag =11;
            [cell.contentView addSubview:titleLabel];
            [titleLabel release];
            
            UITextField *contentField = [[UITextField alloc] initWithFrame:CGRectMake(80, 7, 220, 30)];
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
            titleLabel.text = @"姓名：";
            self.nameField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==1){
            titleLabel.text = @"电话：";
            self.telField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==2){
            titleLabel.text = @"预算：";
            self.bugetField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==3){
            titleLabel.text = @"面积：";
            self.areaField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==4){
            titleLabel.text = @"类型：";
            self.typeField = contentField;
            contentField.returnKeyType = UIReturnKeyDone;
        }
        return cell;
    }else{
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            UIButton *fabuBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
            [fabuBtn setImage:[UIImage imageNamed:@"fabu_btn"] forState:UIControlStateNormal];
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
    if (indexPath.row<5) {
        return 44;
    }else{
        return 60;
    }
}

-(void)buttonClicked:(UIButton*)btn
{
    [self startDistribute];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.bugetField){
        [self movoTo:-60];
    }else if (textField==self.areaField){
        [self movoTo:-120];
    }else if (textField==self.typeField){
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
        [self.bugetField  becomeFirstResponder];
        [self movoTo:-20];
    }else if (textField==self.bugetField){
        [self.areaField becomeFirstResponder];
        [self movoTo:-60];
    }else if (textField==self.areaField){
        [self.typeField becomeFirstResponder];
        [self movoTo:-120];
    }else if (textField==self.typeField){
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
