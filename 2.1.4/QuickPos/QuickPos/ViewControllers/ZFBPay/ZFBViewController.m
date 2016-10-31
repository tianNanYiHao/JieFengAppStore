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
#import "UMSocial.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WechatAuthSDK.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

@interface ZFBViewController ()<ResponseData>
{
//    UIImageView *_imageVIew;
    
    int buttonTag;//提现属性标记
    NSString *cashType;//提现类型
    
    Request *req;
    NSString *payTool;
    NSString *merchorder_No;
    UILongPressGestureRecognizer *singleTap;
    
}
@property (weak, nonatomic) IBOutlet UILabel *openShowLab1;//
@property (weak, nonatomic) IBOutlet UIImageView *ewmImageViw;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) NSString *urlString;
@property (nonatomic,strong) UIImageView *imageVIew;
@property (weak, nonatomic) IBOutlet UILabel *amtTitleLabel;//显示的金额
@property (nonatomic,strong) NSString *sign;
@property (nonatomic,strong) NSString *signNo;

@end

@implementation ZFBViewController
-(void)showOpenLab1{
    _openShowLab1.text = _openShowLab1Str;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self showOpenLab1];
    
    self.title = _titleName;
    _amtTitleLabel.text = [NSString stringWithFormat:@"%.2f",[_AmtNO floatValue]];
    req = [[Request alloc] initWithDelegate:self];
    payTool = @"01";
    //获取YST二维码
    [self getYSTewm];
    _ewmImageViw.image = [UIImage imageNamed:@"22"];
     [self yiqiande];
}
-(void)getYSTewm
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"二维码获取中..."];
    //银视通获取二维码
    [Common getYSTZFBimage:self.view money:_AmtNO requestDataBlock:^(id requestdate) {
        NSData *data = (NSData*)requestdate;
        NSMutableString *str = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", dict);
        NSString *retcode = [dict objectForKey:@"retcode"];
        if ([retcode isEqualToString:@"R9"]) {
            NSString* qrcode = [dict objectForKey:@"qrcode"];
            [Common erweima:qrcode imageView:_ewmImageViw];
            _ewmImageViw.hidden = YES;
            
            NSString *merchorder_no = [dict objectForKey:@"merchorder_no"];
            [Common alipayOrderStateSelect:merchorder_no key:_infoArr[2] merchantcode:_infoArr[0] controller:self];
            merchorder_No = merchorder_no;
            //下单
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self getOrder];
            });
        } else {
            NSString *result = [dict objectForKey:@"result"];
            [MyAlertView myAlertView:result];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } infoArr:_infoArr];
}


-(void)getOrder{
    //下单
        NSString *money = [NSString stringWithFormat:@"%.f",[_AmtNO floatValue]*100];
        [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                      MerchanId:_merchantId
                      productId:_productId
                       orderAmt:money
                      orderDesc:_cardNum
                    orderRemark:merchorder_No
                   commodityIDs:@""
                        payTool:payTool
         ];
}
-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (type == REQUSET_ORDER) {
        if ([[dict objectForKey:@"respCode"] isEqualToString:@"0000"]) {
            _ewmImageViw.hidden = NO;
            [self ImageViewAndTap];
        }else{
            [Common showMsgBox:nil msg:[dict objectForKey:@"respDesc"] parentCtrl:self];
        }
    }

}

//- (void)titleLabelAndInstructions
//{
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, 200, 21)];
//    titleLabel.text = @"收款金额(元)";
//    titleLabel.font = [UIFont systemFontOfSize:17 weight:17];
//    titleLabel.textColor = [UIColor lightGrayColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    
//    UILabel *amtTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 70, 200, 21)];
//    amtTitleLabel.text = [NSString stringWithFormat:@"%d%@",[self.AmtNO intValue]/100,@"￥"];
//    amtTitleLabel.font = [UIFont systemFontOfSize:17 weight:17];
//    amtTitleLabel.textColor = [UIColor lightGrayColor];
//    amtTitleLabel.textAlignment = NSTextAlignmentCenter;
//    
//    UILabel *instructionsLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(35,370, 250, 21)];
//    instructionsLabel1.text = @"请打开二维码扫123123一扫该二维码,交易状态请在交易记录中查看";
//    instructionsLabel1.textColor = [UIColor lightGrayColor];
//    instructionsLabel1.textAlignment = NSTextAlignmentLeft;
//    
////    UILabel *instructionsLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(35, 391, 250, 21)];
////    instructionsLabel2.text = @"交易状态请在交易记录中查看";
////    instructionsLabel2.textColor = [UIColor lightGrayColor];
////    instructionsLabel2.textAlignment = NSTextAlignmentLeft;
////    [self.view addSubview:instructionsLabel2];
//    [self.view addSubview:instructionsLabel1];
//    [self.view addSubview:amtTitleLabel];
//    [self.view addSubview:titleLabel];
//    
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
-(void)yiqiande{
    
    //    self.amtTitleLabel.text = [NSString stringWithFormat:@"%.2f%@",self.AmtNO.doubleValue/100,@"￥"];
    //    if (_payTway == 3) {
    //        NSString *url1 = @"http://122.144.198.81:8081/easypay/phone/alipay?orderId=";
    //        NSString *url2 = @"&orderAmt=";
    //        NSString *url3 = @"&sign=";
    //        self.signNo = @"bb0adb27090e";
    //        self.sign = [NSString stringWithFormat:@"%@%@%@",self.orderId,self.AmtNO,self.signNo];
    //        NSString *signStr = [Utils md5WithString:self.sign];
    //
    //        self.urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@",url1,self.orderId,url2,self.AmtNO,url3,signStr];
    //
    //
    //        _webView.delegate = self;
    //        _imageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 200)];
    //        [self.view addSubview:_imageVIew];
    //        _imageVIew.image = [LBXScanWrapper createQRWithString:self.urlString size:_imageVIew.bounds.size];
    //        [LBXScanWrapper addImageViewLogo:_imageVIew centerLogoImageView:nil logoSize:CGSizeZero];
    
    //    }
    //    else if (_payTway == 9){
    //        [req postCodeImageWihtorderID:_orderId orderAmT:_AmtNO];
    //        [MBProgressHUD showHUDAddedTo:self.view WithString:@"二维码获取中..."];
    //    }
}
//设置imageView长按手势分享二维码
- (void)ImageViewAndTap{
    _ewmImageViw.userInteractionEnabled = YES;
    singleTap=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(shareClickS:)];
    [self.ewmImageViw addGestureRecognizer:singleTap];
    //    [singleTap release];
    //长按手势
    singleTap.minimumPressDuration=1;
    //所需触摸1次
    singleTap.numberOfTouchesRequired=1;
}

//调整长按手势触发两次的问题
-(void)shareClickS:(UILongPressGestureRecognizer *)sender

{
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //1、创建分享参数
        NSArray* imageArray = @[self.ewmImageViw.image];
        
        if (imageArray) {
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                             images:imageArray
                                                url:[NSURL URLWithString:@"www.jiefengpay.com"]
                                              title:@"分享标题"
                                               type:SSDKContentTypeImage];
            //2,分享
            [ShareSDK showShareActionSheet:sender
                                     items:nil
                               shareParams:shareParams
                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                           
                           switch (state)
                           {
                               case SSDKResponseStateSuccess:
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                       message:nil
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                                   break;
                               }
                               case SSDKResponseStateFail:
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                       message:[NSString stringWithFormat:@"%@", error]
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                                   break;
                               }
                            break;
                           }
                       }];
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _ewmImageViw.userInteractionEnabled = NO;
    [_ewmImageViw removeGestureRecognizer:singleTap];
}
@end
