//
//  ChooseObjectCell.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/20.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "ChooseObjectCell.h"

@implementation ChooseObjectCell
+ (id)cellWithTableView:(UITableView *)tableView withImageName:(NSString *)imageName withSelectedImageName:(NSString *)selectedImageName {
    
    static NSString *identifier = @"cell";
    ChooseObjectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ChooseObjectCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    //设置cell的字体大小
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    
    //设置cell的背景图片
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:imageName];
    cell.backgroundView = bgView;
    
    //设置选中后的背景图片
    UIImageView *bgSelView = [[UIImageView alloc] init];
    bgSelView.image = [UIImage imageNamed:selectedImageName];
    cell.selectedBackgroundView = bgSelView;
    
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
