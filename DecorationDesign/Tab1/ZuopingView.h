//
//  ZuopingView.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "ZuopingLookViewController.h"

@interface ZuopingView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    NSMutableArray *zuopingList;
    UINavigationController *currController;
}
@property (nonatomic,retain) NSMutableArray *zuopingList;
@property (nonatomic,retain) UINavigationController *currController;
@end
