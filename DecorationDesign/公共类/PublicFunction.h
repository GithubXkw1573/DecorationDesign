//
//  PublicFunction.h
//  XKXF
//
//  Created by ssyz on 13-4-3.
//  Copyright (c) 2013年 luob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface PublicFunction : NSObject{
    
}
+(BOOL)validateUserPasswd:(NSString *) str;
+(BOOL)validateUserName:(NSString *) str;
+(BOOL)validateUserBornDate:(NSString *) str;
+(BOOL)validateUserPhone:(NSString *) str;
+(BOOL)validateUserEmail:(NSString *) str;
+(BOOL)validatealphabet:(NSString *)str;
+(BOOL)validatenumber:(NSString *)str;

+(NSString *)urlDecode:(NSString *)oldString;
+(NSDictionary*)fixDictionary:(NSDictionary*)dic;
+(NSDictionary*)fixDictionary2:(NSDictionary*)dic;
+(UIImage *)createImageWithColor:(UIColor *)color;

+(void)addCustomButtonTo:(UIView*)father Rect:(CGRect)rect Title:(NSString*)text TitleColor:(UIColor*)textColor Insets:(UIEdgeInsets)insets Font:(UIFont*)font Image:(NSString*)imageString SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag;
+(void)addViewTo:(UIView*)father Rect:(CGRect)rect BackgroundColor:(UIColor*)color Tag:(NSInteger)tag;
+(void)addLabelTo:(UIView*)father Rect:(CGRect)rect  Title:(NSString*)text TitleColor:(UIColor*)textColor  Font:(UIFont*)font Alignment:(NSTextAlignment)alignment Tag:(NSInteger)tag MutiRow:(BOOL)isMutiRow;
+(void)addImageTo:(UIView*)father Rect:(CGRect)rect Image:(NSString*)image SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag;
+(void)addRoundImageTo:(UIView*)father Rect:(CGRect)rect Image:(NSString*)image BorderColor:(UIColor*)borderColor SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag;
+(void)addImageButtonTo:(UIView*)father Rect:(CGRect)rect SEL:(SEL)selector Image:(NSString*)image  Responsder:(id)object Tag:(NSInteger)tag;
+(void)addTextButtonTo:(UIView*)father Rect:(CGRect)rect  Title:(NSString*)text TitleColor:(UIColor*)textColor SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag;
+(NSString*)getSubDictionaryValue:(NSDictionary*)dic withKey:(NSString*)key subKey:(NSString*)subKey;
@end