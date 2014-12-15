//
//  ShareItem.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/11.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "ShareItem.h"

@implementation ShareItem

-(id)initWithFrame:(CGRect)frame withIamge:(NSString*)imageName withText:(NSString*)text
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(17*widthRate, 10*widthRate, 56*widthRate, 56*widthRate)];
        imgv.image = [UIImage imageNamed:imageName];
        imgv.backgroundColor = [UIColor clearColor];
        imageView = imgv;
        [self addSubview:imgv];
        [imgv release];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 66*widthRate, 90*widthRate, 24*widthRate)];
        lbl.text = text;
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textAlignment = UITextAlignmentCenter;
        lbl.font = font(15);
        textLabel = lbl;
        [self addSubview:lbl];
        [lbl release];
    }
    return self;
}



@end
