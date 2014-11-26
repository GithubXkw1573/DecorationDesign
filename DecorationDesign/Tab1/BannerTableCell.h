//
//  BannerTableCell.h
//  TGQ2
//
//  Created by 许开伟 on 14-8-25.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface BannerTableCell : UITableViewCell
@property (nonatomic,retain) NSDictionary  *m_dictionary;
- (void)setCell:(NSDictionary *)dic row:(int)row;
@end
