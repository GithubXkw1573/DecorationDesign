//
//  CommentCell.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/16.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface CommentCell : UITableViewCell
{
    UIImageView *headImageView;
    UILabel *nameLabel;
    UILabel *addrLabel;
    UILabel *timeLabel;
    myLabel *commentLabel;
    CGSize commentSize;
}
-(void)setCell:(NSArray*)array withRow:(NSInteger)row;
-(CGFloat)cellHeight;
@property (nonatomic,retain) UIImage *headImage;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *addr;
@property (nonatomic,retain) NSString *time;
@property (nonatomic,retain) NSString *comment;
@end
