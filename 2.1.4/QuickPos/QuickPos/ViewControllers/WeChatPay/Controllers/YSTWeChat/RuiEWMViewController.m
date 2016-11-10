//
//  RuiEWMViewController.m
//  QuickPos
//
//  Created by Lff on 16/11/8.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "RuiEWMViewController.h"
#import "Utils.h"
#import "MBProgressHUD+Add.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WechatAuthSDK.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
@interface RuiEWMViewController ()<UIWebViewDelegate>
{
    UIWebView *webVIew;
    MBProgressHUD *hud;
    UILongPressGestureRecognizer *singleTap;
    UIButton *rightBtn;
    
}
@property (weak, nonatomic) IBOutlet UILabel *tipTwo;
@property (weak, nonatomic) IBOutlet UILabel *tipOne;
@property (weak, nonatomic) IBOutlet UIImageView *iamgeView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@end

@implementation RuiEWMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createWebview];
}
- (void)createWebview{

    
    NSString *sign = [NSString stringWithFormat:@"merchantId=%@&orderNo=%@&productId=%@&totalFee=%@4e5846d9235247ca93d498212b413b52",_merID,_orderNO,_proID,_totalFee];
     sign = [Utils md5WithString:sign];
    NSString *url = [NSString stringWithFormat:@"http://122.144.198.81:8081/easypay/ruimo/pay?merchantId=%@&orderNo=%@&productId=%@&totalFee=%@&sign=%@",_merID,_orderNO,_proID,_totalFee,sign];
    
    if ([_patWay isEqualToString:@"请打开支付宝扫一扫该二维码，完成交易"]) {
        [RuiEWMViewController erweima:url imageView:_iamgeView];
         [self ImageViewAndTap:_iamgeView];
    }else if ([_patWay isEqualToString:@"请打开微信扫一扫该二维码，完成交易"]){
        if (!hud) {
            hud = [MBProgressHUD showMessag:L(@"Loading") toView:self.view];
        }
        webVIew = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [webVIew loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        webVIew.delegate = self;
        [self.view addSubview:webVIew];
        UIView *cv = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:cv];
        [self ImageViewAndTap:cv];
    }
    _moneyLab.text =[NSString stringWithFormat:@"%.2f",_totalFee.floatValue/100] ;
    _tipOne.text = _patWay;
    _tipTwo.text = @"长按二维码或点击右上角进行分享";
   
    [self sharePicture];
    
    
}



//分享二维码按钮
- (void)sharePicture{
    
    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareClickSS:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
//设置imageView长按手势分享二维码
- (void)ImageViewAndTap:(UIView*)v{
    v.userInteractionEnabled = YES;
    singleTap=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(shareClickSS:)];
    [v addGestureRecognizer:singleTap];
    //    [singleTap release];
    //长按手势
    singleTap.minimumPressDuration=1;
    //所需触摸1次
    singleTap.numberOfTouchesRequired=1;
}

//调整长按手势触发两次的问题
-(void)shareClickSS:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        //1、创建分享参数
        NSArray* imageArray = @[];
        if ([_patWay isEqualToString:@"请打开支付宝扫一扫该二维码，完成交易"]) {
            UIImage *ima= [self screenView:self.view];
            imageArray = @[ima];
        }else if ([_patWay isEqualToString:@"请打开微信扫一扫该二维码，完成交易"]){
          UIImage *ima =  [self screenView:webVIew];
            imageArray = @[ima];
        }

//        //1、创建分享参数
//        NSArray* imageArray = @[self.iamgeView.image];
        
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
    [rightBtn removeFromSuperview];
    [_iamgeView removeGestureRecognizer:singleTap];
}


//////////////////////////////华丽的分割线/////////////////////////////////////////
//***************************二维码生成功能****************************************
+(void)erweima:(NSString *)qrcode imageView:(UIImageView*)iamgeView{
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    //将字符串转换成NSData
    NSData *data = [qrcode dataUsingEncoding:NSUTF8StringEncoding];
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    //将CIImage转换成UIImage,并放大显示
    iamgeView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:500.0];
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
    iamgeView.layer.shadowOffset = CGSizeMake(0, 0.5);//设置阴影的偏移量
    iamgeView.layer.shadowRadius = 1;//设置阴影的半径
    iamgeView.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色为黑色
    iamgeView.layer.shadowOpacity = 0.3;
}

//改变二维码或条形码的大小
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
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


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [hud hide:YES]
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
}


- (UIImage*)screenView:(UIView *)view{
    CGRect rect = view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
