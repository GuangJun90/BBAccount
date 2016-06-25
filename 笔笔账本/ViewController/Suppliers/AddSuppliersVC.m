//
//  AddSuppliersVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/16.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AddSuppliersVC.h"
#import "SuppliersModel.h"
#import "SuppliersViewModel.h"
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>

@interface AddSuppliersVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *txlBtn;



- (IBAction)changeImg:(id)sender;
- (IBAction)addBtnClicked:(id)sender;
- (IBAction)openTongXunLu:(id)sender;

@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;

@end

@implementation AddSuppliersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.navigationItem.title = @"新建供应商";
    [self.img setRoundLayer];
    self.addButton.layer.masksToBounds = YES;
    self.addButton.layer.cornerRadius = 3;
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 9.0) {
        self.txlBtn.hidden = NO;
    }
    [self setKeyboard];
}
-(void)dealloc{
    self.returnKeyHandler = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - button的点击事件
- (IBAction)changeImg:(id)sender {
    [self headImageTap];
}

- (IBAction)addBtnClicked:(id)sender {
    SuppliersModel *clients = [SuppliersModel new];
    clients.name = self.name.text;
    clients.address = self.address.text;
    clients.phone = self.phoneNum.text;
    NSData *imgdata;
    if (UIImagePNGRepresentation(self.img.image)) {
        imgdata = UIImageJPEGRepresentation(self.img.image, 0.3);
    }else{
        imgdata = UIImagePNGRepresentation(self.img.image);
    }
    clients.Img = imgdata;
    [SuppliersViewModel saveModelToSQLWith:clients];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)openTongXunLu:(id)sender {
    ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
    nav.peoplePickerDelegate = self;
    nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
    [self presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark - ******** ABPeoplePickerNavigationControllerDelegate ********
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

// Called after a person has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
}

// Called after a property has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    
    if ([phoneNO hasPrefix:@"+"]) {
        phoneNO = [phoneNO substringFromIndex:3];
    }
    
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.phoneNum.text = phoneNO;
}



#pragma mark - ******** 私有方法 ********
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
    self.img.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setKeyboard{
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
}
@end
