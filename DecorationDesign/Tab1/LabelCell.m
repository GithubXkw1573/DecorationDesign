//
//  LabelCell.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/17.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "LabelCell.h"

@implementation LabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        myLabel *lbl4 = [[myLabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-20, 40)];
        lbl4.textColor = [UIColor blackColor];
        lbl4.verticalAlignment = VerticalAlignmentTop_m;
        lbl4.numberOfLines = 0;
        lbl4.font = font(14);
        contentLabel = lbl4;
        [self addSubview:lbl4];
        [lbl4 release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setContentwithText:(NSString *)text
{
    contentLabel.text = text;
    contentSize = [contentLabel.text sizeWithFont:font(14) constrainedToSize:CGSizeMake(self.frame.size.width-20, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, self.frame.size.width-20, contentSize.height);
}

-(CGFloat)cellHeight
{
    return contentSize.height+10;
}

@end
