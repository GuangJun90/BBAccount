//
//  MetaDataView.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/20.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "MetaDataView.h"

@implementation MetaDataView
+(id)getMetaDataView{
    return [[[NSBundle mainBundle]loadNibNamed:@"MetaDataView" owner:self options:nil] firstObject];
}

@end
