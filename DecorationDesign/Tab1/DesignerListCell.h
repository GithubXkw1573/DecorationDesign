//
//  DesignerListCell.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/21.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DesignerListCell : UITableViewCell
{
    UIImageView *designerPicView;
    UILabel *worksLabel;
    UILabel *boutiqueLabel;
    UILabel *bookingLabel;
    UILabel *signedLabel;
}
@property (nonatomic,retain) UIImageView *designerPicView;
@property (nonatomic,retain) UILabel *worksLabel;
@property (nonatomic,retain) UILabel *boutiqueLabel;
@property (nonatomic,retain) UILabel *bookingLabel;
@property (nonatomic,retain) UILabel *signedLabel;
@end
