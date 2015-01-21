//
//  LoupanZhuantiController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/29.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface LoupanZhuantiController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    NSArray *m_jsonArr;
    NSMutableArray *n_jsonArr;
    NSArray *m_array;
    CGFloat inroduceHeight;
    CGFloat productHeight;
    
    NSInteger fangangCount;
    NSArray *newList;
    NSString *buildingId;
    NSString *companyName;
    NSString *companyId;
}
@property (nonatomic,retain) NSString *buildingId;
@property (nonatomic,retain) NSString *companyName;
@property (nonatomic,retain) NSString *companyId;
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSArray *m_jsonArr;
@property (nonatomic,retain) NSMutableArray *n_jsonArr;

@end
