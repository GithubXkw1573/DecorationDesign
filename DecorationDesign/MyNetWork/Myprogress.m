//
//  Myprogress.m
//  Demo
//
//  Created by 元元 on 13-12-16.
//  Copyright (c) 2013年 元元. All rights reserved.
//

#import "Myprogress.h"
#import "common.h"

@implementation Myprogress
@synthesize textLabel;
@synthesize detailTextLabel;
@synthesize canclebtn;
@synthesize delegate;
@synthesize requestbtn;

-(void)dealloc
{
    [requestbtn release];
    delegate=nil;
    [detailTextLabel release];
    [textLabel release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"黑色半透明.png"]];
        
        UIView *progress=[[UIView alloc]initWithFrame:CGRectMake((320-280)/2, (boundsheight-160)/2, 280, 160)];
        progress.backgroundColor=[UIColor orangeColor];
        [self addSubview:progress];
        [progress release];
        
        textLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, progress.frame.size.width-20, 20)];
        textLabel.backgroundColor=[UIColor clearColor];
        textLabel.textColor=[UIColor whiteColor];
        textLabel.textAlignment=UITextAlignmentCenter;
        textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
        [progress addSubview:textLabel];
        
        detailTextLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, progress.frame.size.width-20, 40)];
        detailTextLabel.backgroundColor=[UIColor clearColor];
        detailTextLabel.textColor=[UIColor whiteColor];
        detailTextLabel.textAlignment=UITextAlignmentCenter;
        detailTextLabel.font=[UIFont systemFontOfSize:16];
        [progress addSubview:detailTextLabel];
        
        canclebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        canclebtn.frame=CGRectMake((progress.frame.size.width-100)/2, 85, 100, 60);
        [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
        [canclebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [canclebtn addTarget:self action:@selector(cancleBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [progress addSubview:canclebtn];
        
        requestbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        requestbtn.frame=CGRectMake((progress.frame.size.width-100)/2, 85, 100, 60);
        [requestbtn setTitle:@"重新连接" forState:UIControlStateNormal];
        [requestbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [requestbtn addTarget:self action:@selector(requestBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [progress addSubview:requestbtn];
        
        //UIAlertView动画
        CAKeyframeAnimation * animation;
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.5;
        animation.delegate = self;
        animation.removedOnCompletion = YES;
        animation.fillMode = kCAFillModeForwards;
        
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        
        animation.values = values;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];;
        [progress.layer addAnimation:animation forKey:nil];
    }
    return self;
}

-(void)settextLabel:(NSString *)titlestr detailTextLabel:(NSString *)detailstr
{
    textLabel.text=titlestr;
    detailTextLabel.text=detailstr;
}

-(void)cancleBtnPressed:(id)sender
{
    [delegate DelegatecancleBtnPressed];
    [self removeFromSuperview];
}

-(void)requestBtnPressed:(id)sender
{
    [delegate DelegaterequestBtnPressed];
}

-(void)setmode:(int)mod
{
    switch (mod) {
        case 1:
        {
            canclebtn.hidden=YES;
            requestbtn.hidden=YES;
            canclebtn.frame=CGRectMake((280-100)/2, 85, 100, 60);
        }
            break;
        case 2:
        {
            canclebtn.hidden=YES;
            requestbtn.hidden=NO;
            canclebtn.frame=CGRectMake((280)/2-10-100, 85, 100, 60);
            requestbtn.frame=CGRectMake((280-100)/2, 85, 100, 60);
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
