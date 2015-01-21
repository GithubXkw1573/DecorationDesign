//
//  DetailViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/17.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "LabelCell.h"
#import "ImageCell.h"
#import "ShareView.h"
#import "CommentViewController.h"
#import "BookingViewController.h"
#import "LoginViewController.h"

@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    NSArray *m_array;
    NSArray *m_jsonArr;
    NSString *method;
    NSString *designer;
    NSString *designerId;
    NSString *worksId;
    
    UIView *shuomingView;
    UITextView *contentView;
    UIImageView *zhezhaoView;
    NSInteger startIndex;
}
@property (nonatomic,retain) NSString *method;
@property (nonatomic,retain) NSString *designer;
@property (nonatomic,retain) NSString *designerId;
@property (nonatomic,retain) NSString *worksId;
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSArray *m_jsonArr;
@end
