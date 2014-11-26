//
//  MyASIHTTPRequest.m
//  Demo
//
//  Created by 元元 on 13-12-16.
//  Copyright (c) 2013年 元元. All rights reserved.
//

#import "MyASIHTTPRequest.h"

@implementation MyASIHTTPRequest
@synthesize reqType;

-(void)dealloc
{
    [reqType release];
    [super dealloc];
}

-(void)setPostValue:(NSDictionary *)postvalue
{
    NSArray *array=[postvalue allKeys];
    for (int i=0; i<[array count]; i++) {
        NSString *Key=(NSString *)[array objectAtIndex:i];
        NSString *Value=(NSString *)[postvalue objectForKey:Key];
        [self setPostValue:Value forKey:Key];
    }
}

@end
