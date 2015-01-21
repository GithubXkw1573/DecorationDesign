//
//  ShowMessaege.m
//  HBTV
//
//  Created by luob luob on 12-4-11.
//  Copyright (c) 2012年 luob. All rights reserved.
//

#import "ShowMessaege.h"

@implementation ShowMessaege
- (id)initWithFrame:(CGRect)frame title:(NSString *)loadingTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 160, 60)];
        loadingLabel.text = loadingTitle;
        loadingLabel.numberOfLines = 0;
        [loadingLabel setFont:[UIFont systemFontOfSize:18]];
        loadingLabel.textAlignment = UITextAlignmentCenter;
        loadingLabel.backgroundColor = [UIColor clearColor];
        loadingLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:loadingLabel];
        [loadingLabel release];
    }
    return self;
}

+ (void)ShowWithTitle:(NSString *)loadingTitle
//使用此控件，可以一次初始化添加，多次调用；最后viewDisappear时，需要调用dismissLoadingView方法，移除视图
{
    ShowMessaege *_showMSG = [[ShowMessaege alloc] initWithFrame: CGRectMake(80, 180, 160, 100) title:loadingTitle];
    if (_showMSG) {
        // Initialization code
        
        _showMSG.backgroundColor = [UIColor blackColor];
        _showMSG.alpha = 0.75;
        _showMSG.layer.masksToBounds = YES;
        _showMSG.layer.cornerRadius = 10;
        _showMSG.layer.borderWidth = 1;
        _showMSG.layer.borderColor = [[UIColor grayColor] CGColor];
        
        UIWindow *_window = [[UIApplication sharedApplication] keyWindow];
        [_window addSubview:_showMSG];
  
    }
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_showMSG removeFromSuperview];
        [_showMSG release];
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
