//
//  ImageCell.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/17.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell
@synthesize myImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImage *_image = [UIImage imageNamed:@"Sjs_banner"];
        CGFloat imageView_X = (_image.size.width > self.frame.size.width-20) ? self.frame.size.width-20 : _image.size.width;
        CGFloat imageView_Y;
        CGFloat origin;
        if(_image.size.width > self.frame.size.width-20){
            origin = (self.frame.size.width-20)/_image.size.width;
            imageView_Y = _image.size.height*origin;
        }else{
            imageView_Y = _image.size.height;
        }
        myImageHeight = imageView_Y;
        myImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-imageView_X)/2, 0, imageView_X, imageView_Y)];
        if(self.myImageView==nil)
        {
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height)];
            self.myImageView=imageView;
            [imageView release];
        }
        
        UIImage *originImage=[[[UIImage alloc]initWithCGImage:_image.CGImage] autorelease];
        [myImageView setImage:originImage];
        
        [self addSubview:self.myImageView];
    }
    return self;
}

-(void)setContentImage:(NSString *)imageStr
{
    NSURL *url = [NSURL URLWithString:imageStr];
    
    [myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Sjs_banner"]];
}

-(CGFloat)cellHeight
{
    return myImageHeight+10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
