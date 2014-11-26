//
//  TypeButton.m
//  TGQ2
//
//  Created by 许开伟 on 14-8-21.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "TypeButton.h"

@implementation TypeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 64, 33)];
        titleLabel.text = @"全部";
        self.typeId = @"-1";
        titleLabel.tag = 10;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = font(16);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:titleLabel];
        [titleLabel release];
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, 64, 2)];
        arrowImage.tag = 11;
        arrowImage.hidden = YES;
        arrowImage.image = [UIImage imageNamed:@"标题栏6"];
        arrowImage.backgroundColor = [UIColor clearColor];
        [self addSubview:arrowImage];
        [arrowImage release];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Title:(NSString*)cityName TypeId:(NSString*)typeId
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 64, 33)];
        titleLabel.text = cityName;
        self.typeId = typeId;
        titleLabel.tag = 10;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = font(16);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:titleLabel];
        [titleLabel release];
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, 64, 2)];
        arrowImage.tag = 11;
        arrowImage.hidden = YES;
        arrowImage.image = [UIImage imageNamed:@"标题栏6"];
        arrowImage.backgroundColor = [UIColor clearColor];
        [self addSubview:arrowImage];
        [arrowImage release];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    UILabel *typeLabel = (UILabel*)[self viewWithTag:10];
    typeLabel.text = title;
}

-(void)setSelected:(BOOL)selected
{
    UIImageView *imge = (UIImageView*)[self viewWithTag:11];
    UILabel *typeLabel = (UILabel*)[self viewWithTag:10];
    if (selected) {
        imge.hidden = NO;
        typeLabel.textColor = [UIColor myorangecolor];
        typeLabel.font = bold_font(20);
    }else{
        imge.hidden = YES;
        typeLabel.textColor = [UIColor blackColor];
        typeLabel.font = font(16);
    }
}

@end
