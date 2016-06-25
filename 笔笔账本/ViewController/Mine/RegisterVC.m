//
//  RegisterVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/24.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "RegisterVC.h"
#import "CheckTool.h"
#import <SMS_SDK/SMSSDK.h>
#import "EMSDK.h"



static const NSInteger Count = 60;
static NSString *const CodeBtnEnabledColor = @"#138AC9";
static NSString *const CodeBtnNotEnabledColor = @"#89C4E4";

@interface RegisterVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *registerTableView;

@property (nonatomic,strong) UIButton *codeBtn;
@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *codeTf;
//@property (nonatomic,strong) UITextField *nameTf;
@property (nonatomic,strong) UITextField *pwdTf;
@property (nonatomic,strong) UIButton *eyePwdBtn;
@property (nonatomic,strong) UIView *tableFooterView;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger tCount;

@end

@implementation RegisterVC


#pragma mark - life cycle
- (void)dealloc {
    DLog(@"%@ dealloc",self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"新用户注册";
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self endMyTimer];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 15.f;
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            self.phoneTf.frame = CGRectMake(15, 7, kScreenWidth-15, 30);
            [cell.contentView addSubview:self.phoneTf];
        }
        else {
            self.codeTf.frame = CGRectMake(15, 7, kScreenWidth - 145, 30);
            self.codeBtn.frame = CGRectMake(self.codeTf.frame.origin.x + self.codeTf.frame.size.width, 0, 130, 44);
            [cell.contentView addSubview:self.codeTf];
            [cell.contentView addSubview:self.codeBtn];
        }
        
    }else {
//        if(indexPath.row == 0) {
//            self.nameTf.frame = CGRectMake(15, 7, kScreenWidth - 15, 30);
//            [cell.contentView addSubview:self.nameTf];
//        }
//        else {
        
//        }
        self.pwdTf.frame = CGRectMake(15, 7, kScreenWidth - 59, 30);
        self.eyePwdBtn.frame = CGRectMake(kScreenWidth - 44.f, 0, 44.f, 44.f);
        [cell.contentView addSubview:self.pwdTf];
        [cell.contentView addSubview:self.eyePwdBtn];
    }
    return cell;
}
#pragma mark - ******** 私有方法 ********

- (void)initView{
    self.phoneTf = [[UITextField alloc] init];
    self.phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTf.font = [UIFont systemFontOfSize:15.0];
    self.phoneTf.placeholder = @"请输入手机号码";
    self.phoneTf.delegate = self;
    self.phoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTf.textAlignment = NSTextAlignmentLeft;
    
    self.codeTf = [[UITextField alloc] init];
    self.codeTf.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTf.font = [UIFont systemFontOfSize:15.0];
    self.codeTf.placeholder = @"请输入验证码";
    self.codeTf.delegate = self;
    self.codeTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTf.textAlignment = NSTextAlignmentLeft;
    
    self.pwdTf = [[UITextField alloc] init];
    self.pwdTf.font = [UIFont systemFontOfSize:15.0];
    self.pwdTf.placeholder = @"请设置6-15位密码";
    self.pwdTf.delegate = self;
    self.pwdTf.secureTextEntry = YES;
    self.pwdTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdTf.textAlignment = NSTextAlignmentLeft;
    
    self.codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.codeBtn addTarget:self action:@selector(verifyCode:) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.codeBtn.backgroundColor = [UIColor colorWithHexString:CodeBtnEnabledColor];
    
    self.eyePwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.eyePwdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.eyePwdBtn addTarget:self action:@selector(eyePwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.eyePwdBtn setImage:[UIImage imageNamed:@"ic_invisible"] forState:UIControlStateNormal];
    [self.eyePwdBtn setImage:[UIImage imageNamed:@"ic_visible"] forState:UIControlStateSelected];
    self.eyePwdBtn.contentEdgeInsets = UIEdgeInsetsMake(13, 10, 14, 9);
    self.eyePwdBtn.selected = NO;
    
    [self.phoneTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    [self.nameTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.registerTableView.sectionFooterHeight = 0.f;
    self.registerTableView.tableFooterView = self.tableFooterView;
    
    
}
/** 短信验证 */
- (void)verifyCode:(UIButton *)btn{
    __weak typeof(self) weakSelf = self;
    RegisterError error = [self attributeCheck:RegCheckTypePhone];
    if (error == RegisterErrorNone) {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTf.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                [weakSelf setMyTimer];
                [self.view showWarning:@"短信已发送至你手机，请注意查收"];
            } else {
                [self.view showWarning:[NSString stringWithFormat:@"错误信息：%@",error]];
            }
        }];
    }else{
        [self dealError:error];
    }
    
}
/** 密码可见和不可见 */
- (void)eyePwd:(id)sender
{
    if (![self.pwdTf.text isNotBlank]) {
        return;
    }
    
    _pwdTf.secureTextEntry = self.eyePwdBtn.selected;
    self.eyePwdBtn.selected = !self.eyePwdBtn.selected;
}
/** textfield */
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneTf) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    else if (textField == self.codeTf) {
        
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    else if (textField == self.pwdTf) {
        if (textField.text.length > 15) {
            textField.text = [textField.text substringToIndex:15];
        }
    }
}
/** 检测textfield */
- (RegisterError)attributeCheck:(RegCheckType)checkType
{
    RegisterError registerError = RegisterErrorNone;
    
    if (checkType == RegCheckTypePhone) {
        if (![self.phoneTf.text isNotBlank]) {
            registerError = RegisterErrorPhoneEmpty;
        }else if (![CheckTool checkTelNumber:self.phoneTf.text]) {
            registerError = RegisterErrorPhoneFormat;
        }
    }else {
        if (![self.phoneTf.text isNotBlank]) {
            registerError = RegisterErrorPhoneEmpty;
        }else if (![CheckTool checkTelNumber:self.phoneTf.text]) {
            registerError = RegisterErrorPhoneFormat;
        }else if (![self.codeTf.text isNotBlank]) {
            registerError = RegisterErrorCodeEmpty;
        }else if (![self.pwdTf.text isNotBlank]) {
            registerError = RegisterErrorPwdEmpty;
        }else if (self.pwdTf.text.length < 6 || self.pwdTf.text.length > 15) {
            registerError = RegisterErrorPwdLength;
        }
    }
    return registerError;
}
/** 显示错误 */
- (void)dealError:(RegisterError)error
{
    switch (error) {
        case RegisterErrorPhoneEmpty:
            [self.view showWarning:@"手机号不能为空"];
            break;
        case RegisterErrorPhoneFormat:
            [self.view showWarning:@"手机号格式错误"];
            break;
        case RegisterErrorCodeEmpty:
            [self.view showWarning:@"验证码不能为空"];
            break;
        case RegisterErrorPwdEmpty:
            [self.view showWarning:@"密码不能为空"];
            break;
        case RegisterErrorPwdLength:
            [self.view showWarning:@"密码长度不对"];
            break;
        default:
            break;
    }
}
/** 发送短信验证按钮的状态 */
- (void)changeVerfyBtnEnabled:(BOOL)enabled
{
    if (!enabled) {
        self.codeBtn.enabled = NO;
        self.codeBtn.backgroundColor = [UIColor colorWithHexString:CodeBtnNotEnabledColor];
    }
    else {
        self.codeBtn.enabled = YES;
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.backgroundColor = [UIColor colorWithHexString:CodeBtnEnabledColor];
    }
}

- (void)setMyTimer
{
    _tCount = Count;
    [self changeVerfyBtnEnabled:NO];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    }
    [_timer fire];
    
}
- (void)endMyTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)timerFired:(NSTimer *)timer
{
    if (_tCount != 1) {
        _tCount -= 1;
        [_codeBtn setTitle:[NSString stringWithFormat:@"%ld秒重新发送",(long)_tCount] forState:UIControlStateNormal];
    }
    else
    {
        [self endMyTimer];
        [self changeVerfyBtnEnabled:YES];
    }
}

#pragma mark - getters and setters
- (UIView *)tableFooterView
{
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64.f)];
        _tableFooterView.backgroundColor = [UIColor clearColor];
        
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(15, 20, kScreenWidth - 30.f, 44.f);
        [registerBtn setBackgroundColor:[UIColor colorWithHexString:CodeBtnEnabledColor]];
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
        registerBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        registerBtn.layer.cornerRadius = 5.f;
        registerBtn.layer.masksToBounds = YES;
        
        [_tableFooterView addSubview:registerBtn];
        
    }
    return _tableFooterView;
}

/** 注册 */
- (void)registerUser{
    RegisterError error = [self attributeCheck:RegCheckTypeAll];
    if (error == RegisterErrorNone) {
        //短信验证
        [SMSSDK commitVerificationCode:self.codeTf.text phoneNumber:self.phoneTf.text zone:@"86" result:^(NSError *error) {
            if (error) {
                [self.view showWarning:@"短信验证错误"];
                return ;
            }
        }];
        //注册
        EMError *error = [[EMClient sharedClient] registerWithUsername:self.phoneTf.text password:self.pwdTf.text];
        if (error == nil) {
            if (self.phoneNumBlock != nil) {
                self.phoneNumBlock(self.phoneTf.text);
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self.view showWarning:[NSString stringWithFormat:@"%@",error]];
        }
    }else{
        [self dealError:error];
    }
}

-(void)returnPhoneNum:(returnPhoneNum)block{
    self.phoneNumBlock = block;
}

@end
