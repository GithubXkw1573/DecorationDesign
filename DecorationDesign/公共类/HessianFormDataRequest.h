//
//  HessianFormDataRequest.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/8.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

@protocol DecorationServiceRPC <NSObject>

-(NSDictionary*)invokeService:(NSDictionary*)params;

@end

#if NS_BLOCKS_AVAILABLE
typedef void (^CompletedBlock)(NSDictionary *dic);
typedef void (^FailedBlock)(void);
#endif

#import <Foundation/Foundation.h>
#import "HessianKit.h"
#import "PublicFunction.h"

@interface HessianFormDataRequest : NSObject
{
    NSDictionary *postData;
    
    id<DecorationServiceRPC> rpc;
    
    #if NS_BLOCKS_AVAILABLE
    CompletedBlock completedBlock;
    FailedBlock failedBlock;
    #endif
}


#if NS_BLOCKS_AVAILABLE
- (void)setCompletionBlock:(CompletedBlock)aCompletionBlock;
- (void)setFailedBlock:(FailedBlock)aFailedBlock;
#endif

- (id)initWithURL:(NSURL *)newURL;

@property (retain) NSDictionary *postData;

@property (nonatomic, strong) id<DecorationServiceRPC> rpc;


-(void)startRequest;
@end
