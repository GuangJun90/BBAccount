//
//  MetaDataView.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/20.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetaDataView : UIView
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTablewView;
//返回当前从xib加载的视图
+ (id)getMetaDataView;

@end
