//
//  ArticleTableViewCell.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell
{
    UILabel *titleLabel;
    UILabel *dateLabel;
    UILabel *contentLabel;
}
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *dateLabel;
@property (nonatomic,retain) UILabel *contentLabel;

@end
