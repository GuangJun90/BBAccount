//
//  GoodsCategoryViewModel.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/4.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsCategoryViewModel : NSObject
/** 货物分类的数组 */
@property (nonatomic, strong) NSArray *goodsCategoryArray;

-(void)refreshGoodsCategoryWithArray:(NSArray *)array;


@end
