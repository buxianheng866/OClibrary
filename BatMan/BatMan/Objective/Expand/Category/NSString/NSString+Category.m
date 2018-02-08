//
//  NSString+Category.m
//  BatMan
//
//  Created by nb616 on 2017/12/11.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isCarNumber
{
    NSString *carRegex = @"^[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}

- (BOOL)isURL
{
    NSURL *url = [NSURL URLWithString:self];
    if (url && url.host) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (int)stringConvertToInt
{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

//判断字符串为6～12位“字符”
- (BOOL)isValidateName:(NSString *)name{
    NSUInteger  character = 0;
    for(int i=0; i< [name length];i++){
        int a = [name characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fa5){ //判断是否为中文
            character +=2;
        }else{
            character +=1;
        }
    }
    if (character >=6 && character <=12) {
        return YES;
    }else{
        return NO;
    }
}

// 只能为中文
-(BOOL)onlyInputChineseCharacters:(NSString*)string{
    NSString *zhString = @"[\u4e00-\u9fa5]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zhString];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}
//只能为数字
- (BOOL)onlyInputTheNumber:(NSString*)string{
    NSString *numString =@"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numString];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}
//只能为小写
- (BOOL)onlyInputLowercaseLetter:(NSString*)string{
    NSString *regex =@"[a-z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}
//只能为大写
- (BOOL)onlyInputACapital:(NSString*)string{
    NSString *regex =@"[A-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}
//允许大小写
- (BOOL)InputCapitalAndLowercaseLetter:(NSString*)string{
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}
//允许含大小写或数字(不限字数)
- (BOOL)inputLettersOrNumbers:(NSString*)string{
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}
//允许含大小写或数字(限字数)
-(BOOL)inputNumberOrLetters:(NSString*)name {
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL inputString = [userNamePredicate evaluateWithObject:name];
    return inputString;
}
//允许汉字或数字(不限字数)
- (BOOL)inputChineseOrNumbers:(NSString*)string{
    NSString *regex =@"[\u4e00-\u9fa5]+[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}

//允许汉字或数字(限字数)
- (BOOL)inputChineseOrNumbersLimit:(NSString*)string{
    NSString *regex =@"[\u4e00-\u9fa5][0-9]{6,20}+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}

//允许汉字，大小写或数字(不限字数)
- (BOOL)inputChineseOrLettersAndNumbersNum {
    NSString *regex =@"[\u4e00-\u9fa5]+[A-Za-z0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL inputString = [predicate evaluateWithObject:self];
    return inputString;
}
//允许汉字，大小写或数字(限字数)
- (BOOL)inputChineseOrLettersNumberslimit:(NSString*)string {
    NSString *regex =@"[\u4e00-\u9fa5]+[A-Za-z0-9]{6,20}+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}

- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

@end
