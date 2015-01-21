//
//  MyNetWork.m
//  Demo
//
//  Created by 元元 on 13-12-12.
//  Copyright (c) 2013年 元元. All rights reserved.
//

#import "MyNetWork.h"
#import "common.h"

@implementation MyNetWork
@synthesize delegate;
@synthesize MyRequest;
@synthesize progressused;
@synthesize progress;
@synthesize myname;
@synthesize mypostvalue;
@synthesize myrequestkey;

-(void)dealloc
{
    [mypostvalue release];
    [myrequestkey release];
    [myname release];
    [progress release];
    [MyRequest clearDelegatesAndCancel];
    [MyRequest release];
    delegate=nil;
    [super dealloc];
}

-(void)MyNetWorkRequestname:(NSString *)name requestkey:(NSString *)requestkey postvalue:(NSDictionary *)postvalue progressused:(BOOL)used
{
    self.myname=name;
    self.mypostvalue=postvalue;
    self.myrequestkey=requestkey;
    self.progressused=used;
    NSString *url_str=[NSString stringWithFormat:@"%@%@",MineURL,name];
    NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    MyASIHTTPRequest *request=[[[MyASIHTTPRequest alloc] initWithURL:url] autorelease];
    
    [request setPostValue:postvalue];
    request.reqType=requestkey;
    request.timeOutSeconds=30;
    [self.MyRequest cancel];
    self.MyRequest=request;
    
    if (progressused) {
        progress=[[Myprogress alloc]initWithFrame:CGRectMake(0, 0, applicationwidth, boundsheight)];
        [progress setmode:1];
        progress.delegate=self;
        [progress settextLabel:@"刷新中..." detailTextLabel:@""];
        
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        [window addSubview:progress];
    }
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(MyNetWorkRequestFinished:)];
    [request setDidFailSelector:@selector(MyNetWorkRequestFailed:)];
    [request startAsynchronous];
}

-(void)requestagain
{
    NSString *url_str=[NSString stringWithFormat:@"%@%@",MineURL,myname];
    NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    MyASIHTTPRequest *request=[[[MyASIHTTPRequest alloc] initWithURL:url] autorelease];
    
    [request setPostValue:mypostvalue];
    request.reqType=myrequestkey;
    request.timeOutSeconds=30;
    [self.MyRequest cancel];
    self.MyRequest=request;
    
    if (progressused) {
        [progress setmode:1];
        [progress settextLabel:@"刷新中..." detailTextLabel:@""];
    }
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(MyNetWorkRequestFinished:)];
    [request setDidFailSelector:@selector(MyNetWorkRequestFailed:)];
    [request startAsynchronous];
}

- (void)MyNetWorkRequestFinished:(MyASIHTTPRequest *)request
{
    [progress removeFromSuperview];
    NSLog(@"%@RequestFinished:%@",request.reqType,[[request responseString] JSONValue]);
    if (delegate != nil && [delegate respondsToSelector:@selector(MyNetWorkRequestFinished:)]) {
        [delegate MyNetWorkRequestFinished:request];
    }
}

- (void)MyNetWorkRequestFailed:(MyASIHTTPRequest *)request
{
    [progress settextLabel:@"刷新失败" detailTextLabel:@"点击重新连接"];
    [progress setmode:2];
    NSLog(@"%@RequestFailed",request.reqType);
    if (delegate != nil && [delegate respondsToSelector:@selector(MyNetWorkRequestFailed:)]) {
        [delegate MyNetWorkRequestFailed:request];
    }
}

- (void)DelegatecancleBtnPressed
{
    [MyRequest cancel];
}

- (void)DelegaterequestBtnPressed
{
    [self requestagain];
}

@end
