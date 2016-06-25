//
//  AppDelegate.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/3.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+System.h"


#import <RESideMenu.h>
#import "AccountViewController.h"
#import "ResideVC.h"

#import <SMS_SDK/SMSSDK.h>
#import "EMSDK.h"

#import "LoginVC.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:kScreenBounds];
    [SMSSDK registerApp:MOBAPPKEY withSecret:MOBAPPSECRET];
    
    EMOptions *options = [EMOptions optionsWithAppkey:HXAPPKEY];
    options.apnsCertName = HXapnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    if (My_PhoneNum == nil) {
        LoginVC *vc = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:[NSBundle mainBundle]];
        self.window =[[UIWindow alloc]init];
        self.window.rootViewController= [[UINavigationController alloc] initWithRootViewController:vc];
        [self.window makeKeyAndVisible];
    }else{
        AccountViewController *accountVC = [[AccountViewController alloc]initWithNibName:@"AccountViewController" bundle:[NSBundle mainBundle]];
        ResideVC *resideVC = [[ResideVC alloc]initWithNibName:@"ResideVC" bundle:[NSBundle mainBundle]];
        
        RESideMenu *sideVC = [[RESideMenu alloc] initWithContentViewController:[[UINavigationController alloc]initWithRootViewController:accountVC] leftMenuViewController:resideVC rightMenuViewController:nil];
        sideVC.contentViewShadowRadius = 20;
        sideVC.contentViewShadowEnabled = YES;
        self.window.rootViewController = sideVC;
        self.window.backgroundColor = [UIColor clearColor];
        [self.window makeKeyAndVisible];
    } 
    
    [self setupGlobalConfig];
    return YES;
}



@end
