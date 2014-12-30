//
//  CoverViewController.m
//  iPaiViewController
//
//  Created by Royce Allan on 11-5-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CoverViewController.h"
#import "DDAppDelegate.h"

@implementation CoverViewController
@synthesize timer;

- (void)dealloc
{
    [timer release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    if (boundsheight>480) {
        UIImageView *backimage=[[UIImageView alloc]init];
        if (iOS7Later) {
            backimage.frame=CGRectMake(0, 0, applicationwidth, boundsheight);
        }
        else
        {
            backimage.frame=CGRectMake(0, -20, applicationwidth, boundsheight);
        }
        backimage.image=[UIImage imageNamed:@"Default-568h@2x.png"];
        [self.view addSubview:backimage];
        [backimage release];
    }
    else{
        UIImageView *backimage=[[UIImageView alloc]init];
        if (iOS7Later) {
            backimage.frame=CGRectMake(0, 0, applicationwidth, boundsheight);
        }
        else
        {
            backimage.frame=CGRectMake(0, -20, applicationwidth, boundsheight);
        }
        backimage.image=[UIImage imageNamed:@"Default@2x.png"];
        [self.view addSubview:backimage];
        [backimage release];
    }
    
    netOK=NO;
    totleTime=1;
    
    [self performSelector:@selector(beginTimer) withObject:nil afterDelay:0.1];
}

-(void)beginTimer
{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(handleMaxShowTimer:) userInfo:nil repeats:YES];
}

- (void)handleMaxShowTimer:(NSTimer *)theTimer
{
    if (totleTime>=2||netOK==YES) {
        
        [timer invalidate];
        self.timer=nil;
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"firstused%@",MineVersion]]) {
            IntroduceView *Introduce=[[IntroduceView alloc]init];
            if (iOS7Later) {
                Introduce.frame=CGRectMake(0, 20, applicationwidth, applicationheight);
            }
            else
            {
                Introduce.frame=CGRectMake(0, 0, applicationwidth, applicationheight);
            }
            [self.view addSubview:Introduce];
            [Introduce release];
        }
        else
        {
            self.view.alpha=1.0;
            UIVIEW_ANIMATION_BEGIN3(@"detail_ani", 1.0, @selector(animationDidStop:));
            self.view.alpha=0.0;
            UIVIEW_ANIMATION_END;
            
            DDAppDelegate *delegate = (DDAppDelegate*)[[UIApplication sharedApplication] delegate];
            [delegate.window setRootViewController:delegate.TabBarController];
            [delegate.window insertSubview:self.view atIndex:77];
        }
    }
    totleTime++;
}

-(void)animationDidStop:(id)sender
{
    [self.view removeFromSuperview];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
