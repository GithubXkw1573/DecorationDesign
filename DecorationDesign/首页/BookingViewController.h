//
//  BookingViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/18.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "LoginViewController.h"
#import "MyPickerView.h"

@interface BookingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *m_tableView;
    UITextField *nameField;
    UITextField *telField;
    UITextField *qqField;
    UITextField *areaField;
    UITextField *typeField;
    UITextField *cityField;
    UITextField *othersField;
    MyPickerView *pickerView;
}
@property (nonatomic,retain) NSString *designerName;
@property (nonatomic,retain) NSString *designerId;

@property (nonatomic,retain) UITextField *nameField;
@property (nonatomic,retain) UITextField *telField;
@property (nonatomic,retain) UITextField *areaField;
@property (nonatomic,retain) UITextField *typeField;
@property (nonatomic,retain) UITextField *qqField;
@property (nonatomic,retain) UITextField *cityField;
@property (nonatomic,retain) UITextField *othersField;

@end
