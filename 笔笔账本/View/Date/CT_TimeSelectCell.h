//
//  TimeSelectCell.h
//  ELuYunApp
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 zhaoguodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CT_TimeSelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setValueWithArray:(NSMutableArray *)arr indexPath:(NSIndexPath *)indexPath;
@end
