//
//  VerticallyAlignedLabel.m
//  MyLabel
//
//  Created by wanggang on 12-3-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

/*
 UILabel 里放入多行文字,会发现label默认居中对齐,很不符合左对齐的传统习惯,下面这段代码可以让UILabel以垂直方向顶端对齐,也就是我们常说的左对齐或右对齐!
 */
#import "VerticallyAlignedLabel.h"

@implementation VerticallyAlignedLabel

@synthesize verticalAlignment = verticalAlignment_;
@synthesize textPoint = textPoint_;
@synthesize textWidth = textWidth_;

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        self.verticalAlignment = VerticalAlignmentMiddle;   // 默认居中显示
        self.numberOfLines = 0;                             // 默认多行显示
    }
    return self;
}

// 重写set方法
// 设置文字显示风格 -- 顶行 底部 居中显示
- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

// 重写set方法
// 设置文字的显示坐标（x，y）
- (void)setTextPoint:(CGPoint)textPoint
{
    textPoint_ = textPoint;
    [self setNeedsDisplay];
}

// 重写set方法
// 设置文字的显示宽度
- (void)setTextWidth:(NSUInteger)textWidth
{
    textWidth_ = textWidth;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];

    NSValue *textPointValue = [NSValue valueWithCGPoint:textPoint_];
    NSValue *pointZeroValue = [NSValue valueWithCGPoint:CGPointZero];
    
    if ([textPointValue isEqual:pointZeroValue] && 0 == textWidth_) {   // 坐标 和 宽度 都未设置
        
        switch (self.verticalAlignment) {   // 设置显示风格  顶行 底部 居中显示
                
            case VerticalAlignmentTop:
                textRect.origin.y = bounds.origin.y;
                break;
                
            case VerticalAlignmentBottom:
                textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
                break;
                
            case VerticalAlignmentMiddle:
                textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
                break;
                
            default:
                textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
                break;
        }
    }
    else if (![textPointValue isEqual:pointZeroValue] && 0 != textWidth_) {     // 坐标 和 宽度 都设置
        
        NSString *textString = self.text;
        CGFloat textHeight = self.frame.size.height - textPoint_.y;
        CGSize constraint = CGSizeMake(textWidth_, textHeight);
        CGSize size = [textString sizeWithFont:self.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        textRect.origin = textPoint_;
        textRect.size = size;
    }
    else if (![textPointValue isEqual:pointZeroValue] && 0 == textWidth_) {      // 只设置 坐标
        
        NSString *textString = self.text;
        CGFloat textHeight = self.frame.size.height - textPoint_.y;
        CGFloat textWidth = self.frame.size.width - textPoint_.x;
        CGSize constraint = CGSizeMake(textWidth, textHeight);
        CGSize size = [textString sizeWithFont:self.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        textRect.origin = textPoint_;
        textRect.size = size;
    }
    else if (![textPointValue isEqual:pointZeroValue] && 0 == textWidth_) {      // 只设置 宽度
        
        NSString *textString = self.text;
        CGSize constraint = CGSizeMake(textWidth_, self.frame.size.height);
        CGSize size = [textString sizeWithFont:self.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
//        textRect.origin = CGPointZero;
        textRect.size = size;
    }

//    NSLog(@"%@", [NSValue valueWithCGRect:textRect]);
    return textRect;
}

// NOTE : 在全部alloc init之后调用此方法, 且顺序与alloc init相反
//        requestedRect表示alloc init时候的bounds
- (void)drawTextInRect:(CGRect)requestedRect {
    
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];   // 需要的Rect
    [super drawTextInRect:actualRect];
} 

- (void)dealloc
{
    [super dealloc];
}

@end
