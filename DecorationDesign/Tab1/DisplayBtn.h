//
//  DisplayBtn.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface DisplayBtn : UIButton
{
    UIImageView *displayImageView;
    UILabel *titleLabel;
    UILabel *originPriceLabel;
    UILabel *nowPriceLabel;
}
-(void)setButtonData:(NSArray*)item withRow:(NSInteger)row;
@end
