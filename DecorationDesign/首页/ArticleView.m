//
//  ArticleView.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "ArticleView.h"

@implementation ArticleView
@synthesize currController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        MBProgress=[[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, 160)];
        [MBProgress setCenter:CGPointMake(applicationwidth/2.0f, applicationheight/2-120)];
        [self addSubview:MBProgress];
        [MBProgress show:YES];
        [MBProgress setLabelText:@"刷新中"];
        
        m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
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
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifity = @"cell1";
    ArticleTableViewCell *cell = (ArticleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifity];
    if (cell==nil) {
        cell = [[[ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifity] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [m_tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZiliaoDetaillViewController *ziliao = [[ZiliaoDetaillViewController alloc] init];
    [self.currController pushViewController:ziliao animated:YES];
    [ziliao release];
}

@end
