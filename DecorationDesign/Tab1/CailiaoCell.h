//
//  CailiaoCell.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface CailiaoCell : UITableViewCell
{
    UIImageView *designerPicView;
    UILabel *worksLabel;
    UILabel *boutiqueLabel;
    UILabel *bookingLabel;
    UILabel *signedLabel;
    UILabel *titleLabel;
}
@property (nonatomic,retain) UIImageView *designerPicView;
@property (nonatomic,retain) UILabel *worksLabel;
@property (nonatomic,retain) UILabel *boutiqueLabel;
@property (nonatomic,retain) UILabel *bookingLabel;
@property (nonatomic,retain) UILabel *signedLabel;
@property (nonatomic,retain) UILabel *titleLabel;
-(void)setCellData:(NSArray*)item;
@end
