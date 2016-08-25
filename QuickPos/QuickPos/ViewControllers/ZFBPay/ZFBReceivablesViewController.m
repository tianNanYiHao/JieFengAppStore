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


@end

@implementation ZFBReceivablesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝收款";
    
    
    
    payTool = @"01";
    req = [[Request alloc]initWithDelegate:self];
    self.AmtTextField.layer.masksToBounds = YES;
    self.AmtTextField.layer.cornerRadius = 1;
    self.AmtTextField.layer.borderColor = [[UIColor greenColor] CGColor];
    
    [self.normalButton setOnImage:[UIImage imageNamed:@"xuanzeyuandian"] offImage:[UIImage imageNamed:@"yuandian"]];//设置图片
    
    
    [self.fastButton setOnImage:[UIImage imageNamed:@"xuanzeyuandian"] offImage:[UIImage imageNamed:@"yuandian"]];//设置图片
    
    buttonTag = 9;
    
    self.fastButton.on=YES;//默认快速提款
    merchantId = @"0001000007";
    productId = @"0000000000";
    if(self.fastButton.on){
        
        cashType = @"3";
    }
}


//确认按钮
- (IBAction)confirmButton:(id)sender {
    
    self.AmtNum = [NSString stringWithFormat:@"%d",[self.AmtTextField.text intValue]*100];
    NSLog(@"%@",self.AmtNum);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在生成二维码.."];
    [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                  MerchanId:merchantId
                  productId:productId
                   orderAmt:self.AmtNum
                  orderDesc:self.ZFBBankCardNum
                orderRemark:@""
               commodityIDs:@""
                    payTool:payTool
     ];
    
}

//T+0提现按钮
- (IBAction)fantButton:(id)sender {
    
    buttonTag = 3;
    
    
    if(buttonTag == 3){
        
        NSLog(@"开启");
        
        merchantId = @"0001000007";
        productId = @"0000000000";
        
        self.normalButton.on = NO;
        
        cashType = @"3";
        
        
    }else {
        
        NSLog(@"关闭");
    }
    
    
    
}


//T+1按钮
- (IBAction)normalButton:(id)sender {
    
    buttonTag = 9;
    
    if(buttonTag == 9){
        
        NSLog(@"开启");
        
        merchantId = @"0001000007";
        productId = @"0000000001";
        
        self.fastButton.on = NO;
        
        cashType = @"2";
        
        
    }else {
        
        NSLog(@"关闭");
    }
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
    if (type == REQUSET_ORDER) {
        self.orderId = [dict objectForKey:@"orderId"];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//        ZFBViewController *ZFBVc = [[ZFBViewController alloc]init];
        ZFBViewController *ZFBVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ZFBVc"];
        ZFBVc.orderId = self.orderId;
        ZFBVc.AmtNO = self.AmtNum;
        [self.navigationController pushViewController:ZFBVc animated:YES];
        
        NSLog(@"%@",self.orderId);
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
