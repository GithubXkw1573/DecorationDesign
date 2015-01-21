//
//  ArticleTableViewCell.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell
@synthesize titleLabel,contentLabel,dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 90)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        backView.layer.borderWidth = 1.0f;
        [self.contentView addSubview:backView];
        [backView release];
        
        UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-130, 30)];
        self.titleLabel = title1;
        title1.text = @"一嗨租车上市首日破发，梦醒纽交所";
        title1.backgroundColor = [UIColor clearColor];
        title1.font = bold_font(14);
        [backView addSubview:title1];
        [title1 release];
        
        UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.size.width-100, 0, 100, 30)];
        self.dateLabel = title2;
        title2.text = @"2014年12月12号";
        title2.backgroundColor = [UIColor clearColor];
        title2.font = font(14);
        [backView addSubview:title2];
        [title2 release];
        
        //线
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, backView.frame.size.width, 1)];
        line.image = [UIImage imageNamed:@"线"];
        line.backgroundColor = [UIColor clearColor];
        [backView addSubview:line];
        [line release];
        
        UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, backView.frame.size.width-20, 50)];
        title3.text = @"一嗨租车，是一家总部位于上海的在线租车公司。公司报告显示，2014年上半年，一嗨的营业收入达到3.85亿元人民币，同比增长47.5%，是行业平均增速2倍以上。10月3日，一嗨向美国证券交易委员会提交首次公开募股(IPO)申请，计划于11月14日在纽交所上市，以每股12美元发行1,000万股美国存托股票(ADS)，预计募集资金1.2亿美元。";
        self.contentLabel = title3;
        title3.numberOfLines = 3;
        title3.backgroundColor = [UIColor clearColor];
        title3.font = font(13);
        [backView addSubview:title3];
        [title3 release];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
