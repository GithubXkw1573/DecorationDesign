//
//  PicTextButton.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/18.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "PicTextButton.h"

@implementation PicTextButton

-(id)initWithFrame:(CGRect)frame withIamge:(NSString*)imageName withText:(NSString*)text
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(10*widthRate, 5*widthRate, 50*widthRate, 50*widthRate)];
        imgv.image = [UIImage imageNamed:imageName];
        imgv.backgroundColor = [UIColor clearColor];
        imageView = imgv;
        [self addSubview:imgv];
        [imgv release];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 55*widthRate, 70*widthRate, 20*widthRate)];
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
