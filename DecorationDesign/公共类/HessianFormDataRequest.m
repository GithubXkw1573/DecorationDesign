//
//  HessianFormDataRequest.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/8.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "HessianFormDataRequest.h"

@implementation HessianFormDataRequest
@synthesize postData,rpc;

- (id)initWithURL:(NSURL *)newURL
{
    if (self = [super init]) {
        self.rpc = (id<DecorationServiceRPC>)[CWHessianConnection proxyWithURL:newURL protocol:@protocol(DecorationServiceRPC)];
    }
	return self;
}

- (void)setCompletionBlock:(CompletedBlock)aCompletionBlock
{
    completedBlock = aCompletionBlock;
}

- (void)setFailedBlock:(FailedBlock)aFailedBlock
{
    failedBlock = aFailedBlock;
}


-(void)startRequest
{
    @try
    {
        if ([PublicFunction isNetworkReachable] == nil) {
            failedBlock();
        }else{
            
            NSDictionary *result = [rpc invokeService:postData];
            if (result) {
                
                completedBlock(result);
            }else{
                failedBlock();
            }
        }
    }
    @catch (NSException *exception) {
        failedBlock();
    }
    
}

@end
