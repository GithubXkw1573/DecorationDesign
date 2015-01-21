//
//  CompanyViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/15.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "DetailViewController.h"

@interface CompanyViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableFooterDelegate,EGORefreshTableHeaderDelegate>
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
    CGFloat inroduceHeight;
}
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UIImageView *designerPicView;
@property(nonatomic, retain)NSMutableArray *viewControllers;
@property(nonatomic, retain)UIScrollView *myscrollView;
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSArray *m_jsonArr;
@property (nonatomic,retain) NSMutableArray *n_jsonArr;

@end
