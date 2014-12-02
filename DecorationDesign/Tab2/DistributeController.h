//
//  DistributeController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "HessianKit.h"

@interface DistributeController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *m_tableView;
    UITextField *nameField;
    UITextField *telField;
    UITextField *bugetField;
    UITextField *areaField;
    UITextField *typeField;
}
@property (nonatomic,retain) UILabel *onlineNum;
@property (nonatomic,retain) UITextField *nameField;
@property (nonatomic,retain) UITextField *telField;
@property (nonatomic,retain) UITextField *bugetField;
@property (nonatomic,retain) UITextField *areaField;
@property (nonatomic,retain) UITextField *typeField;  
@end
