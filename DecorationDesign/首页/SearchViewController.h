//
//  SearchViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 15/1/19.
//  Copyright (c) 2015年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "DesignerListCell.h"
#import "LoupanCell.h"
#import "CailiaoCell.h"
#import "DesignerViewController.h"
#import "LoupanViewController.h"
#import "CompanyViewController.h"
#import "CailiaoViewController.h"

@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableFooterDelegate,EGORefreshTableHeaderDelegate,UITextFieldDelegate>
{
    UITextField *searchField;
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    HessianFormDataRequest *queryListRequest;
    
    EGORefreshTableFooterView *_refreshFooterView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _Headerreloading;
    BOOL reloadormore;
    int page;
    NSString *mytime;
    NSArray *newList;
    NSMutableArray *selectRecordList;
    
}
@property (nonatomic,assign) NSInteger searchType;
@property (nonatomic,copy) NSMutableArray *searchList;
@property (nonatomic,retain) NSArray *typeList;

@end
