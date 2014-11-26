//
//  CoverViewController.h
//  iPaiViewController
//
//  Created by Royce Allan on 11-5-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "IntroduceView.h"

@interface CoverViewController : UIViewController {
    NSInteger totleTime;
    NSTimer *timer;
    BOOL netOK;
}
@property(nonatomic,retain)NSTimer *timer;
-(void)beginTimer;
-(void)handleMaxShowTimer:(NSTimer *)theTimer;
-(void)animationDidStop:(id)sender;
@end
