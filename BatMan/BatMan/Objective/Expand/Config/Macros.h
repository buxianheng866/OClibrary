//
//  Macros.h
//  BatMan
//
//  Created by nb616 on 2017/9/27.
//  Copyright © 2017年 nb616. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

/*******************Global(全局设置)************************/

#define App_Color  RGBAColor(154,201,37,1)         //应用颜色

#define Navi_backImage  BuidlImage(@"Genal_NaviBack")    //返回图片

#define TopBarHeight  isIPhoneX ? 88 : 64        //导航栏高度

#define BottomBarHeight isIPhoneX ? 83 : 49      //低栏栏高度

#define StatusBarHeight isIPhoneX ? 44 : 20 //状态栏高度



/*******************Method(方法宏)************************/

#define MScreenWidth         [[UIScreen mainScreen] bounds].size.width

#define MScreenHeight        [[UIScreen mainScreen] bounds].size.height

#define MStatusBarHeight      [UIApplication sharedApplication].statusBarFrame.size.height

#define AppDelegateInstance  [[UIApplication sharedApplication] delegate]  //AppDelegate对象

#define kApplication         [UIApplication sharedApplication]

#define kKeyWindow           [UIApplication sharedApplication].keyWindow  //主视图

#define kUserDefaults        [NSUserDefaults standardUserDefaults]  //存储

#define kNotificationCenter  [NSNotificationCenter defaultCenter]     //通知

#define Text_Font(font)      [UIFont systemFontOfSize:font]

#define RGBAColor(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]  //色值

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]  //16进制色值

#define  Text_Size(text,size,font) [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil]; //计算文字高度


#define App_Version          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]  //App版本号

//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define isIOS8                ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0) // 是否大于等于IOS8

#define isIOS9                ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0) // 是否大于IOS9

#define isPad                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)     // 是否iPad
#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.height==2436 : NO)

#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]   // 是否空对象

#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )  //字符串是否为空

#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)   //数组是否为空

#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)   //字典是否为空

//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])   //获取当前语言

#define BuidlImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]  //获取图片资源

//Library/Caches 文件路径
#define kFilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])

#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]  //获取沙盒 Document

#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]      //获取沙盒 Cache

//在主线程上运行
#define DISPATCH_ON_MAINQUEUE(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//在Global Queue上运行
#define DISPATCH_ON_GLOBAL(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

#define W_S(weakSelf)  __weak __typeof(&*self)weakSelf = self  //弱引用
// 本地化语言
#define LocalString(x, ...)     NSLocalizedString(x, nil)

#define BundleLoadNib(x) [[NSBundle mainBundle] loadNibNamed:@(x) owner:nil options:nil][0]

#define Navi_Push(controll)      [self.navigationController pushViewController:controll animated:YES];
#define Navi_POP                 [self.navigationController popViewControllerAnimated:YES];
#define Navi_Hidden(xx)          [self.navigationController setNavigationBarHidden:xx animated:YES]

#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif
#endif /* Macros_h */
