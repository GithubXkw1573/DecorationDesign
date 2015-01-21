//
//  ZuopingView.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "ZuopingView.h"

@implementation ZuopingView
@synthesize zuopingList,currController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zuopingList = [[NSMutableArray alloc] init];
        
        MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160)];
        [MBProgress setCenter:CGPointMake(applicationwidth/2.0f, applicationheight/2-120)];
        [self addSubview:MBProgress];
        [MBProgress show:YES];
        [MBProgress setLabelText:@"刷新中"];
        
        m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
        m_tableView.layer.borderWidth = 1.0f;
        m_tableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIImageView *backimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        backimage.image=[UIImage imageNamed:@"背景.png"];
        m_tableView.backgroundView = backimage;
        [backimage release];
        [self addSubview:m_tableView];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifity = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity];
    if (cell==nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifity] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIImageView *backimage=[[UIImageView alloc]init];
        backimage.backgroundColor=[UIColor whiteColor];
        cell.backgroundView=backimage;
        [backimage release];
        
        UIButton *leftimage = [[UIButton alloc] initWithFrame:CGRectMake(30, 20, 100, 100)];
        [leftimage setImage:[UIImage imageNamed:@"家装公司小图"] forState:UIControlStateNormal];
        leftimage.backgroundColor = [UIColor clearColor];
        leftimage.tag = 41;
        [leftimage addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:leftimage];
        [leftimage release];
        
        UIButton *rightimage = [[UIButton alloc] initWithFrame:CGRectMake(170, 20, 100, 100)];
        [rightimage setImage:[UIImage imageNamed:@"家装公司小图2"] forState:UIControlStateNormal];
        rightimage.backgroundColor = [UIColor clearColor];
        rightimage.tag = 42;
        [rightimage addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:rightimage];
        [rightimage release];
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(void)buttonClicked:(UIButton*)btn
{
    ZuopingLookViewController *zuping = [[ZuopingLookViewController alloc] init];
    [self.currController pushViewController:zuping animated:YES];
    [zuping release];
}

@end
