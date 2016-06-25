//
//  AddNewGoods.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/4.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AddNewGoods.h"
#import "GoodsModel.h"
#import "GoodsViewModel.h"

@interface AddNewGoods ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UITextField *goodsNameTfd;
@property (weak, nonatomic) IBOutlet UITextField *goodsIDTfd;
@property (weak, nonatomic) IBOutlet UITextField *purchasePTfd;
@property (weak, nonatomic) IBOutlet UITextField *retailPTfd;
@property (weak, nonatomic) IBOutlet UITextField *tradePTfd;
@property (weak, nonatomic) IBOutlet UITextField *stockTfd;
@property (weak, nonatomic) IBOutlet UILabel *goodsCategoryLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsBrandLbl;
@property (weak, nonatomic) IBOutlet UISwitch *goodsWarningSwt;
@property (weak, nonatomic) IBOutlet UITextField *upperLimitTfd;
@property (weak, nonatomic) IBOutlet UITextField *lowLimitTfd;


/** button点击事件 */
- (IBAction)retunToGoodVc:(id)sender;
- (IBAction)saveGoods:(id)sender;
- (IBAction)changeImg:(UIButton *)sender;

@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;

@end

@implementation AddNewGoods

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCategoryMessage:) name:@"PostGoodsCategoryName" object:nil];
    [self.goodsImg setRoundLayer];
    [self setKeyboard];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PostGoodsCategoryName" object:nil];
    self.returnKeyHandler = nil;
}

#pragma mark - 方法
-(void)receiveCategoryMessage:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    self.goodsCategoryLbl.text = dict[@"category"];
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - button的点击事件
- (IBAction)retunToGoodVc:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)saveGoods:(id)sender {
    GoodsModel *good = [GoodsModel new];
    good.name = self.goodsNameTfd.text;
    good.ID = self.goodsIDTfd.text.floatValue;
    NSData *imgdata;
    if (UIImagePNGRepresentation(self.goodsImg.image)) {
        imgdata = UIImageJPEGRepresentation(self.goodsImg.image, 0.3);
    }else{
        imgdata = UIImagePNGRepresentation(self.goodsImg.image);
    }
    good.Img = imgdata;
    good.purchase = self.purchasePTfd.text.floatValue;
    good.retail = self.retailPTfd.text.floatValue;
    good.trade = self.tradePTfd.text.floatValue;
    good.stock = self.stockTfd.text.floatValue;
    good.warning = self.goodsWarningSwt.on;
    good.upperLimit = self.upperLimitTfd.text.floatValue;
    good.lowLimit = self.lowLimitTfd.text.floatValue;
    good.category = self.goodsCategoryLbl.text;
    
    [GoodsViewModel saveModelToSQLWith:good];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeImg:(UIButton *)sender {
    [self headImageTap];
}
- (void) headImageTap{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
}
/** 选择图片的处理 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.goodsImg.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setKeyboard{
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
}

@end
