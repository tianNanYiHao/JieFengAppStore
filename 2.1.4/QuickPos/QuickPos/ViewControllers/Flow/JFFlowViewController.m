//
//  JFFlowViewController.m
//  QuickPos
//
//  Created by Lff on 16/11/24.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "JFFlowViewController.h"
#import "JFFloewCollectionViewCell.h"
#import "Request.h"
#import "RadioButton.h"
#import "OrderData.h"
#import "PayType.h"
#import "OrderViewController.h"




@interface JFFlowViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ResponseData>
{
     NSUInteger payType;//账户支付 刷卡支付 快捷支付
     OrderData *orderData;
    UICollectionView *_collectionView;
    NSArray *_array;
    NSArray *_array2;
    NSString *_merchaID;
    NSString *_productID;
    Request *request;
    
}

@property (weak, nonatomic) IBOutlet UITextField *numbText;
@property (weak, nonatomic) IBOutlet RadioButton *btn2;
@property (weak, nonatomic) IBOutlet RadioButton *btn1;
@end

@implementation JFFlowViewController

- (IBAction)payWayChangeClick:(RadioButton*)sender {
    if (sender.tag == 1) { //刷卡支付
        _merchaID = @"0001000004";
        _productID = @"0000000000";
        payType = CardPayType;
        
    }else if (sender.tag == 2){ //快捷支付
        _merchaID = @"0001000004";
        _productID = @"0000000001";
        payType = QuickPayType;
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title  = @"流量充值";
    _btn1.groupButtons = @[_btn1,_btn2];
    _btn1.selected = YES;
    _merchaID = @"0001000004";
    _productID = @"0000000000";
    payType = CardPayType;
    request = [[Request alloc] initWithDelegate:self];
    [self createCollection];
    
    
    
}

- (void)createCollection{
    
    _array = @[@"30M",@"50",@"100M",@"200",@"500",@"1G"];
    _array2 = @[@"售价10元",@"售价20元",@"售价30元",@"售价50元",@"售价100元",@"售价200元"];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 180, NEWWIDTH, NEWHEIGHT-130) collectionViewLayout:layout];
    [_collectionView registerNib:[UINib nibWithNibName:@"JFFloewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JFFloewCollectionViewCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    
}

#pragma mark - colletcionDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat f =  107/65;
    return CGSizeMake((NEWWIDTH-40)/3, 65*f);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JFFloewCollectionViewCell *cell = (JFFloewCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"JFFloewCollectionViewCell" forIndexPath:indexPath];
    cell.labM.text = _array[indexPath.row];
    cell.labMoney.text = _array2[indexPath.row];
    return cell;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 15, 5, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"00000000");
    
    if (payType == CardPayType){
        [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:_merchaID productId:_productID orderAmt:@"100" orderDesc:_numbText.text orderRemark:@"" commodityIDs:@"" payTool:@"01"];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderIsSubmitted")];
    }else{
        //快捷支付
        [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                          MerchanId:_merchaID
                          productId:_productID
                           orderAmt:@"100"
                          orderDesc:_numbText.text
                        orderRemark:@""
                       commodityIDs:@""
                            payTool:@"03"];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderIsSubmitted")];
    }
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
        
       if(type == REQUSET_ORDER){  // 申请订单成功
           UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OrderViewController *shopVc = [sto instantiateViewControllerWithIdentifier:@"OrderViewController"];
            orderData = [[OrderData alloc]initWithData:dict];
            orderData.orderAccount = [AppDelegate getUserBaseData].mobileNo;
            orderData.orderPayType = payType;
            orderData.merchantId = _merchaID;
            orderData.productId = _productID;
            //            orderData.mallOrder = YES;
            shopVc.orderData = orderData;
           NSLog(@"push push push push push push push push push");
            [self.navigationController pushViewController:shopVc animated:YES];
        }
        
    }else{
        
        [Common showMsgBox:@"" msg:[dict objectForKey:@"respDesc"] parentCtrl:self];
    }
    
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
