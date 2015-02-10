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

-(void)NewsTableViewBtnPressed:(NSArray *)dic isAdver:(BOOL)adver;

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
    HessianFormDataRequest *myrequest;
    EGORefreshTableFooterView *_refreshFooterView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _Headerreloading;
    BOOL reloadormore;
    int page;
    NSString *mytime;
    NSArray *newList;
    NSArray *newAdverList;
    MBProgressHUD *MBProgress;
    NSMutableArray *selectRecordList;
    NSInteger nonAdverCount;
}
@property(nonatomic, retain)UITableView *m_tableView;
@property(nonatomic, retain)NSMutableArray *m_newsArray;
@property(nonatomic, retain)NSMutableArray *m_recommdArray;
@property (nonatomic,assign) id<NewsTableViewDelegate> delegate;
@property (nonatomic,assign) int shaixuan;
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSDictionary *m_Dictionary;
@property(nonatomic, retain)UIViewController *currController;
@property (nonatomic,retain) NSMutableArray *adverArray;
@property (nonatomic,retain) NSArray *newAdverList;
-(void)ViewFrashData;
@end
