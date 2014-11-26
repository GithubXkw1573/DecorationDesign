//
//  Tab4ViewController.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/17.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "Tab4ViewController.h"

@interface Tab4ViewController ()

@end

@implementation Tab4ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNaviWithTitle:@"我的"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)initNaviWithTitle:(NSString*)title
{
    if (iOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"标题栏%i.png",[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?7:6]] forBarMetrics:UIBarMetricsDefault];
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80*applicationwidth, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=title;
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
}

@end
