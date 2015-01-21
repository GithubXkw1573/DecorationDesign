//
//  ZiliaoDetaillViewController.h
//  TGQ
//
//  Created by 许开伟 on 13-12-24.
//  Copyright (c) 2013年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface ZiliaoDetaillViewController : UIViewController<UIWebViewDelegate>{
    NSDictionary *Dictionary;
    UIWebView *WebView;
    ASIFormDataRequest *detailhttprequest;
    
    MBProgressHUD *MBProgress;
}
@property(nonatomic,retain)MBProgressHUD *MBProgress;
@property(nonatomic,retain)ASIFormDataRequest *detailhttprequest;
@property(nonatomic,retain)UIWebView *WebView;
@property(nonatomic,retain)NSDictionary *Dictionary;
-(void)ZiliaoDetaillViewControllerBtnPressed:(id)sender;
-(void)clearWebViewBackgroundWithColor;
-(void)detailrequest;
-(void)detailrequestFinished:(ASIHTTPRequest *)request;
-(void)detailrequestFailed:(ASIHTTPRequest *)request;

@end
