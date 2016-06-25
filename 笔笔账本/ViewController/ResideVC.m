//
//  ResideVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/23.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "ResideVC.h"
#import "AccountViewController.h"
#import "CountChartVC.h"
#import <RESideMenu.h>
#import "GoodsVIewController.h"
#import "ClentsViewController.h"
#import "SuppliersViewController.h"
#import "LoginVC.h"

@interface ResideVC ()
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

- (IBAction)goToAccount:(id)sender;
- (IBAction)goToClients:(id)sender;
- (IBAction)goToSuppliers:(id)sender;
- (IBAction)goToCountChart:(id)sender;
- (IBAction)goToGoods:(id)sender;
- (IBAction)exit:(id)sender;



@end

@implementation ResideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameLbl.text = My_PhoneNum;
    [self.userHeaderIcon setRoundLayer];
    self.view.backgroundColor = [UIColor colorWithHexString:NavBarColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)goToAccount:(id)sender {
    AccountViewController *accountVC = [[AccountViewController alloc]initWithNibName:@"AccountViewController" bundle:[NSBundle mainBundle]];
    ResideVC *resideVC = [[ResideVC alloc]initWithNibName:@"ResideVC" bundle:[NSBundle mainBundle]];
    
    RESideMenu *sideVC = [[RESideMenu alloc] initWithContentViewController:[[UINavigationController alloc]initWithRootViewController:accountVC] leftMenuViewController:resideVC rightMenuViewController:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = sideVC;
    
}

- (IBAction)goToClients:(id)sender {
    ClentsViewController *vc = [[UIStoryboard storyboardWithName:@"Clients" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ClentsViewController"];
    ResideVC *resideVC = [[ResideVC alloc]initWithNibName:@"ResideVC" bundle:[NSBundle mainBundle]];
    RESideMenu *sideVC = [[RESideMenu alloc] initWithContentViewController:[[UINavigationController alloc]initWithRootViewController:vc] leftMenuViewController:resideVC rightMenuViewController:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = sideVC;
}

- (IBAction)goToSuppliers:(id)sender {
    SuppliersViewController *vc = [[UIStoryboard storyboardWithName:@"Suppliers" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SuppliersViewController"];
    ResideVC *resideVC = [[ResideVC alloc]initWithNibName:@"ResideVC" bundle:[NSBundle mainBundle]];
    RESideMenu *sideVC = [[RESideMenu alloc] initWithContentViewController:[[UINavigationController alloc]initWithRootViewController:vc] leftMenuViewController:resideVC rightMenuViewController:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = sideVC;
}

- (IBAction)goToCountChart:(id)sender {
    CountChartVC *vc = [CountChartVC new];
    ResideVC *resideVC = [[ResideVC alloc]initWithNibName:@"ResideVC" bundle:[NSBundle mainBundle]];
    
    RESideMenu *sideVC = [[RESideMenu alloc] initWithContentViewController:[[UINavigationController alloc]initWithRootViewController:vc] leftMenuViewController:resideVC rightMenuViewController:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = sideVC;
}

- (IBAction)goToGoods:(id)sender {
    GoodsVIewController *vc = [[UIStoryboard storyboardWithName:@"Goods" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"GoodsVIewController"];
    ResideVC *resideVC = [[ResideVC alloc]initWithNibName:@"ResideVC" bundle:[NSBundle mainBundle]];
    RESideMenu *sideVC = [[RESideMenu alloc] initWithContentViewController:[[UINavigationController alloc]initWithRootViewController:vc] leftMenuViewController:resideVC rightMenuViewController:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = sideVC;
    
}

- (IBAction)exit:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPhoneNumKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    LoginVC *vc = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:[NSBundle mainBundle]];
    [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
}
@end
