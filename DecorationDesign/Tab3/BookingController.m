//
//  BookingController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "BookingController.h"

@interface BookingController ()

@end

@implementation BookingController
@synthesize othersField,nameField,telField,areaField,typeField,qqField,cityField;

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
    
}

-(void)initComponents
{
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, 40)];
    tipLabel.text = @"  请留下你的信息，让张三丰联系你";
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.font = font(16);
    [self.view addSubview:tipLabel];
    [tipLabel release];
    
    
    
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 50, applicationwidth, applicationheight-49-44-50) style:UITableViewStylePlain];
    m_tableView.delegate =self;
    m_tableView.dataSource =self;
    m_tableView.backgroundColor=[UIColor whiteColor];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
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
    int row = indexPath.row;
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
            self.nameField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==1){
            titleLabel.text = @"您的电话：";
            self.telField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==2){
            titleLabel.text = @"您的QQ：";
            self.qqField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==3){
            titleLabel.text = @"装修面积：";
            self.areaField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==4){
            titleLabel.text = @"项目类型：";
            self.typeField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==5){
            titleLabel.text = @"所在城市：";
            self.cityField = contentField;
            contentField.returnKeyType = UIReturnKeyNext;
        }else if (row==6){
            titleLabel.text = @"其他说明：";
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

-(void)buttonClicked:(UIButton*)btn
{
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.typeField){
        [self movoTo:-60];
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
        [self.typeField becomeFirstResponder];
        [self movoTo:-20];
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
