//
//  LoginVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/24.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "LoginVC.h"

#import "EMSDK.h"

#import "RegisterVC.h"

#import "AccountViewController.h"
#import "CountChartVC.h"
#import "ResideVC.h"
#import <RESideMenu.h>

#import "CheckTool.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)login:(UIButton *)sender;
- (IBAction)newRegister:(id)sender;


@end

@implementation LoginVC

#pragma mark - ******** 生命周期 ********
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (void)dealloc {
    DLog(@"%@ dealloc",self.class);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - ******** 按钮点击事件 ********
- (IBAction)login:(UIButton *)sender {
    if (![self.phoneTextField.text isNotBlank]) {
        [self.view showWarning:@"手机号不能为空"];
        return;
    }
    if (![CheckTool checkTelNumber:self.phoneTextField.text]) {
        [self.view showWarning:@"手机号格式错误"];
        return;
    }
    if (![self.pwdTextField.text isNotBlank]) {
        [self.view showWarning:@"密码不能为空"];
        return;
    }
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.phoneTextField.text password:self.pwdTextField.text];
    if (error) {
        [self.view showWarning:[NSString stringWithFormat:@"%@",error]];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneTextField.text forKey:kPhoneNumKey];
    
    
    AccountViewController *accountVC = [[AccountViewController alloc]initWithNibName:@"AccountViewController" bundle:[NSBundle mainBundle]];
    ResideVC *resideVC = [[ResideVC alloc]initWithNibName:@"ResideVC" bundle:[NSBundle mainBundle]];
    
    RESideMenu *sideVC = [[RESideMenu alloc] initWithContentViewController:[[UINavigationController alloc]initWithRootViewController:accountVC] leftMenuViewController:resideVC rightMenuViewController:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = sideVC;
}

- (IBAction)newRegister:(id)sender {
    RegisterVC *vc = [[RegisterVC alloc]initWithNibName:@"RegisterVC" bundle:[NSBundle mainBundle]];
    self.title = @"登录";
    [vc returnPhoneNum:^(NSString *phoneNum) {
        self.phoneTextField.text = phoneNum;
    }];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
