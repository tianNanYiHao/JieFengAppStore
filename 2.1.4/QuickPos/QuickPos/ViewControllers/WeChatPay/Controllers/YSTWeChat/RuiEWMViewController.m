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

@interface RuiEWMViewController ()<UIWebViewDelegate>
{
    UIWebView *webVIew;
    MBProgressHUD *hud;
    
}
@end

@implementation RuiEWMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createWebview];
}
- (void)createWebview{
    webVIew = [[UIWebView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    webVIew.delegate = self;
    [self.view addSubview:webVIew];
    
    NSString *sign = [NSString stringWithFormat:@"merchantId=%@&orderNo=%@&productId=%@&totalFee=%@4e5846d9235247ca93d498212b413b52",_merID,_orderNO,_proID,_totalFee];
     sign = [Utils md5WithString:sign];
    NSString *url = [NSString stringWithFormat:@"http://122.144.198.81:8081/easypay/ruimo/pay?merchantId=%@&orderNo=%@&productId=%@&totalFee=%@&sign=%@",_merID,_orderNO,_proID,_totalFee,sign];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
    
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
-(void)webViewDidStartLoad:(UIWebView *)webView{
    if (!hud) {
        hud = [MBProgressHUD showMessag:L(@"Loading") toView:self.view];
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [hud hide:YES];
    NSString * URLString = @"http://itunes.apple.com/cn/app/id535715926?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
}
@end
