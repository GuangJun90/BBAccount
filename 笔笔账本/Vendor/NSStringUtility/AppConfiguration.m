//
//  AppConfiguration.m
//  NiceMother
//
//  Created by kevin on 15/7/30.
//  Copyright (c) 2015年 com.nicemother. All rights reserved.
//

#import "AppConfiguration.h"
#import <SSKeychain.h>
#define kMyService      @"com.nicemother"
#define GET_NAME(X) [NSString stringWithFormat:@"%s",#X]

@implementation AppConfiguration

+(void) setConfiguration:(enumAppConfigure_Key) key value:(NSObject*) value
{
    if (nil == value)
        return;
    
    switch (key) {
        case key_IS_FIRST_LAUNCH:
            [self saveKey:GET_NAME(key_IS_FIRST_LAUNCH) value:value];
            break;
        case key_LOGIN_TOKEN:
            [SSKeychain setPassword:(NSString*)value forService:kMyService account:GET_NAME(key_LOGIN_TOKEN)];
            break;
        case key_LOGIN_USERID:
            [SSKeychain setPassword:(NSString*)value forService:kMyService account:GET_NAME(key_LOGIN_USERID)];
            break;
        case key_ACCOUNTINFO:
            if ([value isKindOfClass:[NSDictionary class]])
                [self saveKey:GET_NAME(key_ACCOUNTINFO) value:value];
            break;
        case key_ANSWER_CONTENT_URL:
            [self saveKey:GET_NAME(key_ANSWER_CONTENT_URL) value:value];
            break;
        default:
            break;
    }
}

+(NSObject*) getConfiguration:(enumAppConfigure_Key) key
{
    NSObject *ret = nil;
    switch (key) {
            
//************ 只读 ***************
            
        case key_Host_Url:
            return [self hostUrl];
            break;
         case key_Host_Name:
            return [self hostName];
            break;
       case key_Server_Default_Time_Zone:
            ret = @"Asia/Shanghai";
            break;
        case key_Max_Net_Thread_Count:             //最大线程数
            ret = @5;
            break;
        case key_Upload_Image_Size_Limit:         //上传图片大小限制
            ret = @800;
            break;
        case key_Net_Connection_Timeout:           //网络请求超时
            ret = @30;
            break;
        case key_Jpeg_Compression:
            ret = @0.9;
            break;
            
//*************** 读写 ***************

        case key_IS_FIRST_LAUNCH:
            ret = [NSNumber numberWithBool:![self hasSavedValue:GET_NAME(key_IS_FIRST_LAUNCH)]];
            break;
        case key_LOGIN_TOKEN:
        {
            NSError *error = nil;
            ret = [SSKeychain passwordForService:kMyService account:GET_NAME(key_LOGIN_TOKEN) error:&error];
         }
            break;
        case key_LOGIN_USERID:
        {
            NSError *error = nil;
            ret = [SSKeychain passwordForService:kMyService account:GET_NAME(key_LOGIN_USERNAME) error:&error];
        }
            break;
        case key_ACCOUNTINFO:
            ret =[[NSUserDefaults standardUserDefaults] dictionaryForKey:GET_NAME(key_ACCOUNTINFO)];
            break;
        case key_ANSWER_CONTENT_URL:
            ret = [[NSUserDefaults standardUserDefaults] stringForKey:GET_NAME(key_ANSWER_CONTENT_URL)];
            if (ret == nil)
            {
#ifdef _PROD_ENV_
                ret = @"";
#elif defined _TEST_ENV_
                ret = @"";
#else //if defined _DEV_ENV_
                ret = @"http://192.168.1.201:9000/answer?apptype=ios";            //测试
//                ret = @"http://192.168.100.45:9000/answer?apptype=ios";             //俊
#endif
            }
            break;
        default:
            break;
    }
    
    return ret;
}

+(BOOL) hasSavedValue:(NSString*) key
{
    return (nil != [[NSUserDefaults standardUserDefaults] objectForKey:key]);
}

+(void) saveKey:(NSString*) key  value:(NSObject*) value
{
    if (key && [key length] > 0 && value)
    {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


+(NSString*) hostUrl
{
#ifdef _PROD_ENV_
    return @"";
#elif defined _TEST_ENV_
    return @"";
#else //if defined _DEV_ENV_
    return @"http://192.168.1.201:8080/sns-api";
#endif
}

+(NSString*) hostName
{
#ifdef _PROD_ENV_
    return @"";
#endif
    
#ifdef _TEST_ENV_
    return @"";
#endif
    
#ifdef _DEV_ENV_
    return @"http://192.168.1.201:8080";
#endif
}
@end
