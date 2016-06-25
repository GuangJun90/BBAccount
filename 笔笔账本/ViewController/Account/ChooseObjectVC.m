//
//  ChooseObjectVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/21.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "ChooseObjectVC.h"

@interface ChooseObjectVC ()

@property (nonatomic, strong) NSArray *sortArray;

@end

@implementation ChooseObjectVC

-(NSArray *)sortArray{
    return @[@"水费",@"电费",@"房租费",@"客户",@"供应商",@"其他"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //常量值
    CGFloat inset = 15;
    CGFloat buttonHeight = 30;
    CGFloat buttonWidth = 60;
    for (int i = 0; i < self.sortArray.count; i++) {
        //创建button
        UIButton *button = [UIButton new];
        //设置button属性
        button.frame = CGRectMake(inset, i*(inset+buttonHeight)+inset, buttonWidth, buttonHeight);
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        //第i个按钮的模型对象
        
        [button setTitle:self.sortArray[i] forState:UIControlStateNormal];
        //字体大小
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        //设置button的tag为循环变量
        button.tag = i;
        //添加button的action
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置button文本颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        //添加到view
        [self.view addSubview:button];
    }
    
    //设置弹出控制器显示的宽和高
    self.preferredContentSize = CGSizeMake(2*inset+buttonWidth, self.sortArray.count*(inset+buttonHeight)+inset);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)clickButton:(UIButton *)button {
    //选中哪个button(发送通知的参数:sort值)
    //button.tag ->
    NSString *str = self.sortArray[button.tag];
    //发送通知(参数:sort)
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChooseObject object:self userInfo:@{@"object":str}];
    //收回控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
