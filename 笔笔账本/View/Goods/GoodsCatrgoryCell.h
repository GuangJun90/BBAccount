//
//  GoodsCatrgoryCell.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/13.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsCatrgoryCell;
@protocol GoodsCategoryCellDelegate <NSObject>
/** 右侧按钮被点击 */
- (void)openButtonClickWith:(GoodsCatrgoryCell *)cell;
@end

@interface GoodsCatrgoryCell : UITableViewCell

/** 是否展开 */
@property(nonatomic,assign,getter=isopen) BOOL open;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *button;

/** delegate */
@property(nonatomic,weak) id<GoodsCategoryCellDelegate> delegate;



@end
