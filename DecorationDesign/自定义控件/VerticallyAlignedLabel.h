//
//  VerticallyAlignedLabel.h
//  MyLabel
//
//  Created by wanggang on 12-3-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum VerticalAlignment {
    
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
    
} VerticalAlignment;


@interface VerticallyAlignedLabel : UILabel {
@private
    VerticalAlignment verticalAlignment_;
    CGPoint           textPoint_;
    NSUInteger        textWidth_;
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;
@property (nonatomic, assign) CGPoint           textPoint;
@property (nonatomic, assign) NSUInteger        textWidth;

@end
