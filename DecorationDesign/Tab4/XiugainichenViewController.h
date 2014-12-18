//
//  XiugainichenViewController.h
//  TGQ
//
//  Created by 元元 on 14-4-20.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@protocol XiugainichenViewDelegate <NSObject>

-(void)XiugainichenViewDelegateBtnPressed:(NSString *)nickName;

@end

@interface XiugainichenViewController : UIViewController<UITextFieldDelegate>{
    UITextField *TextField;
    MBProgressHUD *MBProgress;
    ASIFormDataRequest *Xiugaihttprequest;
    NSDictionary *Dictionary;
    id<XiugainichenViewDelegate> delegate;
}
@property(nonatomic,assign)id<XiugainichenViewDelegate> delegate;
@property(nonatomic,retain)NSDictionary *Dictionary;
@property(nonatomic,retain)MBProgressHUD *MBProgress;
@property(nonatomic,retain)ASIFormDataRequest *Xiugaihttprequest;
@property(nonatomic,retain)UITextField *TextField;
-(void)XiugainichenViewControllerBtnPressed:(id)sender;
-(void)Xiugairequest;
-(void)XiugairequestFinished:(ASIHTTPRequest *)request;
-(void)XiugairequestFailed:(ASIHTTPRequest *)request;
@end
