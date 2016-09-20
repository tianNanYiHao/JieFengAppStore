//
//  ZFBViewController.m
//  QuickPos
//
//  Created by Lff on 16/8/8.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ZFBViewController.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import "XYSwitch.h"
#import "UIImageView+CornerRadius.h"
#import "Request.h"


@interface ZFBViewController ()<UIWebViewDelegate,ResponseData>
{
//    UIImageView *_imageVIew;
    
    int buttonTag;//提现属性标记
    NSString *cashType;//提现类型
    
    Request *req;
    NSString *payTool;
    
    NSString *merchantId;   //商户商家id
    NSString *productId;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,strong) NSString *urlString;

@property (nonatomic,strong) UIImageView *imageVIew;
@property (weak, nonatomic) IBOutlet UILabel *amtTitleLabel;//显示的金额

@property (nonatomic,strong) NSString *sign;
@property (nonatomic,strong) NSString *signNo;

@end

@implementation ZFBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"支付宝收款";

//postCodeImageWihtorderID:(NSString*)orderId orderAmT:(NSString*)orderAmt
    
    req = [[Request alloc] initWithDelegate:self];

    
    self.amtTitleLabel.text = [NSString stringWithFormat:@"%.2f%@",self.AmtNO.doubleValue/100,@"￥"];
    
//    if (_payTway == 3) {
        NSString *url1 = @"http://122.144.198.81:8081/easypay/phone/alipay?orderId=";
        NSString *url2 = @"&orderAmt=";
        NSString *url3 = @"&sign=";
        self.signNo = @"bb0adb27090e";
        self.sign = [NSString stringWithFormat:@"%@%@%@",self.orderId,self.AmtNO,self.signNo];
        NSString *signStr = [Utils md5WithString:self.sign];
        
        self.urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@",url1,self.orderId,url2,self.AmtNO,url3,signStr];
        
        
        _webView.delegate = self;
        
        _imageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 200)];
        [self.view addSubview:_imageVIew];
        _imageVIew.image = [LBXScanWrapper createQRWithString:self.urlString size:_imageVIew.bounds.size];
        [LBXScanWrapper addImageViewLogo:_imageVIew centerLogoImageView:nil logoSize:CGSizeZero];

//    }
//    else if (_payTway == 9){
//        [req postCodeImageWihtorderID:_orderId orderAmT:_AmtNO];
//        [MBProgressHUD showHUDAddedTo:self.view WithString:@"二维码获取中..."];
//    }
}

-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (type == REQUSET_WftAliPay) {
        _imageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 200)];
        [self.view addSubview:_imageVIew];
        _imageVIew.image = [LBXScanWrapper createQRWithString:@"123" size:_imageVIew.bounds.size];
        [LBXScanWrapper addImageViewLogo:_imageVIew centerLogoImageView:nil logoSize:CGSizeZero];
    }
    
 

    
}

- (void)titleLabelAndInstructions
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, 200, 21)];
    titleLabel.text = @"收款金额(元)";
    titleLabel.font = [UIFont systemFontOfSize:17 weight:17];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *amtTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 70, 200, 21)];
    amtTitleLabel.text = [NSString stringWithFormat:@"%d%@",[self.AmtNO intValue]/100,@"￥"];
    amtTitleLabel.font = [UIFont systemFontOfSize:17 weight:17];
    amtTitleLabel.textColor = [UIColor lightGrayColor];
    amtTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *instructionsLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(35,370, 250, 21)];
    instructionsLabel1.text = @"请打开二维码扫一扫该二维码,交易状态请在交易记录中查看";
    instructionsLabel1.textColor = [UIColor lightGrayColor];
    instructionsLabel1.textAlignment = NSTextAlignmentLeft;
    
//    UILabel *instructionsLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(35, 391, 250, 21)];
//    instructionsLabel2.text = @"交易状态请在交易记录中查看";
//    instructionsLabel2.textColor = [UIColor lightGrayColor];
//    instructionsLabel2.textAlignment = NSTextAlignmentLeft;
//    
//    
//    [self.view addSubview:instructionsLabel2];
    [self.view addSubview:instructionsLabel1];
    [self.view addSubview:amtTitleLabel];
    [self.view addSubview:titleLabel];
    
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
