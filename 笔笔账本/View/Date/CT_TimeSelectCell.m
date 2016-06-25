//
//  TimeSelectCell.m
//  ELuYunApp
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 zhaoguodong. All rights reserved.
//

#import "CT_TimeSelectCell.h"

@implementation CT_TimeSelectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setValueWithArray:(NSMutableArray *)arr indexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row == 0)
//    {
//        self.selectImage.hidden = NO;
//    }
    NSDictionary *dic = arr[indexPath.row];
    self.timeLabel.text = [dic objectForKey:@"title"];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
