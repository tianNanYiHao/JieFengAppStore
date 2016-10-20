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


@interface TrickMainViewController ()<LFFAddPickerViewDelegate,LFFPickerViewDelegate>
{
    
    LFFAddPickerView *addPickerView;
    LFFPickerVIew        *addDatePickerView;
    
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
    _dateLab.text = [addDatePickerView formatterDate:[NSDate date]];

    
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
    TrickChooseCarListViewController *chooseList = [[TrickChooseCarListViewController alloc] initWithNibName:@"TrickChooseCarListViewController" bundle:nil];
    [self.navigationController pushViewController:chooseList animated:YES];
}



#pragma  mark - LFFAddPickerViewDelegate
-(void)hiddenLFFAddPickerView{
    [UIView animateWithDuration:0.2 animations:^{
        addPickerView.alpha = 0;
    }];
}

-(void)returnFromeLFFAddPickerInfo:(NSArray *)arr{
    _fromLab.text = arr[0];
}
-(void)returnToLFFAddPickerInfo:(NSArray *)arr{
    _toLab.text = arr[0];
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
        }
    }
    [UIView animateWithDuration:0.2 animations:^{
        addDatePickerView.alpha = 0;
    }];
}

-(NSString*)removew:(NSString*)s{
    NSArray *arr = [s componentsSeparatedByString:@"-"];
    NSString *ss = [NSString stringWithFormat:@"%@%@%@",arr[0],arr[1],arr[2]];
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
