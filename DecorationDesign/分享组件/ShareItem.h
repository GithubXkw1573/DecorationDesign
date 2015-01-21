//
//  ShareItem.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/11.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareItem : UIButton
{
    UIImageView *imageView;
    UILabel *textLabel;
}
-(id)initWithFrame:(CGRect)frame withIamge:(NSString*)imageName withText:(NSString*)text;

@end
