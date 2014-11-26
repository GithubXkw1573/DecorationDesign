//
//  ActivityCell.m
//  TGQ2
//
//  Created by 许开伟 on 14-8-14.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

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
    [PublicFunction addImageTo:self.contentView Rect:CGRectMake(15, 17, 70, 70) Image:@"" SEL:nil Responsder:self Tag:301];
    
    [PublicFunction addLabelTo:self.contentView Rect:CGRectMake(100, 13, 200*widthRate, 20) Title:@"分享立减30元" TitleColor:[UIColor blackColor] Font:[UIFont fontWithName:@"Helvetica-Bold" size:15] Alignment:NSTextAlignmentLeft Tag:302 MutiRow:NO];
    [PublicFunction addLabelTo:self.contentView Rect:CGRectMake(100, 32, 200*widthRate, 40) Title:@"三倍金币又回来啦，立减30元，只需要分享1篇文章即可" TitleColor:[UIColor blackColor] Font:font(13) Alignment:NSTextAlignmentLeft Tag:303 MutiRow:YES];
    
    [PublicFunction addLabelTo:self.contentView Rect:CGRectMake(100, 70, 100, 20) Title:@"07/07截止" TitleColor:[UIColor grayColor] Font:font(12) Alignment:NSTextAlignmentLeft Tag:304 MutiRow:NO];
    
    [PublicFunction addLabelTo:self.contentView Rect:CGRectMake(240*widthRate, 70, 60, 20) Title:@"07/07截止" TitleColor:[UIColor grayColor] Font:font(12) Alignment:NSTextAlignmentRight Tag:305 MutiRow:NO];
    
    [PublicFunction addImageTo:self.contentView Rect:CGRectMake(0, 104, applicationwidth, 1) Image:@"线" SEL:nil Responsder:nil Tag:0];
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
    [imageView setImageWithURL:[NSURL URLWithString:[PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"imgPath"]] placeholderImage:[UIImage imageNamed:@"默认占位图"]];
    nameLabel.text = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"name"];
    remarkLabel.text = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"remark"];
    dateLabel.text = [PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"endTime"];
    NSString *distance = [NSString stringWithFormat:@"%.2f",[[PublicFunction getSubDictionaryValue:dic withKey:@"coupons" subKey:@"metre"] floatValue]/1000];
    distanceLabel.text = [NSString stringWithFormat:@"%@km",distance];
}

@end
