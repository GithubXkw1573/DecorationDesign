//
//  CailiaoDetailController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/25.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "ImageCell.h"
#import "LabelCell.h"

@interface CailiaoDetailController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    NSArray *m_array;
    NSArray *m_jsonArr;
}
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSArray *m_jsonArr;
@end
