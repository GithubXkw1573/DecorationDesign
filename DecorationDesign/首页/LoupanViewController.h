//
//  LoupanViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/15.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface LoupanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableFooterDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    NSArray *m_jsonArr;
    NSMutableArray *n_jsonArr;
    NSArray *m_array;
    CGFloat inroduceHeight;
    CGFloat productHeight;
    
    EGORefreshTableFooterView *_refreshFooterView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _Headerreloading;
    BOOL reloadormore;
    int page;
    NSString *mytime;
    NSArray *newList;
}
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSArray *m_jsonArr;
@property (nonatomic,retain) NSMutableArray *n_jsonArr;
@end
