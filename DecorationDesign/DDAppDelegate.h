//
//  DDAppDelegate.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/17.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "TabbarView.h"
#import "CoverViewController.h"
#import "WodeViewController.h"
#import "DistributeController.h"
#import "BookingController.h"

@interface DDAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,TabbarViewDelegate>
{
    UITabBarController *TabBarController;
    HomeViewController *homeCtrl;
    DistributeController *distributeCtrl;
    BookingController *bookingCtrl;
    WodeViewController *wodeCtrl;
    UINavigationController *homeNavi;
    UINavigationController *tab2Navi;
    UINavigationController *tab3Navi;
    UINavigationController *tab4Navi;
    TabbarView *barView1;
    TabbarView *barView2;
    TabbarView *barView3;
    TabbarView *barView4;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)UITabBarController *TabBarController;
@property (nonatomic,retain) HomeViewController *homeCtrl;
@property (nonatomic,retain) DistributeController *distributeCtrl;
@property (nonatomic,retain) BookingController *bookingCtrl;
@property (nonatomic,retain) WodeViewController *wodeCtrl;
@property (nonatomic,retain) UINavigationController *homeNavi;
@property (nonatomic,retain) UINavigationController *tab2Navi;
@property (nonatomic,retain) UINavigationController *tab3Navi;
@property (nonatomic,retain) UINavigationController *tab4Navi;

@end
