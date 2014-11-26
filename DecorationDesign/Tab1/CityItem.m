//
//  CityItem.m
//  TGQ2
//
//  Created by 许开伟 on 14-8-27.
//  Copyright (c) 2014年 元元. All rights reserved.
//
#define blackcolor [UIColor colorWithRed:225/255.0f green:225/255.0f blue:227/255.0f alpha:1]

#import "CityItem.h"

@implementation CityItem
@synthesize mycityLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor myorangecolor];
        UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
        cityLabel.text = @"城市";
        self.mycityLabel = cityLabel;
        self.cityId = @"-1";
        cityLabel.textColor = [UIColor whiteColor];
        cityLabel.font = font(14);
        cityLabel.textAlignment = NSTextAlignmentCenter;
        cityLabel.backgroundColor = [UIColor clearColor];
        cityLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:cityLabel];
        [cityLabel release];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame CityName:(NSString*)cityName CityId:(NSString*)cityId
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor myorangecolor];
        UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
        cityLabel.text = cityName;
        self.mycityLabel = cityLabel;
        self.cityId = cityId;
        cityLabel.textColor = [UIColor whiteColor];
        cityLabel.font = font(14);
        cityLabel.textAlignment = NSTextAlignmentCenter;
        cityLabel.backgroundColor = [UIColor clearColor];
        cityLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:cityLabel];
        [cityLabel release];
    }
    return self;
}

-(void)setCity:(NSString *)city
{
    self.mycityLabel.text = city;
    //self.city = city;
}

@end
