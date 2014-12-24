//
//  NewsTableView.h
//  TGQ2
//
//  Created by 许开伟 on 14-8-22.
//  Copyright (c) 2014年 元元. All rights reserved.
//
#define InformationheightBigForRow 300
#define InformationheightSmallForRow 140

@protocol NewsTableViewDelegate <NSObject>

-(void)NewsTableViewBtnPressed:(NSArray *)dic;

@end

#import <UIKit/UIKit.h>
#import "common.h"
#import "ActivityCell.h"
#import "BannerTableCell.h"
#import "DesignerListCell.h"
#import "CailiaoCell.h"
#import "LoupanCell.h"

@interface NewsTableView : UIView<UITableViewDataSource,UITableViewDelegate,EGORefreshTableFooterDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *m_tableView;
    NSMutableArray *m_newsArray;
    //UITableView *m_tableview;
    HessianFormDataRequest *myrequest;
    EGORefreshTableFooterView *_refreshFooterView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _Headerreloading;
    BOOL reloadormore;
    int page;
    NSString *mytime;
    NSArray *newList;
    MBProgressHUD *MBProgress;
    
}
@property(nonatomic, retain)UITableView *m_tableView;
@property(nonatomic, retain)NSMutableArray *m_newsArray;
@property(nonatomic, retain)NSMutableArray *m_recommdArray;
@property (nonatomic,assign) id<NewsTableViewDelegate> delegate;
@property (nonatomic,assign) int shaixuan;
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSDictionary *m_Dictionary;
-(void)ViewFrashData;
@end
