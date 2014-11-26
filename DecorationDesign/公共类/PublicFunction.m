//
//  PublicFunction.m
//  XKXF
//
//  Created by ssyz on 13-4-3.
//  Copyright (c) 2013年 luob. All rights reserved.
//

#import "PublicFunction.h"
#import "DDAppDelegate.h"
#import "common.h"

@implementation PublicFunction

//校验用户名
+ (BOOL) validateUserName : (NSString *) str
{
    NSString *patternStr = [NSString stringWithFormat:@"^.{0,4}$|.{21,}|^[^A-Za-z0-9u4E00-u9FA5]|[^\\wu4E00-u9FA5.-]|([_.-])1"];
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:patternStr
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

//校验用户密码  ^(?![^a-zA-Z]+$)(?!\\D+$).{6,15}$
+ (BOOL) validateUserPasswd : (NSString *) str
{
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^[a-zA-Z0-9]{6,16}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        if ([self validatealphabet:str]&&[self validatenumber:str]) {
            NSLog(@"%@ is UserPasswd: YES", str);
            return YES;
        }
    }
    
    NSLog(@"%@ is UserPasswd: NO", str);
    return NO;
}

+(BOOL)validatealphabet:(NSString *)str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@".*[a-zA-Z].*"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ is alphabet: YES", str);
        return YES;
    }
    
    NSLog(@"%@ is alphabet: NO", str);
    return NO;
}

+(BOOL)validatenumber:(NSString *)str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@".*[0-9].*"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ is number: YES", str);
        return YES;
    }
    
    NSLog(@"%@ is number: NO", str);
    return NO;
}

//校验用户生日
+ (BOOL) validateUserBornDate : (NSString *) str
{
    
    NSString *patternStr = @"^((((1[6-9]|[2-9]\\d)\\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\\d|3[01]))|(((1[6-9]|[2-9]\\d)\\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\\d|30))|(((1[6-9]|[2-9]\\d)\\d{2})-0?2-(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$";
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:patternStr
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", str);
        return YES;
    }
    
    NSLog(@"%@ isNumbericString: NO", str);
    return NO;
}

//校验用户手机号码
+ (BOOL) validateUserPhone : (NSString *) str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^[0-9]{11,11}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", str);
        return YES;
    }
    
    NSLog(@"%@ isNumbericString: NO", str);
    return NO;
}

//校验用户邮箱
+ (BOOL) validateUserEmail : (NSString *) str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", str);
        return YES;
    }
    
    NSLog(@"%@ isNumbericString: NO", str);
    return NO;
}

+(NSString *)urlDecode:(NSString *)oldString{
    NSMutableString *unescaped = [NSMutableString stringWithString:oldString];
    [unescaped replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [unescaped length])];
    return [unescaped stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSDictionary*)fixDictionary:(NSDictionary*)dic
{
    if (dic) {
        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
        //得到词典中所有KEY值
        NSEnumerator * enumeratorKey = [dic keyEnumerator];
        //快速枚举遍历所有KEY的值
        for (NSObject *key in enumeratorKey) {
//            NSLog(@"遍历KEY的值: %@",key);
            //得到value的字符串
            NSString *keyStr = [NSString stringWithFormat:@"%@",key];
            NSString *valueStr = [NSString stringWithFormat:@"%@",[dic objectForKey:key]];
            if ([valueStr isEqualToString:@"<null>"]) {
                valueStr = @"";
            }
            [newDic setObject:valueStr forKey:keyStr];
        }
        return newDic;
    }
    else
    {
        return nil;
    }
}

+(NSDictionary*)fixDictionary2:(NSDictionary*)dic
{
    if (dic) {
        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
        //得到词典中所有KEY值
        NSEnumerator * enumeratorKey = [dic keyEnumerator];
        //快速枚举遍历所有KEY的值
        for (NSObject *key in enumeratorKey) {
            //NSLog(@"遍历KEY的值: %@",key);
            //得到value的字符串
            NSString *keyStr = [NSString stringWithFormat:@"%@",key];
            [newDic setObject:[dic objectForKey:key] forKey:keyStr];
        }
        return newDic;
    }
    else
    {
        return nil;
    }
}

+(NSString*)getSubDictionaryValue:(NSDictionary*)dic withKey:(NSString*)key subKey:(NSString*)subKey
{
    
    if ([dic objectForKey:key]==[NSNull null]) {
        
        return @"";
    }
    else
    {
        NSDictionary *subDic = [self fixDictionary:[dic objectForKey:key]];
        return [subDic objectForKey:subKey];
    }
}

+(UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(void)addCustomButtonTo:(UIView*)father Rect:(CGRect)rect Title:(NSString*)text TitleColor:(UIColor*)textColor Insets:(UIEdgeInsets)insets Font:(UIFont*)font Image:(NSString*)imageString SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag
{
    UIButton *doBtn = [[UIButton alloc] initWithFrame:rect];
    [doBtn setBackgroundImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    doBtn.backgroundColor = [UIColor clearColor];
    doBtn.titleLabel.numberOfLines = 0;
    [doBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [doBtn setContentEdgeInsets:insets];
    doBtn.titleLabel.font = font;
    [doBtn setTitle:text forState:UIControlStateNormal];
    [doBtn setTitleColor:textColor forState:UIControlStateNormal];
    doBtn.tag = tag;
    [doBtn addTarget:object action:selector forControlEvents:UIControlEventTouchUpInside];
    [father addSubview:doBtn];
    [doBtn release];
}

+(void)addTextButtonTo:(UIView*)father Rect:(CGRect)rect  Title:(NSString*)text TitleColor:(UIColor*)textColor SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = font(13);
    btn.tag = tag;
    [btn addTarget:object action:selector forControlEvents:UIControlEventTouchUpInside];
    [father addSubview:btn];
    [btn release];
}

+(void)addImageButtonTo:(UIView*)father Rect:(CGRect)rect SEL:(SEL)selector Image:(NSString*)image  Responsder:(id)object Tag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.tag = tag;
    [btn addTarget:object action:selector forControlEvents:UIControlEventTouchUpInside];
    [father addSubview:btn];
    [btn release];
}

+(void)addRoundImageTo:(UIView*)father Rect:(CGRect)rect Image:(NSString*)image BorderColor:(UIColor*)borderColor SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag
{
    UIImageView *ImageView=[[UIImageView alloc]init];
    ImageView.frame=rect;
    ImageView.tag = tag;
    ImageView.image = [UIImage imageNamed:image];
    if(selector!=nil)
    {
        ImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:object action:selector];
        [ImageView addGestureRecognizer:tap];
    }
    ImageView.backgroundColor = [UIColor clearColor];
    ImageView.layer.masksToBounds = YES;
    ImageView.layer.borderWidth = 1.0f;
    ImageView.layer.borderColor = [borderColor CGColor];
    ImageView.layer.cornerRadius = rect.size.width/2.0f;
    [father addSubview:ImageView];
    [ImageView release];
}

+(void)addImageTo:(UIView*)father Rect:(CGRect)rect Image:(NSString*)image SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag
{
    UIImageView *ImageView=[[UIImageView alloc]init];
    ImageView.frame=rect;
    ImageView.tag = tag;
    ImageView.image = [UIImage imageNamed:image];
    if(selector!=nil)
    {
        ImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:object action:selector];
        [ImageView addGestureRecognizer:tap];
    }
    ImageView.backgroundColor = [UIColor clearColor];
    [father addSubview:ImageView];
    [ImageView release];
}

+(void)addLabelTo:(UIView*)father Rect:(CGRect)rect  Title:(NSString*)text TitleColor:(UIColor*)textColor  Font:(UIFont*)font Alignment:(NSTextAlignment)alignment Tag:(NSInteger)tag MutiRow:(BOOL)isMutiRow
{
    UILabel *myLabel=[[UILabel alloc]initWithFrame:rect];
    myLabel.backgroundColor=[UIColor clearColor];
    myLabel.textColor=textColor;
    myLabel.text = text;
    myLabel.tag = tag;
    if (isMutiRow) {
        myLabel.numberOfLines =0;
    }else{
        myLabel.adjustsFontSizeToFitWidth = YES;
    }
    myLabel.textAlignment=alignment;
    myLabel.font=font;
    [father addSubview:myLabel];
    [myLabel release];
}

+(void)addViewTo:(UIView*)father Rect:(CGRect)rect BackgroundColor:(UIColor*)color Tag:(NSInteger)tag
{
    UIView *aview = [[UIView alloc] initWithFrame:rect];
    aview.backgroundColor = color;
    if (tag!=0) {
        aview.tag = tag;
    }
    [father addSubview:aview];
    [aview release];
}

@end
