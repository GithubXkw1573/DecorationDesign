//
//  myLabel.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/16.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop_m = 0, // default
    VerticalAlignmentMiddle_m,
    VerticalAlignmentBottom_m,
} VerticalAlignment_m;

@interface myLabel : UILabel
{
    @private
    VerticalAlignment_m _verticalAlignment;
}

@property (nonatomic) VerticalAlignment_m verticalAlignment;
@end
