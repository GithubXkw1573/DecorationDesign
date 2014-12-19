//
//  DesignerViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/19.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "PersonIntroduceView.h"
#import "ZuopingView.h"
#import "ArticleView.h"
#import "DetailViewController.h"
#import "BookingViewController.h"
#import "LoginViewController.h"

@interface DesignerViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableFooterDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *m_tableView;
    NSMutableArray *viewControllers;
    UIScrollView *myscrollView;
    EGORefreshTableFooterView *_refreshFooterView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _Headerreloading;
    BOOL reloadormore;
    int page;
    NSString *mytime;
    NSArray *newList;
    
    UIView *shadow;
    NSArray *m_array;
    MBProgressHUD *MBProgress;
    UILabel *worksLabel;
    UILabel *good_workLabel;
    UILabel *shanchangLabel;
    UILabel *professiorLabel;
    UILabel *cityLabel;
    UILabel *typeLabel;
    NSArray *m_jsonArr;
    NSMutableArray *n_jsonArr;
}
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UIImageView *designerPicView;
@property(nonatomic, retain)NSMutableArray *viewControllers;
@property(nonatomic, retain)UIScrollView *myscrollView;
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSArray *m_jsonArr;
@property (nonatomic,retain) NSMutableArray *n_jsonArr;
@end
