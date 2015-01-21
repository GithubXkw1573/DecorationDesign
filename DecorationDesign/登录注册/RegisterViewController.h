//
//  RegisterViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/9.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
{
    MBProgressHUD *MBProgress;
    UITextField *cellField;
    UITextField *yzmField;
    UITextField *passField;
    UITextField *comfpassField;
    NSTimer *timer;
    int time;
    UIButton *yanzhengbtn;
}
@property(nonatomic,retain)NSTimer *timer;
@end
