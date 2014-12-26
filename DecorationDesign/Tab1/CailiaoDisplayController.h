//
//  CailiaoDisplayController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "DisplayBtn.h"
#import "CailiaoDetailController.h"

@interface CailiaoDisplayController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableFooterDelegate,EGORefreshTableHeaderDelegate>
{
    MBProgressHUD *MBProgress;
    UITableView *m_tableView;
    EGORefreshTableFooterView *_refreshFooterView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _Headerreloading;
    BOOL reloadormore;
    int page;
    NSString *mytime;
    NSArray *newList;
    NSString *mybannerUrl;
    NSArray *m_array;
    NSArray *m_jsonArr;
    NSMutableArray *n_jsonArr;
}
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSArray *m_jsonArr;
@property (nonatomic,retain) NSMutableArray *n_jsonArr;
@end
