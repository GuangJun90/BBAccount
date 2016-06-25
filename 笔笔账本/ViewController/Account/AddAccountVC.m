//
//  AddAccountVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/18.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AddAccountVC.h"
#import "AccountListViewModel.h"
#import "GoodsViewModel.h"
#import "ClientsViewModel.h"
#import "SuppliersViewModel.h"

#import "ChooseClientVC.h"
#import "ChooseGoodsVC.h"
#import "ChooseSuppliersVC.h"
#import "ChooseObjectVC.h"

#import "PopTransiton.h"

typedef NS_ENUM(NSUInteger, ChooseType){
    ChooseClients = 0,
    ChooseSuppliers
};
typedef NS_ENUM(NSUInteger, PriceType){
    PurchaseType = 0,//采购价
    RetailType,//零售价
    TradeType//批发价
};

@interface AddAccountVC ()<UIPopoverPresentationControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *incomeSeg;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIButton *changeTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *objectBtn;
@property (weak, nonatomic) IBOutlet UIButton *objectNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodsName;
@property (weak, nonatomic) IBOutlet UITextField *goodsNumTfd;
@property (weak, nonatomic) IBOutlet UITextField *totalPTfd;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UIView *changeTimeView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priceSeg;

/** 按钮点击事件 */
- (IBAction)incomeChange:(UISegmentedControl *)sender;
- (IBAction)timeChange:(id)sender;
- (IBAction)priceChange:(UISegmentedControl *)sender;
- (IBAction)complete:(id)sender;
- (IBAction)cancelBtnClicked:(id)sender;
- (IBAction)ensureBtnClicked:(id)sender;
- (IBAction)objectBtnClicked:(UIButton *)sender;
- (IBAction)objectNameBtnClicked:(UIButton *)sender;
- (IBAction)goodsBtnClicked:(UIButton *)sender;
- (IBAction)goodsNumChanged:(UITextField *)sender;


/** 收支 */
@property(nonatomic,assign) BOOL iscome;
/** goodsModel */
@property(nonatomic,strong) GoodsModel *goodsModel;
/** accountListVM */
@property(nonatomic,strong) AccountListViewModel *accountListVM;
/** clientVM */
@property(nonatomic,strong) ClientsViewModel *clientsVM;
/** suppliersVM */
@property(nonatomic,strong) SuppliersViewModel *suppliersVM;
/** goodsVM */
@property(nonatomic,strong) GoodsViewModel *goodsVM;

@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;

/** chooseClientVC */
@property(nonatomic,strong) ChooseClientVC *chooseClientsVC;
/** chooseSupplierVC */
@property(nonatomic,strong) ChooseSuppliersVC *chooseSuppliersVC;
/** chooseGoodsVC */
@property(nonatomic,strong) ChooseGoodsVC *chooseGoodsVC;
/** chooseObject */
@property(nonatomic,strong) ChooseObjectVC *chooseObjectVC;

///** 单价 */
//@property(nonatomic,assign) float oneP;
///** 采购价 */
//@property(nonatomic,assign) float purchase;
///** 零售价 */
//@property(nonatomic,assign) float retail;

/** chooseTYpe */
@property(nonatomic,assign) ChooseType chooseType;
/** PriceType */
@property(nonatomic,assign) PriceType priceType;
/** goods */
@property(nonatomic,strong) GoodsModel *goods;

/** 手势 */
@property(nonatomic,strong) UIScreenEdgePanGestureRecognizer *pan;
/** 动画相关 */
@property(nonatomic,strong) UIPercentDrivenInteractiveTransition *interaction;


@end

@implementation AddAccountVC
#pragma mark - ******** 懒加载 ********
-(AccountListViewModel *)accountListVM{
    if (!_accountListVM) {
        _accountListVM = [AccountListViewModel new];
    }
    return _accountListVM;
}
-(ClientsViewModel *)clientsVM{
    if (!_clientsVM) {
        _clientsVM = [ClientsViewModel new];
    }
    return _clientsVM;
}
-(SuppliersViewModel *)suppliersVM{
    if (!_suppliersVM) {
        _suppliersVM = [SuppliersViewModel new];
    }
    return _suppliersVM;
}
-(GoodsViewModel *)goodsVM{
    if (!_goodsVM) {
        _goodsVM = [GoodsViewModel new];
    }
    return _goodsVM;
}
-(ChooseClientVC *)chooseClientsVC{
    if (!_chooseClientsVC) {
        _chooseClientsVC = [ChooseClientVC new];
    }
    return _chooseClientsVC;
}
-(ChooseSuppliersVC *)chooseSuppliersVC{
    if (!_chooseSuppliersVC) {
        _chooseSuppliersVC = [ChooseSuppliersVC new];
    }
    return _chooseSuppliersVC;
}
-(ChooseGoodsVC *)chooseGoodsVC{
    if (!_chooseGoodsVC) {
        _chooseGoodsVC = [ChooseGoodsVC new];
    }
    return _chooseGoodsVC;
}
-(ChooseObjectVC *)chooseObjectVC{
    if (!_chooseObjectVC) {
        _chooseObjectVC = [ChooseObjectVC new];
    }
    return _chooseObjectVC;
}


#pragma mark - ******** 生命周期 ********
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:ViewBgColor];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"HH:mm";
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLbl.text = dateString;
    
    self.chooseType = ChooseClients;
    self.iscome = YES;
    self.priceType = self.priceSeg.selectedSegmentIndex;
    self.navigationItem.title = @"记一笔";
    [self listenNotifications];
    [self setKeyboard];
    [self transform];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.changeTimeView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc{
    self.returnKeyHandler = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationChooseObject object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationChooseClients object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationChooseSuppliers object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationChooseGoods object:nil];
    
}
#pragma mark - ******** 转角动画相关 ********
-(void)transform{
    self.navigationController.delegate = self;
    self.pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlEdgeScreenPanGesture:)];
    self.pan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.pan];
    
}
- (void)handlEdgeScreenPanGesture:(UIScreenEdgePanGestureRecognizer *)sender
{
//    NSLog(@"x position is %f",[sender translationInView:self.view].x);
    CGFloat progress = ([sender translationInView:self.view].x)/CGRectGetWidth(self.view.frame);
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            self.interaction = [[UIPercentDrivenInteractiveTransition alloc] init];
            // [self.navigationController pushViewController:@"xxx" animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark - ******** UINavigationControllerDelegate ********
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        return [[PopTransiton alloc] init];
    }
    return nil;
}
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    return self.interaction;
}

#pragma mark - ******** 按钮点击事件 ********
- (IBAction)incomeChange:(UISegmentedControl *)sender {
    self.iscome = !self.iscome;
    self.goodsName.enabled = YES;
    self.objectNameBtn.enabled = YES;
    if (self.iscome) {
        [self.objectBtn setTitle:@"客户" forState:UIControlStateNormal];
        self.chooseType = ChooseClients;
        self.objectNameBtn.enabled = YES;
        self.goodsName.enabled = YES;
        [self.objectNameBtn setTitle:@"客户名" forState:UIControlStateNormal];
        [self.goodsName setTitle:@"货物名" forState:UIControlStateNormal];
        
    }else{
        [self.objectBtn setTitle:@"供应商" forState:UIControlStateNormal];
        self.chooseType = ChooseSuppliers;
        self.objectNameBtn.enabled = YES;
        self.goodsName.enabled = YES;
        [self.objectNameBtn setTitle:@"供应商名" forState:UIControlStateNormal];
        [self.goodsName setTitle:@"货物名" forState:UIControlStateNormal];
    }
}

- (IBAction)timeChange:(id)sender {
    self.changeTimeView.hidden = NO;
    
}

- (IBAction)priceChange:(UISegmentedControl *)sender {
    self.priceType = sender.selectedSegmentIndex;
    switch (self.priceType) {
        case PurchaseType:
            self.totalPTfd.text = [NSString stringWithFormat:@"%.2f",self.goods.purchase * [self.goodsNumTfd.text floatValue]];
            break;
        case TradeType:
            self.totalPTfd.text = [NSString stringWithFormat:@"%.2f",self.goods.trade * [self.goodsNumTfd.text floatValue]];
            break;
        case RetailType:
            self.totalPTfd.text = [NSString stringWithFormat:@"%.2f",self.goods.retail * [self.goodsNumTfd.text floatValue]];
            break;
        default:
            break;
    }
    
}

- (IBAction)complete:(id)sender {
    if (self.totalPTfd.text.length == 0) {
        [self.view showWarning:@"金额不能为空"];
        return;
    }
    
    AccountListModel *model = [AccountListModel new];
    model.income = self.iscome;
    model.time = self.timeLbl.text;
    model.object = self.objectBtn.titleLabel.text;
    model.objectName =self.objectNameBtn.titleLabel.text;
    if (!self.goodsName.enabled) {
        model.goodsName = @"";
    }else{
       model.goodsName = self.goodsName.titleLabel.text;
    }
    model.goodsNum = [self.goodsNumTfd.text floatValue];
    model.totalP = [self.totalPTfd.text floatValue];
    model.timeID = [self handleTimeStr:self.timeLbl.text];
    
    [AccountListViewModel saveModelToSQLWith:model toDate:self.date];
    if (!self.goods) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (self.iscome) {
        self.goods.stock -= [self.goodsNumTfd.text floatValue];
    }else{
        self.goods.stock += [self.goodsNumTfd.text floatValue];
    }
    [GoodsViewModel changeModelToSQLWith:self.goods];
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)handleTimeStr:(NSString *)timeStr{
    NSString *resultStr = @"";
    NSArray *array = [timeStr componentsSeparatedByString:@":"];
    for (NSString *  str in array) {
        NSString *tempStr = str;
        if (str.length<4 && str.length == 1) {
            tempStr = [NSString stringWithFormat:@"0%@",str];
        }
        resultStr = [NSString stringWithFormat:@"%@%@",resultStr,tempStr];
    }
    
    return [resultStr integerValue];
}

- (IBAction)cancelBtnClicked:(id)sender {
    self.changeTimeView.hidden = YES;
}

- (IBAction)ensureBtnClicked:(id)sender {
    self.changeTimeView.hidden = YES;
    NSDate *date = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"HH:mm";
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLbl.text = dateString;
}

- (IBAction)objectBtnClicked:(UIButton *)sender {
    self.chooseObjectVC.modalPresentationStyle = UIModalPresentationPopover;
    self.chooseObjectVC.popoverPresentationController.sourceView = self.objectBtn;
    self.chooseObjectVC.popoverPresentationController.sourceRect = self.objectBtn.bounds;
    self.chooseObjectVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    self.chooseObjectVC.popoverPresentationController.delegate = self;
    [self presentViewController:self.chooseObjectVC animated:YES completion:nil];
    
}

- (IBAction)objectNameBtnClicked:(UIButton *)sender {
    if (self.chooseType == ChooseClients) {
        self.chooseClientsVC.modalPresentationStyle = UIModalPresentationPopover;
        self.chooseClientsVC.popoverPresentationController.sourceView = self.objectNameBtn;
        self.chooseClientsVC.popoverPresentationController.sourceRect = self.objectNameBtn.bounds;
        self.chooseClientsVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
        self.chooseClientsVC.popoverPresentationController.delegate = self;
        [self presentViewController:self.chooseClientsVC animated:YES completion:nil];
    }else{
        self.chooseSuppliersVC.modalPresentationStyle = UIModalPresentationPopover;
        self.chooseSuppliersVC.popoverPresentationController.sourceView = self.objectNameBtn;
        self.chooseSuppliersVC.popoverPresentationController.sourceRect = self.objectNameBtn.bounds;
        self.chooseSuppliersVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
        self.chooseSuppliersVC.popoverPresentationController.delegate = self;
        [self presentViewController:self.chooseSuppliersVC animated:YES completion:nil];
    }
}

- (IBAction)goodsBtnClicked:(UIButton *)sender {
    self.chooseGoodsVC.modalPresentationStyle = UIModalPresentationPopover;
    self.chooseGoodsVC.popoverPresentationController.sourceView = self.goodsName;
    self.chooseGoodsVC.popoverPresentationController.sourceRect = CGRectMake(self.goodsName.bounds.origin.x-50, self.goodsName.bounds.origin.y, self.goodsName.bounds.size.width+50, self.goodsName.bounds.size.height);
    self.chooseGoodsVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    self.chooseGoodsVC.popoverPresentationController.delegate = self;
    [self presentViewController:self.chooseGoodsVC animated:YES completion:nil];
}

- (IBAction)goodsNumChanged:(UITextField *)sender {
//    NSLog(@"%ld---%.2f---%.2f---%.2f",self.priceType,self.goods.purchase,self.goods.retail,self.goods.trade);
    switch (self.priceType) {
        case PurchaseType:
            self.totalPTfd.text = [NSString stringWithFormat:@"%.2f",self.goods.purchase * [sender.text floatValue]];
            break;
        case TradeType:
            self.totalPTfd.text = [NSString stringWithFormat:@"%.2f",self.goods.trade * [sender.text floatValue]];
            break;
        case RetailType:
            self.totalPTfd.text = [NSString stringWithFormat:@"%.2f",self.goods.retail * [sender.text floatValue]];
            break;
        default:
            break;
    }
    
}

#pragma mark - ******** NOtification ********
- (void)listenNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(objectDidChange:) name:NotificationChooseObject object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clientsDidChange:) name:NotificationChooseClients object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(suppliersDidChange:) name:NotificationChooseSuppliers object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goodsDidChange:) name:NotificationChooseGoods object:nil];
}
- (void)objectDidChange:(NSNotification *)notification{
    NSString *str = notification.userInfo[@"object"];
    [self.objectBtn setTitle:str forState:UIControlStateNormal];
    if ([str isEqualToString:@"客户"]) {
        self.chooseType = ChooseClients;
        self.objectNameBtn.enabled = YES;
        self.goodsName.enabled = YES;
        [self.objectNameBtn setTitle:@"客户名" forState:UIControlStateNormal];
        [self.goodsName setTitle:@"货物名" forState:UIControlStateNormal];
        self.incomeSeg.selectedSegmentIndex = 0;
        self.iscome = YES;
    }else if ([str isEqualToString:@"供应商"]){
        self.chooseType = ChooseSuppliers;
        self.objectNameBtn.enabled = YES;
        self.goodsName.enabled = YES;
        [self.objectNameBtn setTitle:@"供应商名" forState:UIControlStateNormal];
        [self.goodsName setTitle:@"货物名" forState:UIControlStateNormal];
        self.incomeSeg.selectedSegmentIndex = 1;
        self.iscome = NO;
    }else{
        self.objectNameBtn.enabled = NO;
        self.goodsName.enabled = NO;
        [self.objectNameBtn setTitle:@"" forState:UIControlStateNormal];
        [self.goodsName setTitle:@"" forState:UIControlStateNormal];
        self.goodsNumTfd.enabled = NO;
        self.priceSeg.enabled = NO;
        self.incomeSeg.selectedSegmentIndex = 1;
        self.iscome = NO;
    }
    
}
- (void)clientsDidChange:(NSNotification *)notification{
    ClientsModel *model = notification.userInfo[@"ClientsModel"];
    [self.objectNameBtn setTitle:model.name forState:UIControlStateNormal];
    
}
- (void)suppliersDidChange:(NSNotification *)notification{
    SuppliersModel *model = notification.userInfo[@"SuppliersModel"];
    [self.objectNameBtn setTitle:model.name forState:UIControlStateNormal];
}
- (void)goodsDidChange:(NSNotification *)notification{
    GoodsModel *model = notification.userInfo[@"GoodsModel"];
    self.goods = model;
    [self.goodsName setTitle:model.name forState:UIControlStateNormal];
    self.goodsNumTfd.enabled = YES;
    self.priceSeg.enabled = YES;
    if (self.iscome) {
        self.priceSeg.selectedSegmentIndex = 1;
        self.priceType = RetailType;
    }else{
        self.priceSeg.selectedSegmentIndex = 0;
        self.priceType = PurchaseType;
    }
    
}

#pragma mark - ******** 私有方法 ********
/** 设置键盘 */
-(void)setKeyboard{
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
}
- (IBAction)touchKeyboardDone:(id)sender {
    [self.view endEditing:YES];
}



#pragma mark - PopoverDelegate
//使得popoverController在iphone可以使用
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    // Return no adaptive presentation style, use default presentation behaviour
    return UIModalPresentationNone;
}
@end
