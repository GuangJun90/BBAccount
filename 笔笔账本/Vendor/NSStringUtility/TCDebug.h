//
//  TCDebug.h
//  DragonWell
//
//  Created by ChenQi on 13-1-30.
//  Copyright (c) 2013年 TCGROUP. All rights reserved.
//

#import "iConsole.h"

#ifndef DragonWell_TCDebug_h
#define DragonWell_TCDebug_h


#if defined(DEBUG) || defined(_DEBUG) || defined(__DEBUG)
#define TC_IOS_DEBUG
#endif



#ifdef TC_IOS_DEBUG

// info (优先级:低)
#define DLog_i(fmt, ...) \
[iConsole info:@"%@(%d)\n%s: " fmt, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
__PRETTY_FUNCTION__,## __VA_ARGS__]

// warning (优先级:中)
#define DLog_w(fmt, ...) \
[iConsole warn:@"%@(%d)\n%s: " fmt, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
 __LINE__, \
 __PRETTY_FUNCTION__,## __VA_ARGS__]

// error (优先级:高)
#define DLog_e(fmt, ...) \
[iConsole error:@"%@(%d)\n%s: " fmt, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
__PRETTY_FUNCTION__,## __VA_ARGS__]

// crash (优先级:最高)
#define DLog_c(fmt, ...) \
[iConsole crash:@"%@(%d)\n%s: " fmt, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
__PRETTY_FUNCTION__,## __VA_ARGS__]

//#define DLog DLog_i

#else

//#define DLog(...)   ;
#define DLog_i(...) ;
#define DLog_w(...) ;
#define DLog_e(...) ;
#define DLog_c(...) ;

#endif

#endif
