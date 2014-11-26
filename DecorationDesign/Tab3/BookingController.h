//
//  BookingController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface BookingController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *m_tableView;
    UITextField *nameField;
    UITextField *telField;
    UITextField *qqField;
    UITextField *areaField;
    UITextField *typeField;
    UITextField *cityField;
    UITextField *othersField;
}
@property (nonatomic,retain) UITextField *nameField;
@property (nonatomic,retain) UITextField *telField;
@property (nonatomic,retain) UITextField *areaField;
@property (nonatomic,retain) UITextField *typeField;
@property (nonatomic,retain) UITextField *qqField;
@property (nonatomic,retain) UITextField *cityField;
@property (nonatomic,retain) UITextField *othersField;
@end
