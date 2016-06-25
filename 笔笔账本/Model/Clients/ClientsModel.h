//
//  ClientsModel.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/15.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClientsModel : NSObject
/** ID */
@property(nonatomic,assign) NSInteger ID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
/** 地址 */
@property(nonatomic,strong) NSString *address;
/** 客户头像 */
@property(nonatomic,strong) NSData *Img;

@property(strong,nonatomic) NSString *pinYin;

@end
