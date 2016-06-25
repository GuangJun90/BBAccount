//
//  AccountViewController.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/19.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController
/** navTitleView */
@property(nonatomic,strong) UIView *navTitleView;
/** listMenuButton */
@property(nonatomic,strong) UIButton *listMenuBtn;
/** MenuLabel */
@property(nonatomic,strong) UILabel *menuLabel;
/** ImageView */
@property(nonatomic,strong) UIImageView *arrowImageView;
/** bool */
@property(nonatomic,assign) BOOL isOpen;

@end
