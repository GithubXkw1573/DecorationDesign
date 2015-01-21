//
//  ImageLooker.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageLooker : UIScrollView<UIScrollViewDelegate>
{
    UIImageView *myImageView;
}
@property(retain,nonatomic)UIImageView *myImageView;
- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)_image;
@end
