//
//  IntroduceView.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "PersonIntroduceView.h"

@implementation PersonIntroduceView

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
    int row=[indexPath row];
    if (row == 1) {
        static NSString *cellIdentifity = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifity] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *backimage=[[UIImageView alloc]init];
            backimage.backgroundColor=[UIColor whiteColor];
            cell.backgroundView=backimage;
            [backimage release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_tableView.frame.size.width, 1)];
            line.image = [UIImage imageNamed:@"线"];
            line.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:line];
            [line release];
            
            UILabel *introducelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 290, 80)];
            introducelabel.numberOfLines = 0;
            introducelabel.text = @"刘烨，1978年3月23日生于吉林省长春市，中国内地男演员，吉林省青年联合会副主席、中国电影家协会会员、中国国家话剧院演员。2000年毕业于中央戏剧学院表演系[1-2]。";
            introducelabel.backgroundColor = [UIColor clearColor];
            introducelabel.font = font(13);
            [cell.contentView addSubview:introducelabel];
            [introducelabel release];
        }
        
        return cell;
    }else if (row == 3)
    {
        static NSString *cellIdentifity = @"cell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifity] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *backimage=[[UIImageView alloc]init];
            backimage.backgroundColor=[UIColor whiteColor];
            cell.backgroundView=backimage;
            [backimage release];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_tableView.frame.size.width, 1)];
            line.image = [UIImage imageNamed:@"线"];
            line.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:line];
            [line release];
            
            UILabel *awazelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 290, 160)];
            awazelabel.numberOfLines = 0;
            awazelabel.text = @"1999年，主演的第一部电影《那人那山那狗》获蒙特利尔国际电影节最受观众欢迎故事片奖[1] 。2001年，23岁的刘烨凭借电影《蓝宇》获得台湾电影金马奖最佳男主角奖[3] 。2004年，参演电影《美人草》获得中国电影金鸡奖最佳男主角奖[1] 。2005年，主演电视剧《血色浪漫》饰演钟跃民[2] 。2007年，与好莱坞女星梅丽尔斯特里普主演《暗物质》[4] 。2013年，与成龙领衔合作的《警察故事2013》。2014年主演电视剧《北平无战事》[5] 。";
            awazelabel.backgroundColor = [UIColor clearColor];
            awazelabel.font = font(13);
            [cell.contentView addSubview:awazelabel];
            [awazelabel release];
        }
        
        return cell;
    }
    else
    {
        static NSString *cellIdentifity = @"cellIdentifity";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifity] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *backimage=[[UIImageView alloc]init];
            backimage.backgroundColor=[UIColor whiteColor];
            cell.backgroundView=backimage;
            [backimage release];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 25)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.tag = 55;
            titleLabel.font = font(15);
            [cell.contentView addSubview:titleLabel];
            [titleLabel release];
        }
        UILabel *title = (UILabel*)[cell.contentView viewWithTag:55];
        if (row ==0) {
            title.text = @"个人简介";
        }else{
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_tableView.frame.size.width, 1)];
            line.image = [UIImage imageNamed:@"线"];
            line.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:line];
            [line release];
            title.text = @"所获奖项";
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    if (row ==0 || row == 2) {
        return 30;
    }else if (row==1){
        return 100;
    }else{
        return 170;
    }
}

@end
