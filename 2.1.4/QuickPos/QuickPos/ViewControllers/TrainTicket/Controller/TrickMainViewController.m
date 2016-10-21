//
//  TrickMainViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/9.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TrickMainViewController.h"
#import "TrickAddressModel.h"
#import "TrickChooseCarListViewController.h"
#import "LFFAddPickerView.h"
#import "LFFPickerVIew.h"
#import "TrickListInfoModel.h"


@interface TrickMainViewController ()<LFFAddPickerViewDelegate,LFFPickerViewDelegate,ResponseData>
{
    
    LFFAddPickerView *addPickerView;
    LFFPickerVIew        *addDatePickerView;
    Request *_req;
    NSString *_fromCode;
    NSString *_toCode;
    NSString *_dateCode;
    TrickListInfoModel *_trickListModel;
    NSMutableArray *_listDataArray;
    NSString *_lastDay;
    
    
    
    
    
    
}

@property (weak, nonatomic) IBOutlet UILabel *fromLab;
@property (weak, nonatomic) IBOutlet UILabel *toLab;

@property (weak, nonatomic) IBOutlet UIButton *addressToBtn;
@property (weak, nonatomic) IBOutlet UIButton *addressFromeBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseDateBtn;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIButton *queryCarBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;


@end

@implementation TrickMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"火车票";
    _req = [[Request alloc] initWithDelegate:self];
    _listDataArray = [NSMutableArray arrayWithCapacity:0];
    [self createPickerViewList];

}

-(void)createPickerViewList{
    
    addPickerView = [LFFAddPickerView awakeFromXib];
    addPickerView.delegate = self;
    addPickerView.infoArray =  _dataArray;
    addPickerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:addPickerView];
    addPickerView.alpha = 0;
    
    
    addDatePickerView = [LFFPickerVIew awakeFromXib];
    addDatePickerView.delegate = self;
    addDatePickerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:addDatePickerView];
    addDatePickerView.alpha = 0;
    _dateLab.text = @"请选择出发日期";
}

//起点
- (IBAction)addressFromeClick:(id)sender {
    addPickerView.fromeAddress = @"1";
    [UIView animateWithDuration:0.3 animations:^{
        addPickerView.alpha = 1;
    }];
    
}
//终点
- (IBAction)adressToClick:(id)sender {
     addPickerView.toAddress = @"2";
    [UIView animateWithDuration:0.3 animations:^{
        addPickerView.alpha = 1;
    }];
}
//是否高铁/动车
- (IBAction)chooseFaseCar:(id)sender {
    
    
    
}

//选择日期按钮
- (IBAction)chooseDateBtnClick:(id)sender {
    
    addDatePickerView.Timetype = 1;
    [UIView animateWithDuration:0.2 animations:^{
        addDatePickerView.alpha = 1;
    }];
    
}
//查询click
- (IBAction)queryCarListClick:(id)sender {
    
    
    if (_fromCode.length == 0) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请先填写始发站"];
    }
    else if (_toCode.length == 0){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请先填写终点站"];
    }
    else if (_dateCode.length == 0){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请先选择出发日期"];
    }else{
        [_req checkTrainInfoBusfromStation:_fromCode toStation:_toCode transDate:[self removew:_dateCode] trainDate:_dateCode];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"车次查询中..."];
        
    }

    

}

-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (type == REQUSET_XZTK1003) {
        if (_listDataArray.count>0) {
            [_listDataArray removeAllObjects];
        }
        
        if ([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"]isEqualToString:@"000000"]) {
            NSArray *arr = [[dict objectForKey:@"REP_BODY"] objectForKey:@"data"];
            
            for (NSDictionary *dictt in arr) {
                 _trickListModel = [[TrickListInfoModel alloc] init];
                 [_trickListModel setValuesForKeysWithDictionary:dictt];
                [_listDataArray addObject:_trickListModel];
            }
            TrickChooseCarListViewController *chooseList = [[TrickChooseCarListViewController alloc] initWithNibName:@"TrickChooseCarListViewController" bundle:nil];
            chooseList.showDayStr = [self removewMD:_dateCode];
            chooseList.Yer = [self removewY:_dateCode];
            chooseList.dataArray = _listDataArray;
            chooseList.fromCode = _fromCode;
            chooseList.toCode = _toCode;
            chooseList.lastDay = _lastDay;
            [self.navigationController pushViewController:chooseList animated:YES];
            
          }
        else{
              [MBProgressHUD showHUDAddedTo:self.view WithString:[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_RSPMSG"]];
          }
    }
    
    
    
    
}
    

#pragma  mark - LFFAddPickerViewDelegate
-(void)hiddenLFFAddPickerView{
    [UIView animateWithDuration:0.2 animations:^{
        addPickerView.alpha = 0;
    }];
}

-(void)returnFromeLFFAddPickerInfo:(NSArray *)arr{
    _fromLab.text = arr[0];
    _fromCode = arr[1];
    
}
-(void)returnToLFFAddPickerInfo:(NSArray *)arr{
    _toLab.text = arr[0];
    _toCode = arr[1];
}

#pragma mark - lffpickerviewdelegate
-(void)changeAlphaHiden{
    [UIView animateWithDuration:0.2 animations:^{
        addDatePickerView.alpha = 0;
    }];
}
-(void)changeAlphaHiden:(NSString *)dateStr{
    if (addDatePickerView.Timetype ==1) {
        if ([[self removew:[addDatePickerView formatterDate:[NSDate date]]] integerValue] > [[self removew:dateStr] integerValue]) {
            [Common showMsgBox:@"" msg:@"不能购买今日之前的车票" parentCtrl:self];
        }else{
            _dateLab.text = dateStr;
            _dateCode = dateStr;
        }
    }
    [UIView animateWithDuration:0.2 animations:^{
        addDatePickerView.alpha = 0;
    }];
}

-(NSString*)removew:(NSString*)s{
    NSArray *arr = [s componentsSeparatedByString:@"-"];
    NSString *ss = [NSString stringWithFormat:@"%@%@%@",arr[0],arr[1],arr[2]];
    _lastDay = arr[2];
    return ss;
}

-(NSString*)removewMD:(NSString*)s{
    NSArray *arr = [s componentsSeparatedByString:@"-"];
    NSString *ss = [NSString stringWithFormat:@"%@-%@",arr[1],arr[2]];
    return ss;
}
-(NSString*)removewY:(NSString*)s{
    NSArray *arr = [s componentsSeparatedByString:@"-"];
    NSString *ss = [NSString stringWithFormat:@"%@",arr[0]];
    return ss;
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
