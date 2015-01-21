//
//  CommentCell.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/16.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell
@synthesize headImage,name,addr,time,comment;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // Initialization code
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 14, 35, 35)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = imageView.frame.size.width/2.f;
        headImageView = imageView;
        [self addSubview:imageView];
        [imageView release];
        
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 12, 200, 20)];
        lbl1.textColor = [UIColor grayColor];
        lbl1.font = font(16);
        nameLabel = lbl1;
        [self addSubview:lbl1];
        [lbl1 release];
        
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 32, 80, 20)];
        lbl2.textColor = [UIColor grayColor];
        lbl2.font = font(14);
        addrLabel = lbl2;
        [self addSubview:lbl2];
        [lbl2 release];
        
        UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(200, 32, 100, 20)];
        lbl3.textColor = [UIColor grayColor];
        lbl3.font = font(14);
        timeLabel = lbl3;
        [self addSubview:lbl3];
        [lbl3 release];
        
        myLabel *lbl4 = [[myLabel alloc] initWithFrame:CGRectMake(60, 55, 250, 40)];
        lbl4.textColor = [UIColor blackColor];
        lbl4.verticalAlignment = VerticalAlignmentTop_m;
        lbl4.numberOfLines = 0;
        lbl4.font = font(14);
        commentLabel = lbl4;
        [self addSubview:lbl4];
        [lbl4 release];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, self.frame.size.width-6, 1)];
        line.image = [UIImage imageNamed:@"线"];
        line.tag = 23;
        [self addSubview:line];
        [line release];
    }
    return self;
}

-(void)setHeadImage:(UIImage *)_headImage
{
    headImageView.image = _headImage;
}

-(void)setName:(NSString *)_name
{
    nameLabel.text = _name;
}

-(void)setAddr:(NSString *)_addr
{
    addrLabel.text = _addr;
}

-(void)setTime:(NSString *)_time
{
    timeLabel.text = _time;
}

-(void)setComment:(NSString *)_comment
{
    commentLabel.text = _comment;
    commentSize = [_comment sizeWithFont:font(14) constrainedToSize:CGSizeMake(250, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    commentLabel.frame = CGRectMake(commentLabel.frame.origin.x, commentLabel.frame.origin.y, 250, commentSize.height);
    UIImageView *line = (UIImageView*)[self viewWithTag:23];
    line.frame = CGRectMake(line.frame.origin.x, 69+commentSize.height, line.frame.size.width, line.frame.size.height);
}

-(CGFloat)cellHeight
{
    return 50+commentSize.height+20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(NSString*)returnFormatTime:(NSString *)timeStr
{
    NSString *month = [timeStr substringWithRange:NSMakeRange (4, 2)];
    NSString *day =[timeStr substringWithRange:NSMakeRange (6, 2)];
    NSString *hour = [timeStr substringWithRange:NSMakeRange (8, 2)];
    NSString *minit = [timeStr substringWithRange:NSMakeRange (10, 2)];
    return [NSString stringWithFormat:@"%@-%@ %@:%@",month,day,hour,minit];
}

-(void)setCell:(NSArray *)array withRow:(NSInteger)row
{
    [headImageView setImageWithURL:[NSURL URLWithString:[array objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"Pinglun_img5"]];
    nameLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    addrLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    timeLabel.text = [NSString stringWithFormat:@"%@",[self returnFormatTime:[array objectAtIndex:3]]];
    commentLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
    commentSize = [commentLabel.text sizeWithFont:font(14) constrainedToSize:CGSizeMake(250, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    commentLabel.frame = CGRectMake(commentLabel.frame.origin.x, commentLabel.frame.origin.y, 250, commentSize.height);
    UIImageView *line = (UIImageView*)[self viewWithTag:23];
    line.frame = CGRectMake(line.frame.origin.x, 69+commentSize.height, line.frame.size.width, line.frame.size.height);
}

@end
