//
//  ZFBReceivablesViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/8/16.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ZFBReceivablesViewController.h"
#import "ZFBViewController.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import "XYSwitch.h"
#import "Request.h"
#import "ZFBViewController.h"
#import "MBProgressHUD+Add.h"
#import "Common.h"

@interface ZFBReceivablesViewController ()<ResponseData>
{
    UIImageView *_imageVIew;
    
    int buttonTag;//提现属性标记
    NSString *cashType;//提现类型
    
    Request *req;
    NSString *payTool;
    
    NSString *merchantId;   //商户商家id
    NSString *productId;
}

@property (weak, nonatomic) IBOutlet UITextField *AmtTextField;//金额输入框

@property (weak, nonatomic) IBOutlet XYSwitch *normalButton;//T+1按钮

@property (weak, nonatomic) IBOutlet XYSwitch *fastButton;//T+0按钮

@property (nonatomic,strong) NSString *AmtNum;

@property (nonatomic,strong) NSString *orderId;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *comfirt;

@end

@implementation ZFBReceivablesViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _AmtTextField.text = @"";
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝收款";
    [self PromptTip];
    payTool = @"01";
    req = [[Request alloc]initWithDelegate:self];
    self.AmtTextField.layer.masksToBounds = YES;
    self.AmtTextField.layer.cornerRadius = 1;
    self.AmtTextField.layer.borderColor = [[UIColor greenColor] CGColor];
    merchantId = @"0001000007";
    productId = @"0000000003";
     _AmtTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    
//    [self.normalButton setOnImage:[UIImage imageNamed:@"xuanzeyuandian"] offImage:[UIImage imageNamed:@"yuandian"]];//设置图片
//    [self.fastButton setOnImage:[UIImage imageNamed:@"xuanzeyuandian"] offImage:[UIImage imageNamed:@"yuandian"]];//设置图片
//    buttonTag = 3;
//    self.fastButton.on=YES;//默认快速提款
//    merchantId = @"0001000007";
//    productId = @"0000000000";
//    if(self.fastButton.on){
//        cashType = @"3";
//    }
    
    
}

//tip
- (void)PromptTip
{
    UIView *tip = [Common tipWithStr:@"手续费=千分之五+2元" color:[UIColor redColor] rect:CGRectMake(0, CGRectGetMaxY(_comfirt.frame)+270, self.view.frame.size.width, 40)];
    [self.view addSubview:tip];
//    UIView *tip1 = [Common tipWithStr:@"T+1 手续费=收款金额*0.0055" color:[UIColor redColor] rect:CGRectMake(0, CGRectGetMaxY(_comfirt.frame)+300, self.view.frame.size.width, 40)];
//    [self.view addSubview:tip1];

}

//确认按钮
- (IBAction)confirmButton:(id)sender {
    
    int i = [_AmtTextField.text intValue];
//    //iOS8的键盘适配
//    if ([_AmtTextField.text rangeOfString:@","].location == NSNotFound) {
//   
//    }else{
//        NSArray *arr = [_AmtTextField.text componentsSeparatedByString:@","];
//        if (arr.count == 2) {
//            _AmtTextField.text = [NSString stringWithFormat:@"%@.%@",arr[0],arr[1]];
//        }else{
//            [Common showMsgBox:@"" msg:@"收款金额不能为整数" parentCtrl:self];
//        }
//    }
    
    if (_AmtTextField.text.length == 0) {
        [Common showMsgBox:@"" msg:@"请输入收款金额" parentCtrl:self];
    }else if([_AmtTextField.text integerValue]<5 ){
        [Common showMsgBox:@"" msg:@"收款金额请勿小于5元" parentCtrl:self];
    }else if([_AmtTextField.text integerValue]>=10000 ){
        [Common showMsgBox:@"" msg:@"收款金额请勿大于一万元" parentCtrl:self];
    }
    else  if ( (i %10) == 0){
        [Common showMsgBox:@"" msg:@"金额不能为整数" parentCtrl:self];
    }
//    else if([_AmtTextField.text floatValue] - i == 0 ){
//        [Common showMsgBox:@"" msg:@"收款金额不能为整数" parentCtrl:self];
//    }
    else if([_AmtTextField.text length]>6){
        [Common showMsgBox:@"" msg:@"输入金额超限" parentCtrl:self];
    }
    else{
        if (i/10>1) {
            if ([[_AmtTextField.text substringFromIndex:[_AmtTextField.text length]-1] isEqualToString:[[_AmtTextField.text substringFromIndex:[_AmtTextField.text length]-2] substringToIndex:1]]){
                [Common showMsgBox:nil msg:@"金额最后两位不能相同" parentCtrl:self];
            }else{
                [self pay];
            }
        }
        else{
            [self pay];
        }
       }
    
}

-(void)pay{
    _AmtTextField.text = [NSString stringWithFormat:@"%.2f",[_AmtTextField.text floatValue]];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZFBViewController *ZFBVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ZFBVc"];
    ZFBVc.AmtNO = _AmtTextField.text;
    ZFBVc.cardNum = self.ZFBBankCardNum;
    ZFBVc.merchantId = merchantId;
    ZFBVc.productId = productId;
    ZFBVc.titleName = @"支付宝收款二维码";
    
    LFFStringarr *lff = [[LFFStringarr alloc]init];
    LFFJieFengCompenyInfo *mode =   [lff getJieFengCompenyInfoModel];
    NSString *ii = [[NSUserDefaults standardUserDefaults] objectForKey:@"ii"];
    NSInteger  iii = [ii integerValue];
    ZFBVc.infoArr = @[mode.arrJFNO[iii],ZFBBACKURL,mode.arrJFKey[iii],mode.arrJFName[iii]];
    iii = iii+1;
    if (iii == mode.arrJFName.count) {
        iii = 0;
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%li",(long)iii] forKey:@"ii"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)iii] forKey:@"ii"];
    }
    [self.navigationController pushViewController:ZFBVc animated:YES];

}

////T+0提现按钮
//- (IBAction)fantButton:(id)sender {
//
//    buttonTag = 3;
//
//    
//    if(buttonTag == 3){
//        
//        NSLog(@"开启");
//        
//        merchantId = @"0001000007";
//        productId = @"0000000000";
//        
//        self.normalButton.on = NO;
//        
//        cashType = @"3";
//        
//        
//    }else {
//        
//        NSLog(@"关闭");
//    }
//    
//    
//    
//}


////T+1按钮  (威富通通道)
//- (IBAction)normalButton:(id)sender {
//    
//    buttonTag = 9;
//    
//    if(buttonTag == 9){
//        
//        NSLog(@"开启");
//        
//        merchantId = @"0001000007";
//        productId = @"0000000001";
//        
//        self.fastButton.on = NO;
//        cashType = @"2";
////        [Common showMsgBox:nil msg:@"暂未开放" parentCtrl:self];
//        
//    }else {
//        
//        NSLog(@"关闭");
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
