//
//  CailiaoViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/15.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface CailiaoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    NSArray *m_jsonArr;
    NSArray *n_jsonArr;
    NSArray *m_array;
    CGFloat inroduceHeight;
    CGFloat productHeight;
}
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSArray *m_jsonArr;
@property (nonatomic,retain) NSArray *n_jsonArr;
@end
