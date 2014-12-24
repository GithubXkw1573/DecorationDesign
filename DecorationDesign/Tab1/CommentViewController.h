//
//  CommentViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/16.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "CommentCell.h"
#import "ShareView.h"

@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    NSArray *m_array;
    NSString *worksId;
    NSString *worksType;
    NSString *designerId;
    NSString *designerName;
    NSArray *m_jsonArr;
    NSArray *n_jsonArr;
    NSString *commentNums;
    UITextField *commentField;
    BOOL isCommented;
    UILabel *support1;
    UILabel *support2;
    UILabel *support3;
}
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSArray *m_jsonArr;
@property (nonatomic,retain) NSArray *n_jsonArr;
@property (nonatomic,retain) NSString *worksId;
@property (nonatomic,retain) NSString *worksType;
@property (nonatomic,retain) NSString *designerId;
@property (nonatomic,retain) NSString *designerName;
@end
