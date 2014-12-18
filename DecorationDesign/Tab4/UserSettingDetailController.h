//
//  UserSettingDetailController.h
//  QSQ
//
//  Created by ssyz on 13-8-14.
//  Copyright (c) 2013年 luob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface UserSettingDetailController : UIViewController<UITextFieldDelegate>{
    UITextField *oneText;
    UITextField *twoText;
    MBProgressHUD *MBProgress;
    ASIFormDataRequest *myrequest;
}
@property(nonatomic, retain)ASIFormDataRequest *myrequest;
@property(nonatomic, retain)MBProgressHUD *MBProgress;
-(void)UserSettingDetailControllerBtnPressed:(id)sender;
-(void)changepasswordrequest;
-(void)changepasswordrequestFinished:(ASIHTTPRequest *)request;
-(void)changepasswordrequestFailed:(ASIHTTPRequest *)request;
-(void)beganchange;
@end
