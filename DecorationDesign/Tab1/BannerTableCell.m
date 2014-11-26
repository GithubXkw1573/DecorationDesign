//
//  BannerTableCell.m
//  TGQ2
//
//  Created by 许开伟 on 14-8-25.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "BannerTableCell.h"

@implementation BannerTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleGray;
        [self initComponent];
    }
    return self;
}

-(void)initComponent
{
    [PublicFunction addImageTo:self.contentView Rect:CGRectMake(0, 0, applicationwidth, 125) Image:@"" SEL:nil Responsder:self Tag:301];
    UIImageView *bigPic = (UIImageView*)[self.contentView viewWithTag:301];
    
    [PublicFunction addImageTo:bigPic Rect:CGRectMake(0, 0, applicationwidth, 125) Image:@"黑色半透明" SEL:nil Responsder:nil Tag:402];
    UIImageView *zhezhao = (UIImageView*)[bigPic viewWithTag:402];
    
    [PublicFunction addLabelTo:zhezhao Rect:CGRectMake(15, 50, 290*widthRate, 20) Title:@"分享立减30元" TitleColor:[UIColor whiteColor] Font:[UIFont fontWithName:@"Helvetica-Bold" size:15] Alignment:NSTextAlignmentLeft Tag:302 MutiRow:NO];
    
    [PublicFunction addLabelTo:zhezhao Rect:CGRectMake(15, 70, 290*widthRate, 40) Title:@"三倍金币又回来啦，立减30元，只需要分享1篇文章即可" TitleColor:[UIColor whiteColor] Font:font(13) Alignment:NSTextAlignmentLeft Tag:303 MutiRow:YES];
    
    [PublicFunction addLabelTo:zhezhao Rect:CGRectMake(15, 105, 100*widthRate, 20) Title:@"07/07截止" TitleColor:[UIColor whiteColor] Font:bold_font(12) Alignment:NSTextAlignmentLeft Tag:304 MutiRow:NO];
    
    [PublicFunction addLabelTo:zhezhao Rect:CGRectMake(200*widthRate, 105, 100, 20) Title:@"0.0km" TitleColor:[UIColor whiteColor] Font:bold_font(12) Alignment:NSTextAlignmentRight Tag:305 MutiRow:NO];
    
    [PublicFunction addImageTo:zhezhao Rect:CGRectMake(300*widthRate, 50, 8, 10) Image:@"小箭头" SEL:nil Responsder:nil Tag:0];
    
    [PublicFunction addImageTo:self.contentView Rect:CGRectMake(0, 124, applicationwidth, 1) Image:@"线" SEL:nil Responsder:nil Tag:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setCell:(NSDictionary *)dic row:(int)row
{
    self.m_dictionary = dic;
    UIImageView *imageView =(UIImageView*)[self.contentView viewWithTag:301];
    UILabel *nameLabel = (UILabel*)[self.contentView viewWithTag:302];
    UILabel *remarkLabel = (UILabel*)[self.contentView viewWithTag:303];
    UILabel *dateLabel = (UILabel*)[self.contentView viewWithTag:304];
    UILabel *distanceLabel = (UILabel*)[self.contentView viewWithTag:305];
    nameLabel.adjustsFontSizeToFitWidth = NO;
    [imageView setImageWithURL:[NSURL URLWithString:[PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"imgPath"]] placeholderImage:[UIImage imageNamed:@"默认活动图"]];
    nameLabel.text = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"name"];
    remarkLabel.text = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"remark"];
    dateLabel.text = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"endTime"];
    //NSString *distance = [NSString stringWithFormat:@"%.2f",[[PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"metre"] floatValue]/1000];
    NSString *distance = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"metre"];
    distanceLabel.text = [NSString stringWithFormat:@"%@",distance];
}

@end
