//
//  DesignerListCell.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/21.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "DesignerListCell.h"

@implementation DesignerListCell
@synthesize designerPicView,bookingLabel,boutiqueLabel,signedLabel,worksLabel,titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 10, 80, 60)];
        picView.backgroundColor = [UIColor clearColor];
        picView.image = [UIImage imageNamed:@"家装公司小图"];
        self.designerPicView = picView;
        [self.contentView addSubview:picView];
        [picView release];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(96, 10, 210, 24)];
        title.text = @"江苏达芬奇设计有限公司";
        title.backgroundColor = [UIColor clearColor];
        title.font = font(15);
        self.titleLabel = title;
        [self.contentView addSubview:title];
        [title release];
        
        UILabel *zuoping = [[UILabel alloc] initWithFrame:CGRectMake(96, 36, 60, 18)];
        zuoping.text = @"设计作品:";
        zuoping.backgroundColor = [UIColor clearColor];
        zuoping.font = font(13);
        zuoping.textColor = [UIColor grayColor];
        [self.contentView addSubview:zuoping];
        [zuoping release];
        UILabel *zuopingValue = [[UILabel alloc] initWithFrame:CGRectMake(156, 36, 50, 18)];
        zuopingValue.text = @"5236";
        zuopingValue.backgroundColor = [UIColor clearColor];
        zuopingValue.font = font(13);
        self.worksLabel = zuopingValue;
        zuopingValue.textColor = [UIColor grayColor];
        [self.contentView addSubview:zuopingValue];
        [zuopingValue release];
        
        UILabel *jingping = [[UILabel alloc] initWithFrame:CGRectMake(216, 36, 50, 18)];
        jingping.text = @"精品:";
        jingping.backgroundColor = [UIColor clearColor];
        jingping.font = font(13);
        jingping.textColor = [UIColor grayColor];
        [self.contentView addSubview:jingping];
        [jingping release];
        UILabel *jingpingValue = [[UILabel alloc] initWithFrame:CGRectMake(266, 36, 50, 18)];
        jingpingValue.text = @"88";
        jingpingValue.backgroundColor = [UIColor clearColor];
        jingpingValue.font = font(13);
        self.boutiqueLabel = jingpingValue;
        jingpingValue.textColor = [UIColor grayColor];
        [self.contentView addSubview:jingpingValue];
        [jingpingValue release];
        
        UILabel *yuyuecishu = [[UILabel alloc] initWithFrame:CGRectMake(96, 54, 40, 18)];
        yuyuecishu.text = @"评论:";
        yuyuecishu.backgroundColor = [UIColor clearColor];
        yuyuecishu.font = font(13);
        yuyuecishu.textColor = [UIColor grayColor];
        [self.contentView addSubview:yuyuecishu];
        [yuyuecishu release];
        UILabel *yuyuecishuValue = [[UILabel alloc] initWithFrame:CGRectMake(136, 54, 60, 18)];
        yuyuecishuValue.text = @"87";
        yuyuecishuValue.backgroundColor = [UIColor clearColor];
        yuyuecishuValue.font = font(13);
        self.bookingLabel = yuyuecishuValue;
        yuyuecishuValue.textColor = [UIColor grayColor];
        [self.contentView addSubview:yuyuecishuValue];
        [yuyuecishuValue release];
        
//        UILabel *qiandancishu = [[UILabel alloc] initWithFrame:CGRectMake(206, 54, 60, 18)];
//        qiandancishu.text = @"签单次数:";
//        qiandancishu.backgroundColor = [UIColor clearColor];
//        qiandancishu.font = font(13);
//        qiandancishu.textColor = [UIColor grayColor];
//        [self.contentView addSubview:qiandancishu];
//        [qiandancishu release];
//        UILabel *qiandancishuValue = [[UILabel alloc] initWithFrame:CGRectMake(266, 54, 50, 18)];
//        qiandancishuValue.text = @"88";
//        qiandancishuValue.backgroundColor = [UIColor clearColor];
//        qiandancishuValue.font = font(13);
//        self.signedLabel = qiandancishuValue;
//        qiandancishuValue.textColor = [UIColor grayColor];
//        [self.contentView addSubview:qiandancishuValue];
//        [qiandancishuValue release];
        
        
//        UIButton *guanzhu = [[UIButton alloc] initWithFrame:CGRectMake(250, 10, 60, 25)];
//        guanzhu.backgroundColor = [UIColor clearColor];
//        [guanzhu setImage:[UIImage imageNamed:@"guanzhu_btn2"] forState:UIControlStateNormal];
//        [guanzhu addTarget:self action:@selector(guanzhuClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:guanzhu];
//        [guanzhu release];
    }
    return self;
}

-(void)setCellData:(NSArray*)item
{
    [self.designerPicView setImageWithURL:[NSURL URLWithString:[item objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"家装公司小图"]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:2]];
    self.worksLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:3]];
    self.boutiqueLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:4]];
    self.bookingLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:5]];
//    self.signedLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:5]];
}
-(void)guanzhuClicked:(UIButton*)btn
{
    //加关注
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
