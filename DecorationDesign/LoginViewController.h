//
//  LoginViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/8.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "RegisterViewController.h"
#import "QQkongjianApi.h"
#import "WXShareApi.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,wxlogindelegate,qqlogindelegate>
{
    MBProgressHUD *MBProgress;
}

@end
