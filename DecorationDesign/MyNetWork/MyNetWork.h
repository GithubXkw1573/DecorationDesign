//
//  MyNetWork.h
//  Demo
//
//  Created by 元元 on 13-12-12.
//  Copyright (c) 2013年 元元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "MyASIHTTPRequest.h"
#import "Myprogress.h"

@protocol MyNetWorkDelegate <NSObject>

-(void)MyNetWorkRequestFinished:(MyASIHTTPRequest *)request;
-(void)MyNetWorkRequestFailed:(MyASIHTTPRequest *)request;

@end

@interface MyNetWork : NSObject<ASIHTTPRequestDelegate,MyprogressDelegate>{
    MyASIHTTPRequest *MyRequest;
    id<MyNetWorkDelegate> delegate;
    BOOL progressused;
    Myprogress *progress;
    NSString *myname;
    NSString *myrequestkey;
    NSDictionary *mypostvalue;
}
@property(nonatomic,retain)NSString *myname;
@property(nonatomic,retain)NSString *myrequestkey;
@property(nonatomic,retain)NSDictionary *mypostvalue;
@property(nonatomic,retain)Myprogress *progress;
@property BOOL progressused;
@property(nonatomic,retain)MyASIHTTPRequest *MyRequest;
@property(nonatomic,assign)id<MyNetWorkDelegate> delegate;
-(void)MyNetWorkRequestname:(NSString *)name requestkey:(NSString *)requestkey postvalue:(NSDictionary *)postvalue progressused:(BOOL)used;
-(void)DelegatecancleBtnPressed;
-(void)DelegaterequestBtnPressed;
-(void)requestagain;
@end
