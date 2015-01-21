//
//  LockCellPhoneViewCtrl.h
//  TGQ2
//
//  Created by 许开伟 on 14-11-7.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface BangdingshoujiViewController : UIViewController<UITextFieldDelegate>{
    UITextField *zhanghaotext;
    UITextField *yanzhengtext;
    UIButton *yanzhengbtn;
    MBProgressHUD *MBProgress;
    ASIFormDataRequest *notehttprequest;
    ASIFormDataRequest *bangdinghttprequest;
    NSTimer *timer;
    int time;
}
@property(nonatomic,retain)NSTimer *timer;
@property(nonatomic,retain)MBProgressHUD *MBProgress;
@property(nonatomic,retain)UITextField *zhanghaotext;
@property(nonatomic,retain)UITextField *yanzhengtext;
@property(nonatomic,retain)UIButton *yanzhengbtn;
@property(nonatomic,retain)ASIFormDataRequest *notehttprequest;
@property(nonatomic,retain)ASIFormDataRequest *bangdinghttprequest;
-(void)BangdingshoujiViewControllerBtnPressed:(id)sender;
-(void)timegogo;
-(void)noterequest;
-(void)noterequestFinished:(ASIHTTPRequest *)request;
-(void)noterequestFailed:(ASIHTTPRequest *)request;
-(void)bangdingrequest;
-(void)bangdingrequestFinished:(ASIHTTPRequest *)request;
-(void)bangdingrequestFailed:(ASIHTTPRequest *)request;
@end
