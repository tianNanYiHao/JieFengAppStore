//
//  RuiMViewController.m
//  QuickPos
//
//  Created by Lff on 16/11/8.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "RuiMViewController.h"
#import "RadioButton.h"
#import "RuiEWMViewController.h"

@interface RuiMViewController ()<ResponseData>
{
    UIImageView *_imageVIew;
    
    int buttonTag;//提现属性标记
    NSString *cashType;//提现类型
    Request *req;
    NSString *payTool;
    NSString *money;
}
@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (weak, nonatomic) IBOutlet RadioButton *btn1;
@property (weak, nonatomic) IBOutlet RadioButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *commit;

@end

@implementation RuiMViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _textfiled.text = @"";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self PromptTip];
    payTool = @"01";
    req = [[Request alloc]initWithDelegate:self];
    self.textfiled.layer.masksToBounds = YES;
    self.textfiled.layer.cornerRadius = 1;
    self.textfiled.layer.borderColor = [[UIColor greenColor] CGColor];
    _textfiled.keyboardType = UIKeyboardTypeNumberPad;
    _btn1.hidden = YES;
    _btn2.hidden = YES;
}

- (void)PromptTip
{
    NSString *tips = [[NSUserDefaults standardUserDefaults] objectForKey:_tipStr];
    UIView *tip = [Common tipWithStr:tips color:[UIColor redColor] rect:CGRectMake(0, CGRectGetMaxY(_commit.frame)+2, [UIApplication sharedApplication].keyWindow.width,40)];
    [self.view addSubview:tip];
}


- (IBAction)commitClick:(id)sender {
    
    int i = [_textfiled.text intValue];
    if (_textfiled.text.length == 0) {
        [Common showMsgBox:@"" msg:@"请输入收款金额" parentCtrl:self];
    }else if([_textfiled.text integerValue]<5 ){
        [Common showMsgBox:@"" msg:@"收款金额请勿小于5元" parentCtrl:self];
    }
    else  if ( (i %10) == 0){
        [Common showMsgBox:@"" msg:@"金额不能为整数" parentCtrl:self];
    }
    //    else if([_textfiledCash.text floatValue] - i == 0 ){
    //        [Common showMsgBox:@"" msg:@"收款金额不能为整数" parentCtrl:self];
    //    }
    else if([_textfiled.text length]>6){
        [Common showMsgBox:@"" msg:@"输入金额超限" parentCtrl:self];
    }
    else{
        if (i/10>=1) {
            if ([[_textfiled.text substringFromIndex:[_textfiled.text length]-1] isEqualToString:[[_textfiled.text substringFromIndex:[_textfiled.text length]-2] substringToIndex:1]]){
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
    //下单
    money = [NSString stringWithFormat:@"%.f",[_textfiled.text floatValue]*100];
    [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                  MerchanId:_merchantId
                  productId:_productId
                   orderAmt:money
                  orderDesc:_cardNum
                orderRemark:@""
               commodityIDs:@""
                    payTool:payTool
     ];
     [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"请稍后..."];
    
}
-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (type == REQUSET_ORDER) {
        if ([[dict objectForKey:@"respCode"] isEqualToString:@"0000"]) {
            RuiEWMViewController *ewm = [[RuiEWMViewController alloc] initWithNibName:@"RuiEWMViewController" bundle:nil];
            ewm.merID = _merchantId;
            ewm.proID = _productId;
            ewm.totalFee = money;
            ewm.orderNO = [dict objectForKey:@"orderId"];
            ewm.patWay = _payway;
            [self.navigationController pushViewController:ewm animated:YES];
        }else{
            [Common showMsgBox:nil msg:[dict objectForKey:@"respDesc"] parentCtrl:self];
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
