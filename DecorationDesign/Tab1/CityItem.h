//
//  CityItem.h
//  TGQ2
//
//  Created by 许开伟 on 14-8-27.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface CityItem : UIButton
{
    UILabel *mycityLabel;
}
@property (nonatomic,retain) UILabel *mycityLabel;
@property (nonatomic,retain) NSString *city;
@property (nonatomic,retain) NSString *cityId;

- (id)initWithFrame:(CGRect)frame CityName:(NSString*)cityName CityId:(NSString*)cityId;
@end
