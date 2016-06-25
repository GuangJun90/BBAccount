//
//  GoodsCell.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/6.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
@class GoodsCell;
@protocol GoodsCellDelegate <NSObject>
/** 右侧按钮被点击 */
- (void)goodsCellStepperClicked:(GoodsModel *)goodsModel;
@end
@interface GoodsCell : UITableViewCell

/** 货物数据 */
@property(nonatomic,strong) GoodsModel *goodsModel;

/** 代理 */
@property(nonatomic,weak) id<GoodsCellDelegate> delegate;

@end
