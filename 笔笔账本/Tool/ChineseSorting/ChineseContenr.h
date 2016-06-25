//
//  ChineseContenr.h
//  ELuYunApp
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 zhaoguodong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "pinyin.h"

@interface ChineseContenr : NSObject
@property(strong,nonatomic)NSString *string;
@property(strong,nonatomic)NSString *pinYin;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;


+(NSMutableArray*)LetterSortModel:(NSArray*)stringArr;
+(NSMutableArray*)ReturnSortChineseArr:(NSMutableArray*)stringArr;

+(NSMutableArray*)LetterSortCustomerManageModel:(NSArray*)stringArr;
+(NSMutableArray*)ReturnSortChineseCustomerManageArr:(NSMutableArray*)stringArr;
+(NSMutableArray*)LetterSortSupplierModel:(NSArray*)stringArr;

///----------------------
//返回一组字母排序数组(中英混排)
+(NSMutableArray*)SortArray:(NSArray*)stringArr;

/**
 * 返回Model的Array[Model里面要有pinYin ,sortChinese 两个key]
 */
+(NSMutableArray *)LetterSortModelByPinYin:(NSArray *)modelArray;
@end
