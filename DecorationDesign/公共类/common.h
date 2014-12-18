#import "MyNetWork.h"
#import "PublicFunction.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "MBProgressHUD.h"
#import "MD5Hash.h"
#import "VerticallyAlignedLabel.h"
#import "UIImageView+WebCache.h"
//#import "PurchaseObject.h"
#import "ShowMessaege.h"
//#import "CHKeychain.h"
#import "pinyin.h"
#import "UserInfo.h"
#import "HessianFormDataRequest.h"
#import "myLabel.h"

#define UIVIEW_ANIMATION_BEGIN3(animationid, time, sel)\
[UIView beginAnimations:animationid context:nil];\
[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];\
[UIView setAnimationDelegate:self];\
[UIView setAnimationDidStopSelector:sel];\
[UIView setAnimationDuration:time];

#define UIVIEW_ANIMATION_END [UIView commitAnimations];

#define setshadow(object)\
object.layer.shadowColor = [UIColor blackColor].CGColor;\
object.layer.shadowOffset = CGSizeMake(1, 1);\
object.layer.shadowOpacity = 0.5;\
object.layer.shadowRadius = 1.0;\

#define setcorner(object)\
object.layer.cornerRadius = 8;\
object.layer.masksToBounds = YES;\

#define mystring(n) [NSString stringWithFormat:@"%@",n]


//Request请求
//#define MineURL @"http://10.0.1.72:8080/tx/"   //刘军   13951637983 q123456
//#define MineURL @"http://10.0.1.71/tx/"   //推送测试
//#define MineURL @"http://10.0.1.242:8080/tx_personal/"   //测试
#define MineURL @"http://42.121.112.185/XuanR_DecorationApp_Server/InfoSelectServer" //正式
#define MineURL2 @"http://www.tuixiang.com:8080/"   //第三方登陆和绑定新浪微博
#define ktimeOutSeconds 30

#define iOS7Later ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define myappcolor colorWithPatternImage:[UIImage imageNamed:@"标题栏6.png"]
#define beijingcolor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]

#define myorangecolor colorWithRed:235.0/255.0 green:53.0/255.0 blue:64.0/255.0 alpha:1.0
#define myellow [UIColor colorWithRed:251/255.0f green:168/255.0f blue:84/255.0f alpha:1]
#define myblue [UIColor colorWithRed:62/255.0f green:189/255.0f blue:246/255.0f alpha:1]
#define myred [UIColor colorWithRed:255/255.0f green:71/255.0f blue:92/255.0f alpha:1]

#define MineVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define myappid @"862872120"
