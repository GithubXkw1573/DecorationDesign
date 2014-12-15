//
//  DDAppDelegate.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/17.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "DDAppDelegate.h"

@implementation DDAppDelegate
@synthesize homeCtrl,distributeCtrl,bookingCtrl,wodeCtrl;
@synthesize homeNavi,tab2Navi,tab3Navi,tab4Navi;
@synthesize TabBarController;

- (void)dealloc
{
    [homeNavi release];
    [tab2Navi release];
    [tab3Navi release];
    [tab4Navi release];
    [barView1 release];
    [barView2 release];
    [barView3 release];
    [barView4 release];
    [homeCtrl release];
    [distributeCtrl release];
    [bookingCtrl release];
    [TabBarController release];
    [_window release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];  //状态栏字体改为白色
    
    TabBarController=[[UITabBarController alloc]init];
    TabBarController.delegate=self;
    
    self.homeCtrl = [[[HomeViewController alloc] init] autorelease];
    self.distributeCtrl = [[[DistributeController alloc] init] autorelease];
    self.bookingCtrl = [[[BookingController alloc] init] autorelease];
    self.wodeCtrl = [[[WodeViewController alloc] init] autorelease];
    UINavigationController *navi1=[[UINavigationController alloc]initWithRootViewController:self.homeCtrl];
    UINavigationController *navi2=[[UINavigationController alloc]initWithRootViewController:self.distributeCtrl];
    UINavigationController *navi3=[[UINavigationController alloc]initWithRootViewController:self.bookingCtrl];
    UINavigationController *navi4=[[UINavigationController alloc]initWithRootViewController:self.wodeCtrl];
    self.homeNavi = navi1;
    self.tab2Navi = navi2;
    self.tab3Navi = navi3;
    self.tab4Navi = navi4;
    NSArray *Controllers=[[NSArray alloc]initWithObjects:navi1,navi2,navi3,navi4, nil];
    TabBarController.viewControllers=Controllers;
    [navi1 release];
    [navi2 release];
    [navi3 release];
    [navi4 release];
    [Controllers release];
    
    UIImageView *backimage=[[UIImageView alloc] init];
    backimage.backgroundColor=[UIColor whiteColor];
    backimage.frame=CGRectMake( 0, 0, applicationwidth, 49);
    [[[self TabBarController] tabBar] insertSubview:backimage atIndex:7];
    [backimage release];
    
    barView1=[[TabbarView alloc] initWithFrame:CGRectMake(0, 0, 80*widthRate, 49)];
    barView1.tag=1;
    barView1.delegate=self;
    [barView1 setselect:YES];
    [[[self TabBarController] tabBar] insertSubview:barView1 atIndex:9];
    
    barView2=[[TabbarView alloc] initWithFrame:CGRectMake(80*widthRate, 0, 80*widthRate, 49)];
    barView2.tag=2;
    barView2.delegate=self;
    [barView2 setselect:NO];
    [[[self TabBarController] tabBar] insertSubview:barView2 atIndex:9];
    
    barView3=[[TabbarView alloc] initWithFrame:CGRectMake(160*widthRate, 0, 80*widthRate, 49)];
    barView3.tag=3;
    barView3.delegate=self;
    [barView3 setselect:NO];
    [[[self TabBarController] tabBar] insertSubview:barView3 atIndex:9];
    
    barView4=[[TabbarView alloc] initWithFrame:CGRectMake(240*widthRate, 0, 80*widthRate, 49)];
    barView4.tag=4;
    barView4.delegate=self;
    [barView4 setselect:NO];
    [[[self TabBarController] tabBar] insertSubview:barView4 atIndex:9];
    
    //引导动画
    CoverViewController *covercon=[[CoverViewController alloc]init];
    [self.window addSubview:covercon.view];
    [covercon release];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)TabbarViewDelegateBtnPressed:(int)tag
{
    [self.TabBarController setSelectedIndex:(tag-1)];
    
    [barView1 setselect:NO];
    [barView2 setselect:NO];
    [barView3 setselect:NO];
    [barView4 setselect:NO];
    
    switch (tag) {
        case 1:
        {
            [barView1 setselect:YES];
        }
            break;
        case 2:
        {
            [barView2 setselect:YES];
        }
            break;
        case 3:
        {
            [barView3 setselect:YES];
        }
            break;
        case 4:
        {
            [barView4 setselect:YES];
        }
            break;
        default:
            break;
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"sourceApplication:%@",sourceApplication);
    if ([sourceApplication isEqualToString:@"com.yixin.yixin"])
    {
        return  [[YXShareApi shared] handleOpen:url];
    }
    else if([sourceApplication isEqualToString:@"com.tencent.xin"])
    {
        return [[WXShareApi shared] handleOpen:url];
    }
    else if([sourceApplication isEqualToString:@"com.sina.weibo"])
    {
        return [[XLWeiboApi shared] handleOpen:url];
    }
    else if([sourceApplication isEqualToString:@"com.tencent.mqq"])
    {
        return [[QQkongjianApi shared] handleOpen:url];
    }
    else if([sourceApplication isEqualToString:@"com.tencent.WeiBo"])
    {
        return [[TCWeiboApi shared].wbapi handleOpenURL:url];
    }
    return YES;
}

@end
