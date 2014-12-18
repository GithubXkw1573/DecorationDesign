//
//  ImageCell.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/17.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface ImageCell : UITableViewCell
{
    UIImageView *myImageView;
    CGFloat myImageHeight;
}

@property(retain,nonatomic)UIImageView *myImageView;
-(CGFloat)cellHeight;
-(void)setContentImage:(NSString *)imageStr;
@end
