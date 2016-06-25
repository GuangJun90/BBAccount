//
//  AccountViewController.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/19.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AccountViewController.h"
#import "NSString+QHNSStringCtg.h"

#import "ChooseDateVC.h"
#import "AddAccountVC.h"

#import "AccountCell.h"
#import <RESideMenu.h>

#import "AccountListViewModel.h"
#import "AccountDailyViewModel.h"
#import "TimeArray.h"

#import "PushTransition.h"
#import "PushTransitionTest.h"

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)

@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

/** 键盘相关 */
@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;
/** 手势 */
@property(nonatomic,strong) UIScreenEdgePanGestureRecognizer *pan;
/** 动画相关 */
@property(nonatomic,strong) UIPercentDrivenInteractiveTransition *interaction;


/** date标题 */
@property(nonatomic,strong) NSString *dateTitleStr;
/** date */
@property(nonatomic,strong) NSString *dateStr;



/** AccountList数组 */
@property(nonatomic,strong) NSArray<AccountListModel *> *accountListArr;
/** accountListVM */
@property(nonatomic,strong) AccountListViewModel *accountListVM;
/** accountDaily */
@property(nonatomic,strong) AccountDailyModel *accountDailyModel;
/** AccountDailyVM */
@property(nonatomic,strong) AccountDailyViewModel *accountDailyVM;

/** 收入 */
@property(nonatomic,assign) float incomeP;
/** 支出 */
@property(nonatomic,assign) float pay;
/** 水费 */
@property(nonatomic,assign) float waterP;
/** 电费 */
@property(nonatomic,assign) float eleP;
/** 采购费 */
@property(nonatomic,assign) float goodsInP;
/** 房租 */
@property(nonatomic,assign) float rentP;
/** 其他费用 */
@property(nonatomic,assign) float otherP;


/** 有daily数据 */
@property(nonatomic,assign,getter=ishaveData) BOOL haveData;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITextField *capitalTfd;
@property (weak, nonatomic) IBOutlet UITextField *grossIncomeTfd;
@property (weak, nonatomic) IBOutlet UILabel *incomeLbl;

@property (weak, nonatomic) IBOutlet UILabel *outlayLbl;

@property (weak, nonatomic) IBOutlet UIButton *settleBtn;

- (IBAction)settleBtnClick:(id)sender;

@end

@implementation AccountViewController
#pragma mark - ******** 懒加载 ********
-(AccountListViewModel *)accountListVM{
    if (!_accountListVM) {
        _accountListVM = [AccountListViewModel new];
    }
    return _accountListVM;
}
-(AccountDailyViewModel *)accountDailyVM{
    if (!_accountDailyVM) {
        _accountDailyVM = [AccountDailyViewModel new];
    }
    return _accountDailyVM;
}



#pragma mark - ******** 生命周期 ********
- (void)viewDidLoad {
    [super viewDidLoad];
    self.haveData = NO;
    self.isOpen = NO;
    
    //今天
    NSString *timeStr = [NSString dateFromeString:[NSDate date]];
    self.dateStr = [self handleDateStr:timeStr];
    
    self.headerView.backgroundColor = [UIColor colorWithHexString:NavBarColor];
    self.tableView.backgroundColor = [UIColor colorWithHexString:ViewBgColor];
    self.settleBtn.layer.masksToBounds = YES;
    self.settleBtn.layer.cornerRadius = 8;
    [self setTableView];
    [self addBarItems];
    [self setKeyboard];
    [self transform];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavTitleView];
    [self loadDate];
    self.menuLabel.text = self.dateTitleStr==nil? @"今日账单" : self.dateTitleStr;
    
    self.navigationController.delegate = self;
    // 假如你得动画总时长是5秒钟，那么当你的手指从640 -》 0这个过程的时候
    // 每移动一个pixel的位置，你的动画就执行了5.0/640秒的时间
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
-(void)dealloc{
    self.returnKeyHandler = nil;
}

#pragma mark - ******** 私有方法 ********
-(void)loadDate{
    self.accountListArr = [self.accountListVM getAccountListArrayWith:self.dateStr];
    [self.tableView reloadData];
    self.incomeP = 0;
    self.pay = 0;
    self.waterP = 0;
    self.eleP = 0;
    self.goodsInP = 0;
    self.rentP = 0;
    self.otherP = 0;
    
    for (AccountListModel *model in self.accountListArr) {
        if (model.income) {
            self.incomeP += model.totalP;
            
        }else{
            self.pay += model.totalP;
            if ([model.object isEqualToString:@"水费"]) {
                self.waterP += model.totalP;
            }else if ([model.object isEqualToString:@"电费"]){
                self.eleP += model.totalP;
            }else if ([model.object isEqualToString:@"房租费"]){
                self.rentP += model.totalP;
            }else if ([model.object isEqualToString:@"其他"]){
                self.otherP += model.totalP;
            }else if ([model.object isEqualToString:@"供应商"]){
                self.goodsInP += model.totalP;
            }
        }
    }
    self.haveData = NO;
    self.capitalTfd.text = @"500";
    self.grossIncomeTfd.text = @"";
    self.accountDailyModel = nil;
    self.incomeLbl.text = [NSString stringWithFormat:@"%.2f元",self.incomeP];
    self.outlayLbl.text = [NSString stringWithFormat:@"%.2f元",self.pay];
    NSArray<AccountDailyModel *> *array = [self.accountDailyVM getAccountDailyModelArrayFrom:self.dateStr To:self.dateStr];
    if (array.count != 0) {
        AccountDailyModel *model = array[0];
        self.accountDailyModel = model;
        self.capitalTfd.text = [NSString stringWithFormat:@"%.1f",model.capitalP];
        self.grossIncomeTfd.text = [NSString stringWithFormat:@"%.1f",model.grossIncomeP];
        self.haveData = YES;
    }
    
}
/** 动画、手势相关 */
- (void)transform{
    self.pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlEdgeScreenPanGesture:)];
    self.pan.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:self.pan];
    
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = -1/2000.0;
//    self.view.layer.transform = transform;
}
- (void)handlEdgeScreenPanGesture:(UIScreenEdgePanGestureRecognizer *)sender
{
//    NSLog(@"x position is %f",[sender translationInView:self.view].x);
    CGFloat progress = (-1 * [sender translationInView:self.view].x)/CGRectGetWidth(self.view.frame);
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            self.interaction = [[UIPercentDrivenInteractiveTransition alloc] init];
            
//            [self performSegueWithIdentifier:@"kPushToSecond" sender:nil];
            
            [self clickAddAccountButton:nil];
            break;
        case UIGestureRecognizerStateChanged:
            [self.interaction updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (progress >= 0.5) {
                [self.interaction finishInteractiveTransition];
            }else {
                [self.interaction cancelInteractiveTransition];
                //[self.navigationController popViewControllerAnimated:YES];
            }
            self.interaction = nil;
        }
        default:
            break;
    }
}
/** 设置tableView */
- (void)setTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
/** 添加navigationBarItems */
- (void)addBarItems {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_home_home_pro"] style:UIBarButtonItemStylePlain target:self action:@selector(menu)];
    //由于左边的item离屏幕左边缘太远,所以加以调整
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = 15;
//    self.navigationItem.leftBarButtonItems = @[spaceItem, backItem];
    self.navigationItem.leftBarButtonItem = backItem;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"记一笔" style:UIBarButtonItemStyleDone target:self action:@selector(clickAddAccountButton:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)menu {
    [self.sideMenuViewController presentLeftMenuViewController];
}

-(void)clickAddAccountButton:(UIBarButtonItem *)item{
    AddAccountVC *vc = [[AddAccountVC alloc]initWithNibName:@"AddAccountVC" bundle:[NSBundle mainBundle]];
    vc.date = self.dateStr;
    self.title =@"返回";
    [self.navigationController pushViewController:vc animated:YES];
    
}
/** 设置initNavTitleView */
- (void)initNavTitleView{
    CGFloat navTitleViewWidth = 200.f;
    CGFloat margin = 15.f;
    CGFloat itemSpace = 5.f;
    CGFloat imageWidth = 18.f;
    CGFloat navHeight = 44.f;
    
    if (!self.navTitleView) {
        self.navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, navTitleViewWidth, 44.f)];
        self.navTitleView.backgroundColor = [UIColor clearColor];
        self.navigationItem.titleView = self.navTitleView;
        
        self.listMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.listMenuBtn.backgroundColor = [UIColor clearColor];
        [self.listMenuBtn addTarget:self action:@selector(showListMenu:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.navTitleView addSubview:self.listMenuBtn];
        
        self.menuLabel = [[UILabel alloc] init];
        self.menuLabel.font = [UIFont systemFontOfSize:16.0];
        self.menuLabel.textAlignment = NSTextAlignmentCenter;
        self.menuLabel.textColor = [UIColor whiteColor];
        
        
        [self.listMenuBtn addSubview:self.menuLabel];
        
        self.arrowImageView = [[UIImageView alloc] init];
        self.arrowImageView.image = [UIImage imageNamed:@"ic_down_arrow_white"];
        [self.listMenuBtn addSubview:self.arrowImageView];
    }
    self.menuLabel.text = self.dateTitleStr==nil? @"今日账单" : self.dateTitleStr;
    //    menuLabel.text = self.selectCampModel.campName ? self.selectCampModel.campName : self.navigationItem.title;
    CGSize campTitleSize = [self.menuLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0]}];
//    NSLog(@"---%f,----%f",campTitleSize.width,campTitleSize.height);
    if (campTitleSize.width > navTitleViewWidth - margin * 2 - itemSpace - imageWidth) {
        campTitleSize.width = navTitleViewWidth - margin * 2 - itemSpace - imageWidth;
    }
    CGFloat menuBtnWidth = margin * 2 + ceilf(campTitleSize.width) + itemSpace + imageWidth;
    
    self.listMenuBtn.frame = CGRectMake((navTitleViewWidth - menuBtnWidth)/2, 0, menuBtnWidth, navHeight);
    self.menuLabel.frame = CGRectMake(margin, (navHeight - ceil(campTitleSize.height)) / 2, ceil(campTitleSize.width), ceil(campTitleSize.height));
    self.arrowImageView.frame = CGRectMake(menuBtnWidth - margin - imageWidth, 17.f, imageWidth, 10.f);
}

- (void)showListMenu:(UIButton *)btn{
    self.isOpen = !self.isOpen;
    //change net
    if (!self.isOpen) {
        //        [UIView animateWithDuration:0.3f animations:^{
        //
        //            self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
        //        } completion:^(BOOL finished) {
        //            self.isOpen = NO;
        //        }];
    }else {
        [self showChooseDateVC];
        //        [UIView animateWithDuration:0.3f animations:^{
        //            self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
        //        } completion:^(BOOL finished) {
        //            self.isOpen = YES;
        //        }];
    }
    
}

- (void)showChooseDateVC {
    ChooseDateVC *choose = [ChooseDateVC new];
    __weak __typeof(self)weakSelf = self;
    [choose setChangedate:^(NSDictionary *dicDate) {
        self.dateTitleStr = [dicDate objectForKey:@"backTitle"];
        self.dateStr = [weakSelf handleDateStr:[weakSelf handleTimeStr:[dicDate objectForKey:@"startTime"]]];;
        [weakSelf loadDate];
        
    }];

    [self.navigationController pushViewController:choose animated:YES];
    
}
- (NSString *)handleDateStr:(NSString *)timeStr{
    NSString *resultStr = @"";
    NSArray *array = [timeStr componentsSeparatedByString:@"-"];
    for (NSString *  str in array) {
        NSString *tempStr = str;
        if (str.length<4 && str.length == 1) {
            tempStr = [NSString stringWithFormat:@"0%@",str];
        }
        resultStr = [NSString stringWithFormat:@"%@%@",resultStr,tempStr];
    }
    
    //    resultStr = [resultStr substringFromIndex:1];
    return resultStr;
}

- (NSString *)handleTimeStr:(NSString *)timeStr{
    NSString *resultStr = @"";
    NSArray *array = [timeStr componentsSeparatedByString:@"-"];
    for (NSString *  str in array) {
        NSString *tempStr = str;
        if (str.length<4 && str.length == 1) {
            tempStr = [NSString stringWithFormat:@"0%@",str];
        }
        resultStr = [NSString stringWithFormat:@"%@-%@",resultStr,tempStr];
    }
    
    resultStr = [resultStr substringFromIndex:1];
    return resultStr;
}
/** 设置键盘 */
-(void)setKeyboard{
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
}

#pragma mark - ******** tableViewDelegate ********
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.accountListArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountListModel * model = self.accountListArr[indexPath.row];
    AccountCell * cell = [AccountCell theAccountCellWith:model];
    cell.accountModel = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}



#pragma mark - ******** button点击事件 ********
- (IBAction)settleBtnClick:(id)sender {
    if ((self.grossIncomeTfd.text.length == 0) || (self.capitalTfd.text.length == 0)) {
        [self.view showWarning:@"本金和毛收入不能为空"];
        return;
    }
    
    AccountDailyModel *model = [AccountDailyModel new];
    model.date = [self.dateStr integerValue];
    model.capitalP = [self.capitalTfd.text floatValue];
    model.grossIncomeP = [self.grossIncomeTfd.text floatValue];
    model.turnover = model.grossIncomeP - model.capitalP + self.pay;
    model.waterP = self.waterP;
    model.eleP = self.eleP;
    model.goodsInP = self.goodsInP;
    model.rentP = self.rentP;
    model.otherP = self.otherP;
    if (self.haveData) {
        [AccountDailyViewModel changeModelToSQLWith:model];
    }else{
       [AccountDailyViewModel saveModelToSQLWith:model];
        self.haveData = YES;
    }
    [self.view showWarning:@"结算成功"];
    
}

#pragma mark - ******** UINavigationControllerDelegate ********
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation) operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[PushTransitionTest alloc] init];
    }
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    return self.interaction;
}


@end
