//
//  QQkongjianApi.h
//  TGQ2
//
//  Created by 元元 on 14-9-28.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>

@protocol qqkongjiandelegate

-(void)sharesuccessful:(NSString *)str;
-(void)sharefailed:(NSString *)str;

@end

@protocol qqlogindelegate

-(void)loginsuccessful:(NSString *)str OAuth:(id)OAuth userinfo:(NSDictionary *)dic;
-(void)loginfailed:(NSString *)str;

@end

@interface QQkongjianApi : NSObject<QQApiInterfaceDelegate,TencentSessionDelegate>{
    TencentOAuth *tencentOAuth;
    id<qqkongjiandelegate>delegate;
    id<qqlogindelegate>logindelegate;
}
@property(assign,nonatomic)id<qqkongjiandelegate>delegate;
@property(assign,nonatomic)id<qqlogindelegate>logindelegate;
@property(nonatomic,retain)TencentOAuth *tencentOAuth;
+(QQkongjianApi *)shared;
-(void)QQlogin;
-(void)kongjianLinkContent:(NSString *)url imageContent:(UIImage *)image title:(NSString *)title detail:(NSString *)detail;
-(BOOL)handleOpen:(NSURL *)url;
@end
