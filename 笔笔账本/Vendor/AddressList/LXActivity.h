//
//  LXActivity.h
//  LXActivityDemo
//
//  Created by eluying02 on 15/12/18.
//  Copyright © 2015年 eluying02. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXActivityDelegate <NSObject>
- (void)didClickOnImageIndex:(NSInteger )imageIndex;
@optional
- (void)didClickOnCancelButton;
@end

@interface LXActivity : UIView


//+ (UIImage *)imageWithColor:(UIColor *)color;


- (id)initWithTitle:(NSString *)title phoneNum:(NSString *)phoneNum  delegate:(id<LXActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray heightIamgeArray:(NSArray *)heihtArray;
- (void)showInView:(UIView *)view;

/**
 
 
 做类似于UIActionSheet弹出框
 
 取消按钮--换成插号删除---
 

 
 */



@end
