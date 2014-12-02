//
//  ImageLooker.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "ImageLooker.h"

@implementation ImageLooker
@synthesize myImageView;

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)_image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.delegate=self;
        self.multipleTouchEnabled=YES;
        self.minimumZoomScale=1.0;
        self.maximumZoomScale=10.0;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mytap:)];
        [self addGestureRecognizer:tap];
        [tap release];
        
        CGFloat imageView_X = (_image.size.width > self.frame.size.width) ? self.frame.size.width : _image.size.width;
        CGFloat imageView_Y;
        CGFloat origin;
        if(_image.size.width > self.frame.size.width){
            origin = self.frame.size.width/_image.size.width;
            imageView_Y = _image.size.height*origin;
        }
        myImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-imageView_X)/2, (self.frame.size.height-imageView_Y)/2, imageView_X, imageView_Y)];
        if(self.myImageView==nil)
        {
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            self.myImageView=imageView;
            [imageView release];
        }
        
        //    [myImageView setImage:_image];
        
        UIImage *originImage=[[UIImage alloc]initWithCGImage:_image.CGImage];
        [myImageView setImage:originImage];
        //    [myImageView setFrame:CGRectMake(0, 0, _image.size.width, _image.size.height)];
        
        [self addSubview:self.myImageView];
        
        
    }
    return self;
}

//实现图片缩放
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    NSLog(@"**************viewForZoomingInScrollView");
    return self.myImageView;
}

//实现图片在缩放过程中居中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    self.myImageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}

-(void)mytap:(id)sender
{
    [UIView animateWithDuration:0.35f animations:^{
        self.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL flag){
        for(UIView *v in self.subviews)
            [v removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

@end
