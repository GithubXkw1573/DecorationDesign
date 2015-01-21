//
//  ArticleView.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "ArticleTableViewCell.h"
#import "ZiliaoDetaillViewController.h"

@interface ArticleView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    UINavigationController *currController;
}
@property (nonatomic,retain) UINavigationController *currController;
@end
