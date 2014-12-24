//
//  LoupanCell.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface LoupanCell : UITableViewCell
{
    UIImageView *designerPicView;
    UILabel *typeLabel;
    UILabel *addrLabel;
    UILabel *commentLabel;
    UILabel *titleLabel;
}
@property (nonatomic,retain) UIImageView *designerPicView;
@property (nonatomic,retain) UILabel *typeLabel;
@property (nonatomic,retain) UILabel *addrLabel;
@property (nonatomic,retain) UILabel *commentLabel;
@property (nonatomic,retain) UILabel *titleLabel;
-(void)setCellData:(NSArray*)item;
@end
