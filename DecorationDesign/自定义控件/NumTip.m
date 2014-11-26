//
//  NumTip.m
//  TGQ2
//
//  Created by 许开伟 on 14-9-10.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "NumTip.h"

@implementation NumTip

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *roundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        roundView.layer.masksToBounds = YES;
        roundView.layer.cornerRadius = 10.0f;
        roundView.backgroundColor = [UIColor myorangecolor];
        roundView.layer.borderWidth = 2.0f;
        roundView.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.myRoundView = roundView;
        [self addSubview:roundView];
        [roundView release];
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, self.frame.size.width-6, self.frame.size.height)];
        desc.textAlignment = NSTextAlignmentCenter;
        desc.textColor = [UIColor whiteColor];
        desc.font = bold_font(14);
        self.myNumLabel = desc;
        [roundView addSubview:desc];
        [desc release];
    }
    return self;
}

-(void)setNumber:(NSInteger)number
{
    self.myNumLabel.text = [NSString stringWithFormat:@"%d",number];
    CGSize size = [self.myNumLabel.text sizeWithFont:bold_font(14) constrainedToSize:CGSizeMake(50, 20) lineBreakMode:NSLineBreakByWordWrapping];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width+12, 20);
    self.myRoundView.frame =CGRectMake(0, 0, size.width+12, 20);
    self.myNumLabel.frame= CGRectMake(3, 0, size.width+6, 20);
}

@end
