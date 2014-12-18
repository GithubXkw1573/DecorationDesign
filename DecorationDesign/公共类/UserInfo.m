//
//  UserInfo.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/9.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
@synthesize m_isLogin;
@synthesize m_isMember;
@synthesize m_PassWord;
@synthesize m_UserName;
@synthesize m_Id;
@synthesize m_nikeName;
@synthesize m_plateType;
@synthesize m_toupic;

@synthesize loc_city;
@synthesize curr_city;
@synthesize loc_qu;
@synthesize loc_lat;
@synthesize loc_lng;

static UserInfo *userinfo;

+(UserInfo *)shared
{
    if (userinfo == nil) {
        userinfo = [[UserInfo alloc] init];
    }
    return userinfo;
}

- (id)init
{
    if (self=[super init]) {
        m_isLogin=[[NSUserDefaults standardUserDefaults] boolForKey:@"m_isLogin"];
        m_isMember=[[NSUserDefaults standardUserDefaults] boolForKey:@"m_isMember"];
        m_Id=[[NSUserDefaults standardUserDefaults] objectForKey:@"m_Id"];
        m_PassWord=[[NSUserDefaults standardUserDefaults] objectForKey:@"m_PassWord"];
        m_UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"m_UserName"];
        m_nikeName=[[NSUserDefaults standardUserDefaults] objectForKey:@"m_nikeName"];
        m_toupic=[[NSUserDefaults standardUserDefaults] objectForKey:@"m_toupic"];
    }
    return self;
}

- (void)saveUserInfo
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:m_PassWord forKey:@"m_PassWord"];
    [defaults setObject:m_UserName forKey:@"m_UserName"];
    [defaults setBool:m_isLogin forKey:@"m_isLogin"];
    [defaults setBool:m_isMember forKey:@"m_isMember"];
    [defaults setObject:m_Id forKey:@"m_Id"];
    [defaults setObject:m_nikeName forKey:@"m_nikeName"];
    [defaults setObject:m_toupic forKey:@"m_toupic"];
    [defaults synchronize];
}

- (void)removeUserInfo
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"m_PassWord"];
    [defaults removeObjectForKey:@"m_UserName"];
    [defaults removeObjectForKey:@"m_isLogin"];
    [defaults removeObjectForKey:@"m_isMember"];
    [defaults removeObjectForKey:@"m_Id"];
    [defaults removeObjectForKey:@"m_nikeName"];
    [defaults removeObjectForKey:@"m_toupic"];
    [defaults synchronize];
}
@end
