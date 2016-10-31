//
//  YSTWechatViewController.m
//  QuickPos
//
//  Created by Lff on 16/9/29.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "YSTWechatViewController.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import "XYSwitch.h"
#import "Request.h"
#import "ZFBViewController.h"
#import "MBProgressHUD+Add.h"
#import "Common.h"
#import "RadioButton.h"
#import "ZFBViewController.h"


@interface YSTWechatViewController ()<ResponseData>
{
    UIImageView *_imageVIew;
    
    int buttonTag;//提现属性标记
    NSString *cashType;//提现类型
    
    Request *req;
    NSString *payTool;
    
    NSString *merchantId;   //商户商家id
    NSString *productId;
}
@property (weak, nonatomic) IBOutlet RadioButton *btnTwo;
@property (weak, nonatomic) IBOutlet RadioButton *btnOne;
@property (weak, nonatomic) IBOutlet UITextField *textfiledCash;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation YSTWechatViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _textfiledCash.text = @"";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"微信收款";
    
    [self PromptTip];
    payTool = @"01";
    req = [[Request alloc]initWithDelegate:self];
    self.textfiledCash.layer.masksToBounds = YES;
    self.textfiledCash.layer.cornerRadius = 1;
    self.textfiledCash.layer.borderColor = [[UIColor greenColor] CGColor];
    _textfiledCash.keyboardType = UIKeyboardTypeNumberPad;
    _btnOne.groupButtons = @[_btnOne,_btnTwo];
    _btnOne.selected = YES;
    _btnOne.hidden = YES;
    _btnTwo.hidden = YES;
    merchantId = @"0001000006";
    productId = @"0000000002";

}
//tip
- (void)PromptTip
{
    NSString *tips = [[NSUserDefaults standardUserDefaults] objectForKey:@"YSTWX"];
    UIView *tip = [Common tipWithStr:tips color:[UIColor redColor] rect:CGRectMake(0, CGRectGetMaxY(_commitBtn.frame)+2, [UIApplication sharedApplication].keyWindow.width,40)];
    [self.view addSubview:tip];
}

//T+0 //T+1
//- (IBAction)chooseBtn:(RadioButton*)sender {
//    if (sender.tag == 11) {   //T+0
//        merchantId = @"0001000006";
//        productId = @"0000000002";
//    }
//    else if (sender.tag == 22){
//        merchantId = @"0001000006";
//        productId = @"0000000003";
//    }
//    
//}

- (IBAction)commitEwm:(id)sender {
    
    int i = [_textfiledCash.text intValue];
//    //iOS8的键盘适配
//    if ([_textfiledCash.text rangeOfString:@","].location == NSNotFound) {
//        NSLog(@"没找到,");
//    }else{
//        NSArray *arr = [_textfiledCash.text componentsSeparatedByString:@","];
//        if (arr.count == 2) {
//            _textfiledCash.text = [NSString stringWithFormat:@"%@.%@",arr[0],arr[1]];
//        }else{
//            [Common showMsgBox:@"" msg:@"收款金额不能为整数" parentCtrl:self];
//        }
//    }
    if (_textfiledCash.text.length == 0) {
        [Common showMsgBox:@"" msg:@"请输入收款金额" parentCtrl:self];
    }else if([_textfiledCash.text integerValue]<5 ){
        [Common showMsgBox:@"" msg:@"收款金额请勿小于5元" parentCtrl:self];
    }
    else  if ( (i %10) == 0){
        [Common showMsgBox:@"" msg:@"金额不能为整数" parentCtrl:self];
    }
//    else if([_textfiledCash.text floatValue] - i == 0 ){
//        [Common showMsgBox:@"" msg:@"收款金额不能为整数" parentCtrl:self];
//    }
    else if([_textfiledCash.text length]>6){
        [Common showMsgBox:@"" msg:@"输入金额超限" parentCtrl:self];
    }
    else{
        if (i/10>=1) {
            if ([[_textfiledCash.text substringFromIndex:[_textfiledCash.text length]-1] isEqualToString:[[_textfiledCash.text substringFromIndex:[_textfiledCash.text length]-2] substringToIndex:1]]){
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
    
    _textfiledCash.text = [NSString stringWithFormat:@"%.2f",[_textfiledCash.text floatValue]];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ZFBViewController *WechatVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ZFBVc"];
    WechatVc.AmtNO = _textfiledCash.text;
    WechatVc.cardNum = self.WeChatBankCardNum;
    WechatVc.merchantId = merchantId;
    WechatVc.productId = productId;
    WechatVc.titleName = @"微信收款二维码";
    WechatVc.openShowLab1Str = @"请打开微信扫一扫该二维码，完成交易";
    WechatVc.infoArr = @[WXMERCHANTCODE,WXBACKURL,WXKEY,@"上海捷丰网络科技有限公司"];
    [self.navigationController pushViewController:WechatVc animated:YES];

    
}
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
