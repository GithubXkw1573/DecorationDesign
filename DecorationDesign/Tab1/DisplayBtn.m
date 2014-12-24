//
//  DisplayBtn.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "DisplayBtn.h"

@implementation DisplayBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 148, 148)];
        pic.backgroundColor = [UIColor clearColor];
        displayImageView = pic;
        [self addSubview:pic];
        [pic release];
        
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 148, 142, 25)];
        lbl1.backgroundColor = [UIColor clearColor];
        lbl1.font = font(16);
        titleLabel = lbl1;
        [self addSubview:lbl1];
        [lbl1 release];
        
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(3, 148+25, 80, 30)];
        lbl2.backgroundColor = [UIColor clearColor];
        lbl2.font = font(18);
        lbl2.textColor = [UIColor redColor];
        nowPriceLabel = lbl2;
        [self addSubview:lbl2];
        [lbl2 release];
        
        UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(83, 148+25, 62, 30)];
        lbl3.backgroundColor = [UIColor clearColor];
        lbl3.font = font(16);
        lbl3.textColor = [UIColor grayColor];
        originPriceLabel = lbl3;
        [self addSubview:lbl3];
        [lbl3 release];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(83, 188, 62, 1)];
        line.image = [UIImage imageNamed:@"线"];
        [self addSubview:line];
        [line release];
    }
    return self;
}

-(void)setButtonData:(NSArray*)item withRow:(NSInteger)row
{
    [displayImageView setImageWithURL:[NSURL URLWithString:[item objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"CAIxiang_img2"]];
    titleLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:1]];
    nowPriceLabel.text = [NSString stringWithFormat:@"￥%@",[item objectAtIndex:2]];
    originPriceLabel.text = [NSString stringWithFormat:@"￥%@",[item objectAtIndex:3]];
}

@end
