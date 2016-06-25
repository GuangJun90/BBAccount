//
//  RegisterVC.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/24.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,RegisterError)
{
    RegisterErrorNone = 0,
    RegisterErrorPhoneEmpty,
    RegisterErrorPhoneFormat,
    RegisterErrorCodeEmpty,
    RegisterErrorCode,
    RegisterErrorPwdEmpty,
    RegisterErrorPwdLength
};

typedef NS_ENUM(NSInteger,RegCheckType)
{
    RegCheckTypePhone = 0,
    RegCheckTypeAll
};

typedef void(^returnPhoneNum)(NSString *phoneNum);

@interface RegisterVC : UIViewController

/** block */
@property(nonatomic,copy) returnPhoneNum phoneNumBlock;

- (void)returnPhoneNum:(returnPhoneNum)block;

@end
