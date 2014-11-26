//
//  TabbarView.m
//  TGQ2
//
//  Created by 元元 on 14-7-16.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "TabbarView.h"

@implementation TabbarView
@synthesize tabimage;
@synthesize tablab;
@synthesize delegate;

-(void)dealloc
{
    delegate=nil;
    [tabimage release];
    [tablab release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        tabimage=[[UIImageView alloc] init];
        tabimage.frame=CGRectMake( 29*widthRate, 6, 22, 22);
        tabimage.contentMode=UIViewContentModeScaleToFill;
        [self addSubview:tabimage];
        
        tablab=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 80*widthRate, 17)];
        tablab.backgroundColor=[UIColor clearColor];
        tablab.textAlignment=UITextAlignmentCenter;
        tablab.font=[UIFont systemFontOfSize:11];
        tablab.textColor=[UIColor grayColor];
        [self addSubview:tablab];
        
        UIButton *tabbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        tabbtn.frame=CGRectMake(0, 0, 64*widthRate, 49);
        [tabbtn addTarget:self action:@selector(TabbarViewBtnPressed:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:tabbtn];
    }
    return self;
}

-(void)TabbarViewBtnPressed:(id)sender
{
    [delegate TabbarViewDelegateBtnPressed:self.tag];
}

-(void)setselect:(BOOL)bol
{
    switch (self.tag) {
        case 1:
        {
            tabimage.image=[UIImage imageNamed:bol? @"D_icon1.png":@"D_icon01.png"];
            tablab.text=@"首页";
            tablab.textColor=bol? [UIColor redColor]:[UIColor grayColor];
        }
            break;
        case 2:
        {
            tabimage.image=[UIImage imageNamed:bol? @"D_icon2.png":@"D_icon02.png"];
            tablab.text=@"发布";
            tablab.textColor=bol? [UIColor redColor]:[UIColor grayColor];
        }
            break;
        case 3:
        {
            tabimage.image=[UIImage imageNamed:bol? @"D_icon3.png":@"D_icon03.png"];
            tablab.text=@"预约";
            tablab.textColor=bol? [UIColor redColor]:[UIColor grayColor];
        }
            break;
        case 4:
        {
            tabimage.image=[UIImage imageNamed:bol? @"D_icon4.png":@"D_icon04.png"];
            tablab.text=@"我的";
            tablab.textColor=bol? [UIColor redColor]:[UIColor grayColor];
        }
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
