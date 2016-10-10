//
//  ConvenientServiceViewController.m
//  YoolinkIpos
//
//  Created by 张倡榕 on 15/3/4.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "ConvenientServiceViewController.h"
#import "CollectionCell.h"
#import "BalanceEnquiryViewController.h"
#import "WaterElectricityCoalViewController.h"
#import "CreditCardPayViewController.h"
#import "LotteryViewController.h"
#import "WithdrawalViewController.h"
#import "PhoneRechargeViewController.h"
#import "QuickPosTabBarController.h"
#import "PayType.h"
#import "Request.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Add.h"
#import "NoteViewController.h"
#import "RechargeViewController.h"
#import "TransferAccountViewController.h"
#import "SDCycleScrollView.h"
#import "Common.h"
#import "LoginViewController.h"
#import "ABCIntroView.h"
#import "RechargeFixedViewController.h"
#import "MangeMoneyViewController.h"
#import "FoodQueryViewController.h"
#import "FoodDataViewController.h"
#import "TransferViewController.h"
#import "FoodInFormationViewController.h"
#import "CardToCardPayViewController.h"
#import "ReusableHeaderView.h"
#import "WeChatBankListViewController.h"
#import "ZFBViewController.h"
#import "ZFBBankCardListViewController.h"
#import "SubLBXScanViewController.h"
#import "LBXScanWrapper.h"
#import "TrickMainViewController.h"
#import "TrickAddressModel.h"


#define kCellReuseID @"CollectionCellId"

#define kHeaderReuseID @"headerView"
#define kFooterReuseId @"footerView"


@interface ConvenientServiceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, ResponseData,SDCycleScrollViewDelegate,ABCIntroViewDelegate>
{
    NSMutableArray *vcArr;
    float contentY;
    Request *request;
}
@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;

@property ABCIntroView *introView;

@property (strong, nonatomic)NSMutableArray * menuDataArr;//数据源数组。

@property (strong, nonatomic)NSMutableArray * menuDataArr1;//数据源数组。

@property (strong,nonatomic) UILabel *titleLabel;

@property (nonatomic,strong) NSString *QRCodeAmt;

@property (nonatomic,strong) NSString *orderNo;

@property (nonatomic,assign) BOOL isMenuDataArr1;

@property (nonatomic,strong) NSArray *iamgeAllArr;

@property (nonatomic,strong) NSArray *titleAllArr;

@property (nonatomic,strong) NSString *state;




@end

@implementation ConvenientServiceViewController


- (void)awakeFromNib{
    
    
}
//轮播图创建
- (void)creatScrollView{
    
    // 情景一：采用本地图片实现
    NSArray *images = @[[UIImage imageNamed:@"banner1"],
                        [UIImage imageNamed:@"banner2"]
                        ];
    
    CGFloat w = self.view.bounds.size.width;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,302, w, 80) imagesGroup:images];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.delegate = self;
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.view addSubview:cycleScrollView];
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}
- (void)addintro{
    
    /////用来判断第一次启动而是否加载引导页
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"intro_screen_viewed"]) {
        
        self.navigationController.navigationBarHidden = YES;
        //引导页的的方法
        self.introView = [[ABCIntroView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.introView.delegate = self;
        self.introView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:self.introView];
        self.tabBarController.tabBar.hidden = YES;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [Common hexStringToColor:@"#068bf4"];//导航栏颜色
    self.navigationController.navigationBar.tintColor = [Common hexStringToColor:@"#ffffff"];//返回键颜色
    self.navigationController.navigationBar.contentMode = UIViewContentModeScaleAspectFit;
    //设置标题颜色 
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [Common hexStringToColor:@"#ffffff"], UITextAttributeTextColor,
                                                                     [UIFont systemFontOfSize:17], UITextAttributeFont,
                                                                     nil]];
    
    
//    [self creatRightBtn];
    
    contentY = 0;
    self.menuCollectionView.alwaysBounceVertical = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    //    Request *req = [[Request alloc]initWithDelegate:self];
    request = [[Request alloc]initWithDelegate:self];
    
    //不需要登陆改成这样
    [self setUpCollection:nil isResult:NO];
    
    //    [req getChannelApplication];//原来的
    //    [self initViewController];
    //创建轮播图
    //    [self creatScrollView];
    
    //创建collectionView
    [self createContent];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addintro];//引导图
}

#pragma mark  创建collectionView

- (void)createContent {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    CGFloat width = (self.view.frame.size.width - 45)/2;
    layout.itemSize = CGSizeMake(width, width * 100/165.0);
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    
    
    //    _menuCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 76, width, self.view.frame.size.height-76-49) collectionViewLayout:layout];
    //    _menuCollectionView.backgroundColor = [UIColor whiteColor];
    _menuCollectionView.delegate = self;
    _menuCollectionView.dataSource = self;
    _menuCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_menuCollectionView];
    [_menuCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [_menuCollectionView registerClass:[ReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseID];
}

//右上角 rightBtn
- (void)creatRightBtn
{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    //    [rightBtn release];
    rightItem.tintColor = [Common hexStringToColor:@"46a7ec"];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightBtn:(UIButton *)btn
{
//    [(DDMenuController*)[(QuickPosTabBarController*)self.tabBarController parentCtrl] showRightController:YES];
    
    //登陆判断
    if ([[AppDelegate getUserBaseData].mobileNo length] > 0) {
        
        //已经登陆
        [(DDMenuController*)[(QuickPosTabBarController*)self.tabBarController parentCtrl] showRightController:YES];
        
    }else{
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *login = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosNavigationController"];
        [self presentViewController:login animated:YES completion:nil];
    }
    
}


- (IBAction)showSetup:(UIBarButtonItem *)sender {
    
    //登陆判断
    if ([[AppDelegate getUserBaseData].mobileNo length] > 0) {
        
        //已经登陆
        [(DDMenuController*)[(QuickPosTabBarController*)self.tabBarController parentCtrl] showRightController:YES];
        
    }else{
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *login = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosNavigationController"];
        [self presentViewController:login animated:YES completion:nil];
    }
    
}

- (void)viewDidLayoutSubviews {
    //    self.navigationController.navigationBarHidden = YES;
}

-(void)setUpCollection:(NSDictionary*)dict isResult:(BOOL)isResult{
    
    self.menuDataArr = [NSMutableArray array];
    self.menuDataArr1 = [NSMutableArray array];
    self.iamgeAllArr = [NSArray array];
    self.titleAllArr = [NSArray array];
    if (!isResult) {

        NSArray *titleArr1 = @[@"账户转账",@"即时取",@"余额查询",@"卡卡转账",@"信用卡还款",@"微信收款",@"支付宝收款",@"手机充值",@"水电煤",@"电影票购买",@"中华保险",@"点卡充值"];
        
        NSArray *titleArr2 = @[@"汽车展订票",@"交通违章代办",@"火车票订购",@"飞机票订购"]; //,@"彩票下注",@"Q币充值"
        
        self.titleAllArr = @[titleArr1, titleArr2];
        
        NSArray *imageArr1 = @[@"serve_transfer",@"serve_traffic",@"serve_query",@"serve_kakapay",@"xinyongka",@"serve_wechat",@"zhifubaochongzhi",@"serve_phone",@"serve_Waterr",@"movie_purchase",@"baoxian",@"serve_game"];
        NSArray *imageArr2 = @[@"qichezhan",@"jiaotongweizhang",@"huochepiao",@"feijipiao"]; //,@"caipiao",@"QQchongzhi"
        
        self.iamgeAllArr = @[imageArr1,imageArr2];
        
        
        
        
        //        UIImageView *image = [[UIImageView alloc]init];
        //        image.contentMode = UIViewContentModeScaleAspectFit;
        
        
        
        NSArray *noteArr1 = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
        NSArray *noteArr2 = @[@"",@"",@"",@""];//,@"",@"
        NSArray *noteAllArr = @[noteArr1,noteArr2];

        NSArray *channelArr1 = @[@"0001",@"0002",@"0003",@"0004",@"0005",@"0006",@"0007",@"0008",@"0009",@"0010",@"0011",@"0012"];
        NSArray *channelArr2 = @[@"0021",@"0022",@"0023",@"0024"]; //,@"0025",@"0026"
        
        
        
        NSArray *channelAllArr = @[channelArr1,channelArr2];
        
        for (NSInteger indexrow = 0; indexrow < self.titleAllArr.count; indexrow ++) {
            for (NSInteger indeloc = 0; indeloc < [self.titleAllArr[indexrow] count]; indeloc ++) {
                
                NSString *title = [[self.titleAllArr objectAtIndex:indexrow] objectAtIndex:indeloc];
                NSString *image = [[self.iamgeAllArr objectAtIndex:indexrow] objectAtIndex:indeloc];
                NSString *announce = [[noteAllArr objectAtIndex:indexrow] objectAtIndex:indeloc];
                NSString *channelID = [[channelAllArr objectAtIndex:indexrow] objectAtIndex:indeloc];
                NSDictionary *dic = @{@"image": image, @"title":title,@"announce":announce,@"channelID":channelID};
                [self.menuDataArr addObject:dic];
                
                
            }
        }
    }else{
        for (NSDictionary *item in [dict objectForKey:@"channel"]) {
            NSString *title = [item objectForKey:@"channelTitle"];
            NSString *image = [item objectForKey:@"channelIconUrl"];
            NSString *announce = [item objectForKey:@"announce"];
            NSString *channelID = [item objectForKey:@"channelID"];
            NSString *isShow = [item objectForKey:@"isShow"];
            NSDictionary *dic = @{@"image": image, @"title":title,@"announce":announce,@"channelID":channelID,@"isShow":isShow};
            if (isShow.boolValue) {
               
                [self.menuDataArr addObject:dic];
                
                
            }
        }for (NSDictionary *item in [dict objectForKey:@"channel"]) {
            NSString *title1 = [item objectForKey:@"channelTitle"];
            NSString *image1 = [item objectForKey:@"channelIconUrl"];
            NSString *announce1 = [item objectForKey:@"announce"];
            NSString *channelID1 = [item objectForKey:@"channelID"];
            NSString *isShow1 = [item objectForKey:@"isShow"];
            NSDictionary *dic1 = @{@"image": image1, @"title":title1,@"announce":announce1,@"channelID":channelID1,@"isShow":isShow1};
            if (isShow1.boolValue) {
             
                [self.menuDataArr1 addObject:dic1];
               
           
            }
        }
        
    }
    self.menuCollectionView.delegate = self;
    self.menuCollectionView.dataSource = self;
    
    //    [self initViewController];
    [self.menuCollectionView reloadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ABCIntroViewDelegate Methods

- (void)onDoneButtonPressed{
    
    //    Uncomment so that the IntroView does not show after the user clicks "DONE"
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"YES"forKey:@"intro_screen_viewed"];
    [defaults synchronize];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.introView.alpha = 0;
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
        
    } completion:^(BOOL finished) {
        
        [self.introView removeFromSuperview];
        
    }];
}
#pragma mark - CollectionView Data Source


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 12;
    }else if (section == 1){
        return 4;
    }
    return [self.menuDataArr[section] count];
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionCellID = @"CollectionCellId";
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    float cellWidth = SCREEN_WIDTH/4;
    float cellHeight = cellWidth;
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y,cellWidth, cellHeight);
    
    
    
    NSString *image = self.iamgeAllArr[indexPath.section][indexPath.row];
    NSString *title = self.titleAllArr[indexPath.section][indexPath.row];
    
  
    
    if (![image hasPrefix:@"http"]) {
        [cell.imageView setImage:[UIImage imageNamed:image]];
    }else{
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    }
    cell.titleLabel.text = title;
    
    return cell;
}


//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 7;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 7;
}

//定义每个collectionCell 的边缘
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //        return UIEdgeInsetsMake(5, 5, 5, 5);//上 左 下 右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        ReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseID forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
            view.backgroundColor = [Common hexStringToColor:@"#2196f3"];
            
            UIButton *scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 25, 48, 48)];
            [scanBtn setImage:[UIImage imageNamed:@"code_pay"] forState:UIControlStateNormal];
            
            [scanBtn addTarget:self action:@selector(scanCode:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *RechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(212, 25, 48, 48)];
            [RechargeBtn setImage:[UIImage imageNamed:@"serve_payment"] forState:UIControlStateNormal];
            [RechargeBtn addTarget:self action:@selector(Recharge:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UILabel *scanLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 75, 48, 20)];
            scanLabel.text = @"扫一扫";
            scanLabel.textColor = [Common hexStringToColor:@"#ffffff"];
            scanLabel.font = [UIFont systemFontOfSize:12];
            scanLabel.adjustsFontSizeToFitWidth = YES;
            scanLabel.textAlignment = UITextAlignmentCenter;
            
            UILabel *RechargeLabel = [[UILabel alloc]initWithFrame:CGRectMake(212, 75, 48, 20)];
            RechargeLabel.text = @"账户充值";
            RechargeLabel.textColor = [Common hexStringToColor:@"#ffffff"];
            RechargeLabel.font = [UIFont systemFontOfSize:14];
            RechargeLabel.adjustsFontSizeToFitWidth = YES;
            scanLabel.textAlignment = UITextAlignmentCenter;
            
            [view addSubview:RechargeLabel];
            [view addSubview:scanLabel];
            [view addSubview:scanBtn];
            [view addSubview:RechargeBtn];
            [headerView addSubview:view];
        }else if (indexPath.section == 1){
            
            NSArray *images = @[[UIImage imageNamed:@"banner1"],
                                [UIImage imageNamed:@"banner2"]
                                ];
            
            CGFloat w = self.view.bounds.size.width;
            SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, w, 75) imagesGroup:images];
            cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
            cycleScrollView.delegate = self;
            cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
            [self.view addSubview:cycleScrollView];
            [headerView addSubview:cycleScrollView];
            
        }
        
        reusableview = headerView;
    }
    
    return reusableview;
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        CGSize size={320,100};
        return size;
    }else if (section == 1){
        CGSize size={320,75};
        return size;
    }
    return CGSizeZero;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //登陆判断
    if ([[AppDelegate getUserBaseData].mobileNo length] > 0) {
        //已经登陆
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {//账户转账
                TransferViewController *transferVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TransferViewController"];
                transferVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:transferVc animated:YES];
            }else if (indexPath.row == 1){//即时取
                
                WithdrawalViewController *WithdrawalVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"WithdrawalVC"];
                WithdrawalVC.destinationType = WITHDRAW;
                WithdrawalVC.navigationItem.title = L(@"Withdrawal");
                WithdrawalVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:WithdrawalVC animated:YES];
                
                
               
            }else if (indexPath.row == 2){//余额查询
                
                BalanceEnquiryViewController *balanceEnquiryVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"BalanceEnquiryViewController"];
                balanceEnquiryVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:balanceEnquiryVc animated:YES];
                
                
            }else if (indexPath.row == 3){//卡卡转账
                
                CardToCardPayViewController *cardToCardVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CardToCardPay"];
                cardToCardVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cardToCardVc animated:YES];
                
                
               
            }else if (indexPath.row == 4){//信用卡还款
                
                CreditCardPayViewController *creditCardPayVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CreditCardPayViewController"];
                creditCardPayVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:creditCardPayVc animated:YES];
                
            }else if (indexPath.row == 5){//微信收款
                
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                WeChatBankListViewController *WeChatBankListVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"WeChatBankListVc"];
                
                WeChatBankListVc.state = self.state;
                WeChatBankListVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:WeChatBankListVc animated:YES];
            }else if (indexPath.row == 6){//支付宝收款
                
                
                
                ZFBBankCardListViewController *ZFBBankCardListVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ZFBBankCardListVc"];
                ZFBBankCardListVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:ZFBBankCardListVc animated:YES];
                
            }else if (indexPath.row == 7){//手机充值
                
                PhoneRechargeViewController *phoneRechargeVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"PhoneRechargeViewController"];
                phoneRechargeVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:phoneRechargeVc animated:YES];
                
            }
            else
            {//正在努力建设中...
                NoteViewController *noteVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"NoteViewController"];
                noteVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:noteVc animated:YES];
            }
        }
        else if (indexPath.section == 1)   //骑车展订票+交通违章+火车票+飞机票
        {
            if (indexPath.row == 2) { //火车票
                TrickMainViewController *trickMain = [[TrickMainViewController alloc] initWithNibName:@"TrickMainViewController" bundle:nil];
                TrickInfoModel *model = [[TrickInfoModel alloc] init];
                trickMain.dataArray = [model getInfoBack];
                for (int i = 0; i<trickMain.dataArray .count; i++) {
                    NSLog(@"%@ == %@ ",[trickMain.dataArray [i] addName],[trickMain.dataArray [i] addCode]);
                }
                [self.navigationController pushViewController:trickMain animated:YES];
            }
            
            
            else{
                //正在努力建设中...
                NoteViewController *noteVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"NoteViewController"];
                noteVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:noteVc animated:YES];
            }
        }
       
    }else{
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *login = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosNavigationController"];
        [self presentViewController:login animated:YES completion:nil];
    }
}

#pragma mark 扫一扫

- (void)scanCode:(UIButton *)Btn
{
    if ([[AppDelegate getUserBaseData].mobileNo length] > 0){
        
        NSLog(@"扫一扫");
        
        if ([self validateCamera]) {
            [self createZFBStyle];
        }else{
            [Common pstaAlertWithTitle:@"提示" message:@"请检查摄像头" defaultTitle:@"" cancleTitle:@"取消" defaultBlock:^(id defaultBlock) {
            } CancleBlock:^(id cancleBlock) {
            } ctr:self];
        }
        
    }else
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *login = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosNavigationController"];
        [self presentViewController:login animated:YES completion:nil];
    }
}
#pragma mark - 仿支付宝扫码(style设置)
-(void)createZFBStyle{
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc] init];
    style.centerUpOffset = 60;
    style.xScanRetangleOffset = 30;
    
    if ([UIScreen mainScreen].bounds.size.height <= 480) {
        //如果是3.5inch 显示的扫码缩小
        style.centerUpOffset = 40;
        style.xScanRetangleOffset = 20;
    }
    
    style.alpa_notRecoginitonArea = 0.6;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    
    
    style.isNeedShowRetangle = NO;
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    //使用的支付宝里面网格图片
    UIImage *imgFullNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_full_net"];
    style.animationImage = imgFullNet;
    [self openScanVCWithStyle:style];
    
}
#pragma  mark - 跳转扫码
- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    vc.isOpenInterestRect = YES;//区域识别效果
    
    vc.isQQSimulator = YES; //qq功能预写了一些功能按钮 (相册/闪光/二维码按钮)
    vc.isVideoZoom = YES; //增加缩放功能
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    [vc actionDoSomeThing:^(LBXScanResult *info) {
       
        _orderNo = [NSString stringWithString:info.strScanned];
        [request queryScanMoneyWithOrderNo:_orderNo];
    }];
    
}
- (BOOL)validateCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

#pragma mark 账户充值

- (void)Recharge:(UIButton *)Btn
{
    if ([[AppDelegate getUserBaseData].mobileNo length] > 0){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        RechargeViewController *RechargeViewVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"RechargeViewVC"];
        
        RechargeViewVC.isRechargeView = YES;
        RechargeViewVC.hidesBottomBarWhenPushed = YES;
        RechargeViewVC.titleNmae = @"账户充值";
        RechargeViewVC.moneyTitle = @"输入充值金额";
        RechargeViewVC.comfirBtnTitle = @"确认充值";
        
        [self.navigationController pushViewController:RechargeViewVC animated:YES];
        
    }else
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *login = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosNavigationController"];
        [self presentViewController:login animated:YES completion:nil];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return NO;
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type {
  
    if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
        
        if(type == REQUEST_GETCHANNELAPPLICATION){
            
            [self setUpCollection:[dict objectForKey:@"data"] isResult:NO];//设置为NO在本地加载
        }
        
        
    }if (type == REQUSET_QUERYSCANMONEY) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RechargeViewController *rechargeVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"RechargeViewVC"];
        rechargeVc.hidesBottomBarWhenPushed = YES;
        
        NSDictionary *dataDict = [dict objectForKey:@"data"];
        if([[[dataDict objectForKey:@"REP_HEAD"]objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            
            _QRCodeAmt = [NSString stringWithFormat:@"%li",[[[dataDict objectForKey:@"REP_BODY"]objectForKey:@"ordAmt"] longValue]/100];
            

            
  
            
            rechargeVc.titleNmae = @"扫码支付";
            rechargeVc.moneyTitle = @"输入充值金额";
            rechargeVc.comfirBtnTitle = @"确认充值";
            rechargeVc.orderRemark = _orderNo;//扫码订单号
            rechargeVc.moneyTitle = _QRCodeAmt;

            [self.navigationController pushViewController:rechargeVc animated:YES];
            
        }else
        {
//            [Common showMsgBox:@"" msg:@"二维码格式错误" parentCtrl:self];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"二维码格式错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [self.navigationController popViewControllerAnimated:YES];
            [alert show];
            
        }
    }
    if (type == REQUSET_QUERYBINDWEIXINORDERSTATE) {
        
       
       
        self.state = [[dict objectForKey:@"data"]objectForKey:@"state"];

        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            WeChatBankListViewController *WeChatBankListVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"WeChatBankListVc"];
//
//            WeChatBankListVc.state = self.state;
//            WeChatBankListVc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:WeChatBankListVc animated:YES];
      
    }
    else{
        [self setUpCollection:[dict objectForKey:@"data"] isResult:NO];
        //        [MBProgressHUD showHUDAddedTo:self.view WithString:@"网络不给力,正在重新请求。。。"];
        //        [self initViewController];
        //        Request *req = [[Request alloc]initWithDelegate:self];
        //        [req getChannelApplication];
    }
}

@end
