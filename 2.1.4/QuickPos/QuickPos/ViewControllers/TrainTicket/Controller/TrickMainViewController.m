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

@interface TrickMainViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_pickerVIew;
    
}


@property (weak, nonatomic) IBOutlet UIButton *addressToBtn;
@property (weak, nonatomic) IBOutlet UIButton *addressFromeBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseDateBtn;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIButton *queryCarBtn;


@end

@implementation TrickMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"火车票";
    
    [self createPickerVIew];
    
}
- (void)createPickerVIew{
    _pickerVIew = [[UIPickerView alloc] initWithFrame:CGRectMake(15, 100, self.view.frame.size.width/2, self.view.frame.size.width/2)];
    _pickerVIew.delegate = self;
    _pickerVIew.dataSource = self;
    [self.view addSubview:_pickerVIew];
    _pickerVIew.alpha = 0;
    
}

//起点
- (IBAction)addressFromeClick:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _pickerVIew.alpha = 1;
        
    }];
    
}
//终点
- (IBAction)adressToClick:(id)sender {
}
//是否高铁/动车
- (IBAction)chooseFaseCar:(id)sender {
    
}

//选择日期按钮
- (IBAction)chooseDateBtnClick:(id)sender {
}
//查询click
- (IBAction)queryCarListClick:(id)sender {
    TrickChooseCarListViewController *chooseList = [[TrickChooseCarListViewController alloc] initWithNibName:@"TrickChooseCarListViewController" bundle:nil];
    [self.navigationController pushViewController:chooseList animated:YES];
}


#pragma mark - pickviewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataArray.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *name = [_dataArray[row] addName];
    return name;
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
