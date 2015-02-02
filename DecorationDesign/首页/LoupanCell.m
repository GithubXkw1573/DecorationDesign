//
//  LoupanCell.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "LoupanCell.h"

@implementation LoupanCell

@synthesize designerPicView,typeLabel,addrLabel,commentLabel,titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 15, 80, 72)];
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
        
        UILabel *jingping = [[UILabel alloc] initWithFrame:CGRectMake(96, 33, 40, 18)];
        jingping.text = @"定位:";
        jingping.backgroundColor = [UIColor clearColor];
        jingping.font = font(12);
        jingping.textColor = [UIColor grayColor];
        [self.contentView addSubview:jingping];
        [jingping release];
        UILabel *jingpingValue = [[UILabel alloc] initWithFrame:CGRectMake(136, 33, 170, 18)];
        jingpingValue.text = @"88";
        jingpingValue.backgroundColor = [UIColor clearColor];
        jingpingValue.font = font(12);
        self.typeLabel = jingpingValue;
        jingpingValue.textColor = [UIColor grayColor];
        [self.contentView addSubview:jingpingValue];
        [jingpingValue release];
        
        UILabel *addr = [[UILabel alloc] initWithFrame:CGRectMake(96, 51, 40, 18)];
        addr.text = @"地址:";
        addr.backgroundColor = [UIColor clearColor];
        addr.font = font(12);
        addr.textColor = [UIColor grayColor];
        [self.contentView addSubview:addr];
        [addr release];
        UILabel *addrValue = [[UILabel alloc] initWithFrame:CGRectMake(136, 51, 170, 18)];
        addrValue.text = @"88";
        addrValue.backgroundColor = [UIColor clearColor];
        addrValue.font = font(12);
        self.addrLabel = addrValue;
        addrValue.textColor = [UIColor grayColor];
        [self.contentView addSubview:addrValue];
        [addrValue release];
        
        UILabel *yuyuecishu = [[UILabel alloc] initWithFrame:CGRectMake(96, 69, 40, 18)];
        yuyuecishu.text = @"评论:";
        yuyuecishu.backgroundColor = [UIColor clearColor];
        yuyuecishu.font = font(12);
        yuyuecishu.textColor = [UIColor grayColor];
        [self.contentView addSubview:yuyuecishu];
        [yuyuecishu release];
        UILabel *yuyuecishuValue = [[UILabel alloc] initWithFrame:CGRectMake(136, 69, 170, 18)];
        yuyuecishuValue.text = @"87";
        yuyuecishuValue.backgroundColor = [UIColor clearColor];
        yuyuecishuValue.font = font(12);
        self.commentLabel = yuyuecishuValue;
        yuyuecishuValue.textColor = [UIColor grayColor];
        [self.contentView addSubview:yuyuecishuValue];
        [yuyuecishuValue release];
        
        
    }
    return self;
}

-(void)setCellData:(NSArray*)item withSelected:(NSMutableArray*)selectList withIndex:(NSInteger)index
{
    [self.designerPicView setImageWithURL:[NSURL URLWithString:[item objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"家装公司小图"]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:2]];
    self.typeLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:3]];
    self.addrLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:4]];
    self.commentLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:5]];
    //    self.signedLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:5]];
    if ([selectList count]>index) {
        if ([[selectList objectAtIndex:index] isEqualToString:@"yes"]) {
            self.titleLabel.textColor = [UIColor grayColor];
        }else{
            self.titleLabel.textColor = [UIColor blackColor];
        }
    }
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
