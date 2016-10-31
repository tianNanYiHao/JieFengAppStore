//
//  RechargeViewController.m
//  QuickPos
//
//  Created by Leona on 15/9/25.
//  Copyright © 2015年 张倡榕. All rights reserved.
//

#import "RechargeViewController.h"
#import "ShoppingCartViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "OrderViewController.h"
#import "Request.h"
#import "UIImageView+WebCache.h"
#import "MallData.h"
#import "OrderData.h"
#import "PayType.h"
#import "ChooseView.h"
#import "MallViewController.h"
#import "Common.h"
#import "WebViewController.h"
#import "HelpViewController.h"
#import "RadioButton.h"
#import "DDMenuController.h"
#import "QuickPosTabBarController.h"
#import "SweepViewController.h"
#import "BankCardBindViewController.h"
#import "ZFBViewController.h"



@interface RechargeViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData,ChooseViewDelegate>
{
    long long  Sumprice;
    Request *request;
    NSMutableArray *commodityIDArr;
    NSString *orderDesc;
    NSString *payTool;
    OrderData *orderData;
    NSUInteger payType;
    NSString *commodityIDs; //商品id
    NSString *merchantId;   //商户商家id
    NSString *productId;  //
    NSArray *infoKeyArray; //银统支付key数组
    NSString *_YTpayWay;
    NSString *titleName;
    
    
    
}

@property (weak, nonatomic) IBOutlet UITextField *finalPrice;  //充值金额/支付金额
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@property (weak, nonatomic) IBOutlet UITableView *sTableView;

@property (weak, nonatomic) IBOutlet UIView *phoneView;

@property (weak, nonatomic) IBOutlet UITextField *phone;  //充值账户 TextField

@property (weak, nonatomic) IBOutlet UIView *bottomView;



@property (weak, nonatomic) IBOutlet UILabel *moneyLab; // 充值金额/支付金额
@property (weak, nonatomic) IBOutlet UILabel *phoneNo; //充值账户



@property (weak, nonatomic) IBOutlet RadioButton *button1;
@property (weak, nonatomic) IBOutlet RadioButton *button2;
@property (weak, nonatomic) IBOutlet RadioButton *button3;
@property (weak, nonatomic) IBOutlet UIView *radioBottomView;
@property (weak, nonatomic) IBOutlet RadioButton *button4;

@property (weak, nonatomic) IBOutlet RadioButton *button5;
@property (weak, nonatomic) IBOutlet RadioButton *button6;

@property (weak, nonatomic) IBOutlet RadioButton *button444;
@property (weak, nonatomic) IBOutlet RadioButton *button555;
@property (weak, nonatomic) IBOutlet RadioButton *button666;





@property (weak, nonatomic) IBOutlet RadioButton *button7;
@property (weak, nonatomic) IBOutlet RadioButton *button8;
@property (weak, nonatomic) IBOutlet UIView *radioBottom2;

@property (weak, nonatomic) IBOutlet UIButton *comfirted;

@property (weak, nonatomic) IBOutlet UILabel *ExplainLabel1;//快捷支付费率说明

@property (weak, nonatomic) IBOutlet UILabel *ExplainLabel2;//说明

@property (nonatomic, strong) NSString *isAccount;//是否是账户充值的标准
@property (nonatomic,assign) BOOL isQuick; //再增加一个判断  是否是快捷支付的标准

@end

@implementation RechargeViewController
@synthesize finalPrice;
@synthesize totalPrice;
@synthesize CartArr;
@synthesize mobileNo;
@synthesize sTableView;
@synthesize comfirt;
@synthesize item;
@synthesize orderRemark;
@synthesize moneyTitle;

//勾选支付方式
- (IBAction)typeAction:(RadioButton *)sender {
    
    if (sender.tag == 44) {
        //刷卡支付
         self.radioBottomView.hidden = YES;
        self.radioBottom2.hidden = YES;
        self.ExplainLabel1.hidden = YES;
        self.ExplainLabel2.hidden = YES;
        if (_isRechargeView) {
            merchantId = @"0005000001";
            productId = @"0000000000";
            payTool = @"01";
            self.phoneView.hidden = YES;
            self.isAccount = @"0";
            _YTpayWay = @"NYT";
            payType = CardPayType;  //刷卡充值/支付 0
            [self PromptTipString:@"ZFSK"];
        }
        else
        {
            merchantId = @"0002000002";
            productId = @"0000000000";
            payTool = @"01";
            self.phoneView.hidden = YES;
            self.isAccount = @"0";
            _isQuick = NO;
            payType = CardPayType;
        }
        
    }
//    else if (sender.tag == 66){
//        //账户支付
//        self.radioBottomView.hidden = YES;
//        self.radioBottom2.hidden = YES;
//        self.ExplainLabel1.hidden = YES;
//        self.ExplainLabel2.hidden = YES;
//          //如果是充值页
//        if (_isRechargeView) {
//            merchantId = @"0002000002";
//            productId = @"0000000004";
//            payTool = @"02";
//            self.phoneView.hidden = NO;
//            self.isAccount = @"1";
//            payType = AccountPayType; //账户充值/支付 1
//        }
//        else
//        {
//            merchantId = @"0008000005";
//            productId = @"0000000004";
//            payTool = @"02";
//            self.phoneView.hidden = NO;
//            self.isAccount = @"1";
//            payType = AccountPayType;
//            
//            self.phoneView.hidden = NO;
//        }
//        
//    }
    else if(sender.tag == 55){
        //快捷支付
        self.radioBottomView.hidden = YES;
        self.radioBottom2.hidden = YES;
        self.ExplainLabel1.hidden = NO;
        self.ExplainLabel2.hidden = YES;
        if (_isRechargeView) {
            merchantId = @"0004000001";
            productId = @"0000000001";
            payTool = @"03";
            self.phoneView.hidden = YES;
            self.isAccount = @"0";
            _YTpayWay = @"NYT";
            payType = QuickPayType; //快捷充值/支付 0
            [self PromptTipString:@"KJZF"];
        }
        else
        {
            merchantId = @"0008000004";
            productId = @"0000000001";
            payTool = @"03";
            self.phoneView.hidden = YES;
            self.isAccount = @"0";
            _isQuick = YES; //是快捷支付
            payType = SDJQuickPayType;
        }
    }
    
    else if (sender.tag == 444){ //银统微信
        if(_isRechargeView){
            merchantId = @"0001000006";
            productId = @"0000000004";
            self.phoneView.hidden = YES;
            self.radioBottomView.hidden = YES;
            self.radioBottom2.hidden = YES;
            self.ExplainLabel1.hidden = YES;
            self.ExplainLabel2.hidden = YES;
            _YTpayWay = @"YT";
            _titleNmae = @"微信充值";
            infoKeyArray = [[NSArray alloc] init];
            infoKeyArray = @[WXMERCHANTCODE,WXBACKURL,WXKEY];
              [self PromptTipString:@"ZWX"];

        }
    }
    else if (sender.tag == 555){//银统支付宝
        if (_isRechargeView) {
            merchantId = @"0001000007";
            productId = @"0000000005";
            self.phoneView.hidden = YES;
            self.radioBottomView.hidden = YES;
            self.radioBottom2.hidden = YES;
            self.ExplainLabel1.hidden = YES;
            self.ExplainLabel2.hidden = YES;
            _YTpayWay = @"YT";
            _titleNmae = @"支付宝充值";
            infoKeyArray = [[NSArray alloc] init];
            infoKeyArray = @[ZFBMERCHANTCODE,ZFBBACKURL,ZFBKEY];
              [self PromptTipString:@"ZZFB"];
        }
    }
    else if (sender.tag == 666){//银统银联在线
        if (_isRechargeView) {
            merchantId = @"0001000008";
            productId = @"0000000002";
            self.phoneView.hidden = YES;
            self.radioBottomView.hidden = YES;
            self.radioBottom2.hidden = YES;
            self.ExplainLabel1.hidden = YES;
            self.ExplainLabel2.hidden = YES;
            _YTpayWay = @"YT";
            _titleNmae = @"银联在线充值";
            infoKeyArray = [[NSArray alloc] init];
            infoKeyArray = @[YINHANGMERCHANTCODE,YINHANGURL,YINHANGKEY];
        }
    }
}

//tip
- (void)PromptTipString:(NSString*)string
{
    NSString *tips = [[NSUserDefaults standardUserDefaults] objectForKey:string];
    UIView *tip = [Common tipWithStr:tips color:[UIColor redColor] rect:CGRectMake(0, _comfirted.maxY+10, self.view.frame.size.width, 40)];

    [self.view addSubview:tip];
}


- (IBAction)radioAction:(RadioButton *)sender{
    if (sender.tag == 11) {// 批发

        
//        if ([payTool isEqualToString:@"01"]) {
//            if (_isRechargeView) {
//               }
//            else
//            {
//                merchantId = @"0008000001";
//                productId = @"0000000000";
//            }
//            
//        }
//        _button7.selected = YES;
//        merchantId = @"0002000002";
//        productId = @"0000000005";
//        
//        
//    }else if (sender.tag == 22){//零售
//
//        if ([payTool isEqualToString:@"01"]) {
//            if (_isRechargeView) {
//            }else{
//                merchantId = @"0008000003";
//                productId = @"0000000000";
//            }
//            
//        }
        _button1.selected = NO;
        
        _button3.selected = YES;
        merchantId = @"0005000001";
        productId = @"0000000000";
        [Common showMsgBox:@"" msg:@"功能暂未开放" parentCtrl:self];
   
        
    }else  if (sender.tag == 33){//团购
        
        if ([payTool isEqualToString:@"01"]) {
            if (_isRechargeView) {
                
                merchantId = @"0002000002";
                productId = @"0000000002";
            }else{
                merchantId = @"0008000002";
                productId = @"0000000000";
            }
            _button7.selected = YES;
            merchantId = @"0005000001";
            productId = @"0000000000";
        }
    }
    NSLog(@"%@,%@",merchantId,productId);
}
- (IBAction)payWayChoose:(RadioButton *)sender {
    if (sender.tag == 77) {
        
        if (_button1.selected == YES) { //T+0
            merchantId = @"0002000002";
            productId = @"0000000005";

        }else if(_button3.selected == YES){ //T+1
            merchantId = @"0005000001";
            productId = @"0000000000";
        }
        
    }else if (sender.tag == 88){
        
//        if (_button1.selected == YES) { //T+0
//            merchantId = @"0002000002";
//            productId = @"0000000006";
//            
//        }else if(_button3.selected == YES){ //T+1
//            merchantId = @"0002000002";
//            productId = @"0000000002";
//        }
         _button8.selected = NO;
         [Common showMsgBox:@"" msg:@"功能暂未开放" parentCtrl:self];
    }
    
}


//右侧点击按钮
- (void)creatRightBtn
{
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(helpClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    //    [rightBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (IBAction)helpClick:(id)sender {
    
    HelpViewController *helpVc = [HelpViewController new];
    [self.navigationController pushViewController:helpVc animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    finalPrice.keyboardType = UIKeyboardTypeNumberPad;
    // Do any additional setup after loading the view.
    self.title = _titleNmae;
    self.comfirt.layer.cornerRadius = 5;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:NO];
    [self.comfirt setTitle:_comfirBtnTitle forState:UIControlStateNormal];
//    self.finalPrice.text = moneyTitle;
    NSLog(@"%@",moneyTitle);
    
    
    //右上角按钮--费率说明
//    [self creatRightBtn];
    
    //判断是否充值页面 赋值
    if (_isRechargeView) {
//        _isRechargeView = YES;
        self.finalPrice.placeholder = moneyTitle;
        [self PromptTipString:@"ZFSK"];
        
    }else
    {
        self.finalPrice.placeholder = moneyTitle;
        NSLog(@"%@",moneyTitle);
        self.finalPrice.enabled = NO;
        self.phoneView.hidden = YES;
       
        
    }
    
    commodityIDArr = [NSMutableArray array];
    orderDesc = [NSMutableString string];
    payTool = @"01";
    payType = CardPayType;  //支付方式 刷卡支付
    request = [[Request alloc]initWithDelegate:self];
    self.ExplainLabel1.hidden = YES;
    self.ExplainLabel2.hidden = YES;
    

    
    //  [self computePrice];
    [self cancelFristResponder];   //点击任何一处 键盘消失
    
    //默认
    if (_isRechargeView) {  //如果是充值页面 给id赋初值
//        merchantId = @"0002000002";
//        productId = @"0000000005";
        merchantId = @"0005000001";
        productId = @"0000000000";
        _button5.hidden = NO;
        _button2.hidden = YES;
        _button7.selected = YES;
        _YTpayWay = @"NYT";
    }else
    {
        _button5.hidden = YES;
        _button2.hidden = YES;
        _button7.selected = YES;
        merchantId = @"0008000001";
        productId = @"0000000000";
    }
   
    
    
     [Common setExtraCellLineHidden:self.sTableView];//去除多余的线
    
    _button1.groupButtons = @[_button1,_button2,_button3];
    _button4.groupButtons = @[_button4,_button5,_button6,_button444,_button555,_button666];
    _button7.groupButtons = @[_button7,_button8];
    
    _button6.hidden = YES;
    _button4.selected = YES;
    _button3.selected = YES;
    _radioBottomView.hidden = YES;
    _radioBottom2.hidden = YES;
    _button7.selected = YES;
    _button666.hidden = YES;
    
    self.phoneView.hidden = YES;
    self.isAccount = @"0";
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //    if([UIDevice currentDevice].isIphone4){
    //
    //        self.sTableView.contentSize = CGSizeMake(0,1000);
    //
    //    }
}

//每次页面出现
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    finalPrice.text  = @"";
    
    //    int count = ISQUICKPAY?3:2;
    //    float x = (self.bottomView.frame.size.width - [ChooseView chooseWidth]*count)/2.0;
    //    float y = self.finalPrice.frame.origin.y + self.finalPrice.frame.size.height + 12;
    //    [self.bottomView addSubview:[ChooseView creatChooseViewWithOriginX:x Y:y delegate:self count:count]];
    //    merchantId = @"0002000002";
    //    productId = @"0000000000";
    
    //添加滑动
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    self.navigationController.navigationBarHidden = NO;
    NSLog(@"%@=====%@",productId,merchantId);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


//按钮选择 方法实现
-(void)chooseView:(ChooseView *)chooseView chooseAtIndex:(NSUInteger)chooseIndex
{
    
    payType = chooseIndex;
    payTool = [NSString stringWithFormat:@"0%d",chooseIndex];
    
    if (payType == CardPayType){
        self.radioBottomView.hidden = NO;
        merchantId = @"0002000002";
        productId = @"0000000000";
    }else{
        self.radioBottomView.hidden = YES;
  
        merchantId = @"0004000001";
        productId = @"0000000001";
    }
    
    UIView *v = chooseView.superview;
    for (UIView *c in v.subviews) {
        if ([c isKindOfClass:[ChooseView class]]) {
            if (c.tag != chooseIndex) {
                for (UIView *sv in c.subviews) {
                    if ([sv isKindOfClass:[UIButton class]]) {
                        [(UIButton*)sv setSelected:NO];
                    }
                    
                }
            }
        }
    }
    
}
 //不看 调用的方法 已经被注释掉
//计算价格//拼装商品订单号（订单ID集合）
- (void)computePrice
{
    for (MallItem *dic  in CartArr) {
        int sum = [dic.sum intValue];
        NSString *pr = [NSString stringWithFormat:@"%.2f",[dic.price doubleValue]];
        long long price = [[pr stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
        Sumprice += sum * price;
        
        [commodityIDArr addObject:dic.commodityID];
    }
    
    NSMutableString *temp = [NSMutableString string];
    for (NSMutableString *str in commodityIDArr) {
        [temp appendFormat:@"%@,",str];
    }
    
    orderDesc = mobileNo;
    commodityIDs = [temp substringToIndex:temp.length-1];
    
    finalPrice.text = [NSString stringWithFormat:@"%.2f",Sumprice / 100.0];
    totalPrice.text = [NSString stringWithFormat:@"%.2f",Sumprice / 100.0];
    
    
}
//图片解析。从string拼接后转成data
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  - 点击确认充值/支付 按钮
//发送订单信息。得到回调信息才push
- (IBAction)pushToOrder:(id)sender {
    NSLog(@"-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%@ %@",merchantId ,productId);

    //如果是 充值页
    if (_isRechargeView ) {
        //银统 走扫码充值
        if ([_YTpayWay isEqualToString:@"YT"]) {
             NSInteger i = [finalPrice.text integerValue];
            if (finalPrice.text.length == 0) {
                [Common showMsgBox:@"" msg:@"请输入金额" parentCtrl:self];
            }
            else if([finalPrice.text length]>6){
                [Common showMsgBox:@"" msg:@"输入金额超限" parentCtrl:self];
            }
            else  if ( (i %10) == 0){
                [Common showMsgBox:@"" msg:@"金额不能为整数" parentCtrl:self];
            }
            else {
                if (i/10>=1) {
                    if ([[finalPrice.text substringFromIndex:[finalPrice.text length]-1] isEqualToString:[[finalPrice.text substringFromIndex:[finalPrice.text length]-2] substringToIndex:1]]){
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
        else{//非银统充值方式  (原账户/快捷/刷卡方式)
            NSString *priceVer = finalPrice.text; //得到充值的金额
            priceVer = [NSString stringWithFormat:@"%.2f",[priceVer doubleValue]];
            NSString *priceVerde = finalPrice.text;
            //判断充值金额为空
           if ([priceVer length] > 9 || [priceVerde isEqualToString:@""] || ![self matchStringFormat:priceVer withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"]  || [priceVer isEqualToString:@"0.00"]) {
                [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"请输入正确金额")];
            }
            //如果不为空
            else if (![self matchStringFormat:priceVerde withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"])
            {
                [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"CorrectPrice")]; //请输入正确价格
            }
            //否则
            else
            {
                NSString *price = [priceVer stringByReplacingOccurrencesOfString:@"." withString:@""];//过滤字符
                //是否是账户充值的标准
                if ([self.isAccount isEqualToString:@"1"]) {  //是账户充值
                    if (self.phone.text.length == 0) {
                        [Common showMsgBox:@"" msg:L(@"InputNumber") parentCtrl:self];//请输入电话号码
                        return;
                    }
                    
                    if(![Common isPhoneNumber:self.phone.text]){
                        [Common showMsgBox:@"" msg:L(@"MobilePhoneNumberIsWrong") parentCtrl:self]; //手机号码有错 请重新输入
                        return;
                    }
                    //账户支付
                    [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                                      MerchanId:merchantId
                                      productId:productId
                                       orderAmt:price
                                      orderDesc:self.phone.text //填写的充值账户
                                    orderRemark:@""
                                   commodityIDs:@""
                                        payTool:payTool];
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderHasBeenSubmitted-PleaseLater")];//已提交订单
                }
                else{ //否则是 刷卡和快捷支付
                    
                    [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                                      MerchanId:merchantId
                                      productId:productId
                                       orderAmt:price
                                      orderDesc:[AppDelegate getUserBaseData].mobileNo
                                    orderRemark:@""
                                   commodityIDs:@""
                                        payTool:payTool];
                    
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderHasBeenSubmitted-PleaseLater")]; //已提交
                }
            }
        }
   }
    else //如果是支付页 ******
    {
        
//        NSArray *arr = [moneyTitle componentsSeparatedByString:@"￥"];  
     
        NSString *priceGoods = moneyTitle; // 扫码支付传值过来的金额
        
        priceGoods = [NSString stringWithFormat:@"%.2f",[priceGoods doubleValue]];
        NSLog(@"%@",priceGoods);
        
        
        NSString *pricePay = [priceGoods stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        if ([self.isAccount isEqualToString:@"1"]){
//如果是账户支付
          [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                              MerchanId:merchantId
                              productId:productId
                              orderAmt:pricePay
                              orderDesc:@"18516032822"  //要往里面充值的账户
                              orderRemark:self.orderRemark //扫码支付中 接受的习正的订单号
                              commodityIDs:@""
                              payTool:payTool];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderHasBeenSubmitted-PleaseLater")];//已提交订
            
        }else if([self.isAccount isEqualToString:@"0"]){
            if (!_isQuick) {
//刷卡支付
                payType = CardPayType;
                payTool = @"01";
                orderDesc = [NSMutableString string];
                
            [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                                  MerchanId:merchantId
                                  productId:productId
                                  orderAmt:pricePay
                                  orderDesc:[AppDelegate getUserBaseData].mobileNo
                                  orderRemark:self.orderRemark //扫码支付中 接受的习正的订单号
                                  commodityIDs:@""
                                  payTool:payTool];
                [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderHasBeenSubmitted-PleaseLater")]; //已提交
                NSLog(@"%@  %@  %@",merchantId,productId,self.orderRemark);
            }else{
//快捷支付
                
                payType = QuickPayType;
                payTool = @"01";
                orderDesc = [NSMutableString string];
            [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                                  MerchanId:merchantId
                                  productId:productId
                                  orderAmt:pricePay
                                  orderDesc:[AppDelegate getUserBaseData].mobileNo
                                  orderRemark:self.orderRemark //扫码支付中 接受的习正的订单号
                                  commodityIDs:@""
                                  payTool:payTool];
                [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderHasBeenSubmitted-PleaseLater")]; //已提交
                NSLog(@"%@  %@",merchantId,productId);
      
            }

        }
    }
}

//得到返回  进入orderviewController(订单信息) 传递商品信息 支付方式
-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{

    if (type == REQUSET_GETORDER) {
        //判断 如果是返回字典是 (即 支付页面 的商品支付信息)
        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            
            NSLog(@"_____________Recharge立即购买====>订单信息");
            NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"REP_BODY"]];
            OrderData *orderData1 = [[OrderData alloc] init];
            orderData1.orderId = [dic objectForKey:@"orderid"];//订单编号
            NSLog(@"%@",orderData1.orderId);
            
            orderData1.orderAmt = [NSString stringWithFormat:@"%li",[[_oneProductMoneyDic objectForKey:@"totalAmount"] longValue]];//订单金额
            orderData1.orderDesc = [dic objectForKey:@"mercId"] ;//订单详情
            orderData1.realAmt = [dic objectForKey:@"totalAmount"];//实际交易金额
            orderData1.orderAccount = [AppDelegate getUserBaseData].mobileNo;  //交易账号
            orderData1.orderPayType = payType;  //支付方式
            orderData1.merchantId = merchantId;
            orderData1.productId = productId;
            
            //跳转 OrderViewController
            OrderViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
            shopVc.orderData = orderData1;
            for (UIViewController *v in self.navigationController.viewControllers) {
                if ([v isKindOfClass:[MallViewController class]]) {
                    shopVc.delegate = v;
                }
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.navigationController pushViewController:shopVc animated:YES];
        }

    }
    
    else  //充值页面 返回的充值信息
    {
        if ([[dict objectForKey:@"respCode"]isEqualToString:@"1001"]) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        if([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]){
            if (type == REQUSET_ORDER) {
                UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                OrderViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
                orderData = [[OrderData alloc]initWithData:dict];
                orderData.orderAccount = [AppDelegate getUserBaseData].mobileNo;
                orderData.orderPayType = payType;
                orderData.merchantId = merchantId;
                orderData.productId = productId;
//                orderData.orderAmt = self.finalPrice.text;
//          orderData.orderAmt = [NSString stringWithFormat:@"￥%.2f",[self.finalPrice.text integerValue]/100.0];//金额转化
//                orderData.mallOrder = YES;
                shopVc.orderData = orderData;
                
                NSLog(@"%@ %@ %d %@ %@ %@",orderData,orderData.orderAccount,orderData.orderPayType,orderData.merchantId,orderData.productId,shopVc.orderData);
                for (UIViewController *v in self.navigationController.viewControllers) {
                    if ([v isKindOfClass:[MallViewController class]]) {
                        shopVc.delegate = v;
                    }
                }
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.navigationController pushViewController:shopVc animated:YES];
                //            [self.navigationController presentViewController:shopVc animated:YES completion:nil];
            }
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showHUDAddedTo:self.view WithString:[dict objectForKey:@"respDesc"]];
        }
    }
}

-(void)pay{
    finalPrice.text = [NSString stringWithFormat:@"%.2f",[finalPrice.text floatValue]];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZFBViewController *ZFBVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ZFBVc"];
    ZFBVc.AmtNO = finalPrice.text;
    ZFBVc.cardNum = [AppDelegate getUserBaseData].mobileNo;
    ZFBVc.merchantId = merchantId;
    ZFBVc.productId = productId;
    ZFBVc.titleName = _titleNmae;
    
    if (_button444.selected == YES) {  //微信
        ZFBVc.infoArr =  @[WXMERCHANTCODE,WXBACKURL,WXKEY,@"上海捷丰网络科技有限公司"];
         ZFBVc.openShowLab1Str = @"请打开微信扫一扫该二维码";
    }
    else if (_button555.selected == YES) {  //支付宝
         ZFBVc.openShowLab1Str = @"请打开支付宝扫一扫该二维码";
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
        
    }
    else{  //银联在线
        
    }
    [self.navigationController pushViewController:ZFBVc animated:YES];

    
}
//不用看 CartArr 已经被注释掉
#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ShoppingCartTableViewCell";
    ShoppingCartTableViewCell *cell =(ShoppingCartTableViewCell*) [sTableView dequeueReusableCellWithIdentifier:cellID];
    MallItem *dic    = CartArr[indexPath.row];
    
    [cell.shopCartMerchandiseImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic.iconurl]]];
    cell.shopCartMerchandiseName.text = dic.title;
    cell.shopCartMerchandisePrice.text = dic.price;
    cell.shopCartMerchandiseSum.text = dic.sum;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return CartArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 147;
    
}

-(void)cancelFristResponder
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
//取消第一响应者事件
- (void)keyboardHide
{
    [finalPrice resignFirstResponder];
}

#pragma mark - 正则判断
- (BOOL)matchStringFormat:(NSString *)matchedStr withRegex:(NSString *)regex
{
    //SELF MATCHES一定是大写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:matchedStr];
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
