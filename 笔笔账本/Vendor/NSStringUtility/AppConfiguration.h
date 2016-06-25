//
//  AppConfiguration.h
//  NiceMother
//
//  Created by kevin on 15/7/30.
//  Copyright (c) 2015年 com.nicemother. All rights reserved.
//

#import <Foundation/Foundation.h>

//三选一
#define _DEV_ENV_                   //开发环境
//#define _TEST_ENV_                  //测试环境
//#define _PROD_ENV_                  //发布环境


typedef NS_ENUM(uint, enumAppConfigure_Key){
    //************ 只读 ***************
    key_Host_Url            = 1         //server url add before http request
,   key_Host_Name                       //server name add before image url
,   key_Server_Default_Time_Zone        //默认时区
,   key_Max_Net_Thread_Count            //网络最大线程数， -1代表不限制
,   key_Upload_Image_Size_Limit         //上传图片大小限制
,   key_Net_Connection_Timeout           //网络请求超时
,   key_Jpeg_Compression                 //jpeg 压缩比
    

    //*************** 读写 ***************
,   key_IS_FIRST_LAUNCH                 //是否第一次登录
,   key_LOGIN_TOKEN                   //登录后 Token
,   key_LOGIN_USERID                  //登录后 用户唯一标识符
,   key_ACCOUNTINFO                    //登录后 账户信息
,   key_ANSWER_CONTENT_URL     // 回答的内容的URL
};

@interface AppConfiguration : NSObject

+(NSObject*) getConfiguration:(enumAppConfigure_Key) key;

+(void) setConfiguration:(enumAppConfigure_Key) key value:(NSObject*) value;



+(NSString*) hostUrl;
+(NSString*) hostName;
@end
