//
//  GerenxinxiViewController.h
//  TGQ
//
//  Created by 元元 on 14-4-20.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "XiugainichenViewController.h"
#import "UserSettingDetailController.h"
#import "BangdingshoujiViewController.h"

@interface GerenxinxiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,XiugainichenViewDelegate>{
    UITableView *m_tableView;
    NSMutableDictionary *MutableDictionary;
    UIImagePickerController *pickerController;
    MBProgressHUD *MBProgress;
    ASIFormDataRequest *upimagehttprequest;
    ASIFormDataRequest *gerenxinxihttprequest;
}
@property(nonatomic,retain)ASIFormDataRequest *gerenxinxihttprequest;
@property(nonatomic,retain)MBProgressHUD *MBProgress;
@property(nonatomic,retain)ASIFormDataRequest *upimagehttprequest;
@property(nonatomic,retain)NSMutableDictionary *MutableDictionary;
@property(nonatomic,retain)UITableView *m_tableView;
-(void)GerenxinxiViewControllerBtnPressed:(id)sender;
-(void)upimagerequest:(NSData *)data;
-(void)upimagerequestFinished:(ASIHTTPRequest *)request;
-(void)upimagerequestFailed:(ASIHTTPRequest *)request;
-(void)gerenxinxirequest;
-(void)gerenxinxirequestFinished:(ASIHTTPRequest *)request;
-(void)gerenxinxirequestFailed:(ASIHTTPRequest *)request;
-(void)XiugainichenViewDelegateBtnPressed:(NSString *)nickName;
@end
