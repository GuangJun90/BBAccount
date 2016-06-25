//
//  LXActivity.m
//  LXActivityDemo
//
//  Created by eluying02 on 15/12/18.
//  Copyright © 2015年 eluying02. All rights reserved.
//

#import "LXActivity.h"



#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:106/255.00f green:106/255.00f blue:106/255.00f alpha:0.8]
#define ANIMATE_DURATION                        0.25f

#define CORNER_RADIUS                           5
#define SHAREBUTTON_BORDER_WIDTH                0.5f
#define SHAREBUTTON_BORDER_COLOR                [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor
#define SHAREBUTTONTITLE_FONT                   [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]

#define CANCEL_BUTTON_COLOR                     [UIColor colorWithRed:53/255.00f green:53/255.00f blue:53/255.00f alpha:1]

#define SHAREBUTTON_WIDTH                       50
#define SHAREBUTTON_HEIGHT                      50
#define SHAREBUTTON_INTERVAL_WIDTH              42.5
#define SHAREBUTTON_INTERVAL_HEIGHT             35

#define SHARETITLE_WIDTH                        50
#define SHARETITLE_HEIGHT                       20
#define SHARETITLE_INTERVAL_WIDTH               42.5
#define SHARETITLE_INTERVAL_HEIGHT              SHAREBUTTON_WIDTH+SHAREBUTTON_INTERVAL_HEIGHT
#define SHARETITLE_FONT                         [UIFont fontWithName:@"Helvetica-Bold" size:14]

#define TITLE_INTERVAL_HEIGHT                   15
#define TITLE_HEIGHT                            35
#define TITLE_INTERVAL_WIDTH                    30
#define TITLE_WIDTH                             260
#define TITLE_FONT                              [UIFont fontWithName:@"Helvetica-Bold" size:10]
#define SHADOW_OFFSET                           CGSizeMake(0, 0.8f)
#define TITLE_NUMBER_LINES                      2

#define BUTTON_INTERVAL_HEIGHT                  20
#define BUTTON_HEIGHT                           40
#define BUTTON_INTERVAL_WIDTH                   40
#define BUTTON_WIDTH                            240
#define BUTTONTITLE_FONT                        [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]
#define BUTTON_BORDER_WIDTH                     0.5f
#define BUTTON_BORDER_COLOR                     [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor


#define kMainScreenW    [UIScreen mainScreen].bounds.size.width

#define kDurW   (kMainScreenW-35*2-55*3)/2


@interface UIImage (custom)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end


@implementation UIImage (custom)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
    
   
    
}

//---导航栏-去掉分割线(换分割线颜色)
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    
    
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
}

@end

@interface LXActivity ()

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) NSString *actionTitle;
@property (nonatomic,assign) NSInteger postionIndexNumber;
@property (nonatomic,assign) BOOL isHadTitle;
@property (nonatomic,assign) BOOL isHadShareButton;
@property (nonatomic,assign) BOOL isHadCancelButton;
@property (nonatomic,assign) CGFloat LXActivityHeight;
@property (nonatomic,assign) id<LXActivityDelegate>delegate;

@end

@implementation LXActivity

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

#pragma mark - Public method

- (id)initWithTitle:(NSString *)title phoneNum:(NSString *)phoneNum delegate:(id<LXActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray heightIamgeArray:(NSArray *)heihtArray
{
    self = [super init];
    if (self) {
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (delegate) {
            self.delegate = delegate;
        }
        
        [self creatButtonsWithTitle:title phoneNum:phoneNum cancelButtonTitle:cancelButtonTitle shareButtonTitles:shareButtonTitlesArray withShareButtonImagesName:shareButtonImagesNameArray heightIamgeArray:heihtArray];
        
    }
    return self;
}

- (void)showInView:(UIView *)view
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

#pragma mark - Praviate method

- (void)creatButtonsWithTitle:(NSString *)title phoneNum:(NSString *)phoneNum cancelButtonTitle:(NSString *)cancelButtonTitle shareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray heightIamgeArray:(NSArray *)heihtArray
{
    //初始化
    self.isHadTitle = NO;
    self.isHadShareButton = NO;
    self.isHadCancelButton = NO;
    
    //初始化LXACtionView的高度为0
    self.LXActivityHeight = 0;
    
    //初始化IndexNumber为0;
    self.postionIndexNumber = 0;
    
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backGroundView.backgroundColor = [UIColor whiteColor];
    
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backGroundView];
    
    if (title) {
        self.isHadTitle = YES;
        UILabel *titleLabel = [self creatTitleLabelWith:title];
        //titleLabel.backgroundColor = [UIColor blueColor];
        self.LXActivityHeight = self.LXActivityHeight + 2*TITLE_INTERVAL_HEIGHT;
        [self.backGroundView addSubview:titleLabel];
    }
    
    if (phoneNum) {
        self.isHadTitle = YES;
     
        UILabel *phoneLabel = [self creatPhoneLabel:phoneNum];
        
       // phoneLabel.backgroundColor = [UIColor orangeColor];
        
        [self.backGroundView addSubview:phoneLabel];
        
        
    }
    
    UIButton *debtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    debtn.frame = CGRectMake(15, 10, 25, 25);
    //debtn.backgroundColor = [UIColor orangeColor];
    [debtn setImage:[UIImage imageNamed:@"ic_close"] forState:(UIControlStateNormal)];
    [debtn addTarget:self action:@selector(deqBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.backGroundView addSubview:debtn];
    
    
    if (shareButtonImagesNameArray) {
        if (shareButtonImagesNameArray.count > 0) {
            self.isHadShareButton = YES;
            for (int i = 1; i < shareButtonImagesNameArray.count+1; i++) {
                //计算出行数，与列数
//                int column = (int)ceil((float)(i)/3); //行
//                int line = (i)%3; //列
//                if (line == 0) {
//                    line = 3;
//                }
                UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
                
                shareButton.frame =  CGRectMake(35.f+(55+kDurW)*(i-1),55.f, 55.f, 55.f);
                
                //shareButton.backgroundColor = [UIColor greenColor];

                shareButton.tag = self.postionIndexNumber;
                [shareButton addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
            
           
                [shareButton setBackgroundImage:[UIImage imageNamed:[shareButtonImagesNameArray objectAtIndex:i-1]] forState:UIControlStateNormal];
                [shareButton setBackgroundImage:[UIImage imageNamed:[heihtArray objectAtIndex:i-1]] forState:UIControlStateHighlighted];

                

                //有Title的时候
                if (self.isHadTitle == YES) {
                    [shareButton setFrame:CGRectMake(35+(kDurW+55)*(i-1), 65, 55, 55)];
                }
//                else{
//                    [shareButton setFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH+((line-1)*(SHAREBUTTON_INTERVAL_WIDTH+SHAREBUTTON_WIDTH)), SHAREBUTTON_INTERVAL_HEIGHT+((column-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
//                }
                [self.backGroundView addSubview:shareButton];
                
                self.postionIndexNumber++;
            }
        }
    }
    
    if (shareButtonTitlesArray) {
        if (shareButtonTitlesArray.count > 0 && shareButtonImagesNameArray.count > 0) {
            for (int j = 1; j < shareButtonTitlesArray.count+1; j++) {
//                //计算出行数，与列数
//                int column = (int)ceil((float)(j)/3); //行
//                int line = (j)%3; //列
//                if (line == 0) {
//                    line = 3;
//                }
                UILabel *shareLabel =   [[UILabel alloc] initWithFrame:CGRectMake(35+(kDurW+55)*(j-1),128.f, 60.f, 20.f)];
                //shareLabel.textAlignment = NSTextAlignmentLeft;
                shareLabel.font = [UIFont systemFontOfSize:13];
                shareLabel.textColor = [UIColor colorWithHexString:@"808080"];
                shareLabel.text = [shareButtonTitlesArray objectAtIndex:j-1];
                //有Title的时候
                if (self.isHadTitle == YES) {
                    [shareLabel setFrame:CGRectMake(35+(kDurW+55)*(j-1),128.f, 60.f, 20.f)];
                }
                [self.backGroundView addSubview:shareLabel];
            }
        }
    }
    
    //再次计算加入shareButtons后LXActivity的高度
    if (shareButtonImagesNameArray && shareButtonImagesNameArray.count > 0) {
        int totalColumns = (int)ceil((float)(shareButtonImagesNameArray.count)/3);
        if (self.isHadTitle  == YES) {
            self.LXActivityHeight = self.LXActivityHeight + totalColumns*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT);
        }
        else{
            self.LXActivityHeight = SHAREBUTTON_INTERVAL_HEIGHT + totalColumns*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT);
        }
    }
    
    if (cancelButtonTitle) {
        self.isHadCancelButton = YES;
        UIButton *cancelButton = [self creatCancelButtonWith:cancelButtonTitle];
        cancelButton.tag = self.postionIndexNumber;
        [cancelButton addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        //当没title destructionButton otherbuttons时
        if (self.isHadTitle == NO && self.isHadShareButton == NO) {
            self.LXActivityHeight = self.LXActivityHeight + cancelButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
        }
        //当有title或destructionButton或otherbuttons时
        if (self.isHadTitle == YES || self.isHadShareButton == YES) {
            [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, self.LXActivityHeight, cancelButton.frame.size.width, cancelButton.frame.size.height)];
            self.LXActivityHeight = self.LXActivityHeight + cancelButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
        }
        //[self.backGroundView addSubview:cancelButton];
        
        self.postionIndexNumber++;
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.LXActivityHeight, [UIScreen mainScreen].bounds.size.width, self.LXActivityHeight)];
    } completion:^(BOOL finished) {
    }];
}


- (UIButton *)creatCancelButtonWith:(NSString *)cancelButtonTitle
{
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = CORNER_RADIUS;
    
    cancelButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    cancelButton.layer.borderColor = BUTTON_BORDER_COLOR;

    UIImage *image = [UIImage imageWithColor:CANCEL_BUTTON_COLOR];
    [cancelButton setBackgroundImage:image forState:UIControlStateNormal];

    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = BUTTONTITLE_FONT;
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    return cancelButton;
}

//- (UIButton *)creatShareButtonWithColumn:(int)column andLine:(int)line
//{
//    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(35.f+(line-1)*kDurW,55.f, 55.f, 55.f)];
//    
//    shareButton.backgroundColor = [UIColor greenColor];
//    return shareButton;
//}

- (UILabel *)creatShareLabelWithColumn:(int)column andLine:(int)line
{
    UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(35.f+((line-1)*(SHARETITLE_INTERVAL_WIDTH+SHARETITLE_WIDTH)), SHARETITLE_INTERVAL_HEIGHT+((column-1)*(SHARETITLE_INTERVAL_HEIGHT)), SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
    
    shareLabel.backgroundColor = [UIColor clearColor];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:13];
    shareLabel.textColor = [UIColor whiteColor];
    
    shareLabel.backgroundColor = [UIColor redColor];    return shareLabel;
}

- (UILabel *)creatTitleLabelWith:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 8, kScreenWidth-100, TITLE_HEIGHT-15)];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    //titlelabel.shadowColor = [UIColor blackColor];
    //titlelabel.shadowOffset = SHADOW_OFFSET;
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.text = title;
    titlelabel.textColor = [UIColor colorWithHexString:@"404040"];
    //titlelabel.numberOfLines = TITLE_NUMBER_LINES;
    return titlelabel;
}

- (UILabel *)creatPhoneLabel:(NSString *)phoneNum
{

    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,30, kScreenWidth-100, TITLE_HEIGHT-15)];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    //phoneLabel.shadowColor = [UIColor blackColor];
   // phoneLabel.shadowOffset = SHADOW_OFFSET;
    phoneLabel.font = [UIFont systemFontOfSize:14];
    phoneLabel.text = phoneNum;
    phoneLabel.textColor = [UIColor colorWithHexString:NomalBlueTextFontColor];
   // phoneLabel.numberOfLines = TITLE_NUMBER_LINES;
    return phoneLabel;









}

- (void)didClickOnImageIndex:(UIButton *)button
{
    if (self.delegate) {
        if (button.tag != self.postionIndexNumber-1) {
            if ([self.delegate respondsToSelector:@selector(didClickOnImageIndex:)] == YES) {
                [self.delegate didClickOnImageIndex:(NSInteger )button.tag];
            }
        }
        else{
            if ([self.delegate respondsToSelector:@selector(didClickOnCancelButton)] == YES){
                [self.delegate didClickOnCancelButton];
            }
        }
    }
    [self tappedCancel];
}


- (void)deqBtnAction
{



    [self tappedCancel];



}

- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)tappedBackGroundView
{
    //
    
}

@end
