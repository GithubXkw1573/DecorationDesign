//
//  WodeViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/22.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "PicTextButton.h"
#import "LoginViewController.h"
#import "GerenxinxiViewController.h"

@interface WodeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *m_tableView;
    UIButton *touPic;
    UILabel *nameLabel;
    UIImageView *mybackView;
    
}
@property (nonatomic,retain) UIImageView *mybackView;
@property (nonatomic,retain) UITableView *m_tableView;
@end
