//
//  HomeViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/17.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "FaxianViewController.h"
#import "PicTextButton.h"
#import "DesignerViewController.h"
#import "ZuopingLookViewController.h"
#import "ImageLooker.h"
#import "LoginViewController.h"
#import "ShareView.h"
#import "CommentViewController.h"

@class DDAppDelegate;


@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *m_tableView;
    UIScrollView *imagescrollView;
    UIPageControl *pageControl;
    BOOL pageControlUsed;
    NSMutableArray *viewControllers;
    NSMutableArray *guanggaoArray;
    NSUInteger kNumberOfPages;
    UIScrollView *designerscrollView;
    NSMutableArray *designerArray;
    MBProgressHUD *homeMBProgress;
    ShareView *myshareView;
}
@property(nonatomic, retain)MBProgressHUD *homeMBProgress;
@property(nonatomic, retain)NSMutableArray *viewControllers;
@property(nonatomic, retain)UIScrollView *imagescrollView;
@property(nonatomic, retain)UIScrollView *designerscrollView;
@property(nonatomic, retain)UIPageControl *pageControl;
@property(nonatomic, retain)NSMutableArray *guanggaoArray;
@property(nonatomic, retain)NSMutableArray *designerArray;
@end
