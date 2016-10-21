//
//  TicketDetailViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/11.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TicketDetailViewController.h"
#import "TicketOrderViewController.h"
#import "TrickListInfoModel.h"

@interface TicketDetailViewController ()
{
    
}
@property (weak, nonatomic) IBOutlet UIButton *dayBeforeBtn;//前一天
@property (weak, nonatomic) IBOutlet UIButton *dayAfterBtn;//后一天
@property (weak, nonatomic) IBOutlet UILabel *dayInfoLab;//日期信息



@property (weak, nonatomic) IBOutlet UILabel *addfromlab;//起点
@property (weak, nonatomic) IBOutlet UILabel *addtoLab;//终点
@property (weak, nonatomic) IBOutlet UILabel *tiamFromLab;//起点时间
@property (weak, nonatomic) IBOutlet UILabel *timaToLab;//终点时间
@property (weak, nonatomic) IBOutlet UILabel *TicketLab;//车次
@property (weak, nonatomic) IBOutlet UILabel *dayFromLab;//起点日期
@property (weak, nonatomic) IBOutlet UILabel *dayToLab;//终点日期
@property (weak, nonatomic) IBOutlet UILabel *trickTimeLab;//旅行时间



//二等座
@property (weak, nonatomic) IBOutlet UILabel *moneyOne;  
@property (weak, nonatomic) IBOutlet UILabel *ticketCountOne;
@property (weak, nonatomic) IBOutlet UIButton *yudingBtn;

//一等座
@property (weak, nonatomic) IBOutlet UILabel *moneyTwo;
@property (weak, nonatomic) IBOutlet UILabel *ticketCountTwo;
@property (weak, nonatomic) IBOutlet UIButton *yudingBtn2;

//商务座
@property (weak, nonatomic) IBOutlet UILabel *moneyThree;
@property (weak, nonatomic) IBOutlet UILabel *ticketCountThree;
@property (weak, nonatomic) IBOutlet UIButton *qiangpiaoBtn;



@end

@implementation TicketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self info];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)info{
    _dayInfoLab.text = _showDayStr;
    _addfromlab.text = _detaiIinfoModel.from_station_name;
    _addtoLab.text = _detaiIinfoModel.to_station_name;
    _tiamFromLab.text = _detaiIinfoModel.start_time;
    _timaToLab.text = _detaiIinfoModel.arrive_time;
    _TicketLab.text = _detaiIinfoModel.train_code;
    _dayFromLab.text = [self addStr:[_detaiIinfoModel.train_start_date substringFromIndex:4]];
    _dayToLab.text = [self addStr:[NSString stringWithFormat:@"%ld",(long)([[_detaiIinfoModel.train_start_date substringFromIndex:4]integerValue]+[_detaiIinfoModel.arrive_days integerValue])]];
    _trickTimeLab.text = [self separStr:_detaiIinfoModel.run_time];
}

#pragma mark - btnAll
////前一天
//- (IBAction)befroDayClick:(id)sender {
//}
////后一天
//- (IBAction)afterDayClick:(id)sender {
//}

//二等座预定
- (IBAction)yudingClick1:(id)sender {
    TicketOrderViewController *order = [[TicketOrderViewController alloc] initWithNibName:@"TicketOrderViewController" bundle:nil];
    [self.navigationController pushViewController:order animated:YES];
    
}

//一等座预定
- (IBAction)yuding2Click:(id)sender {
}

//商务座抢票
- (IBAction)qiangpiaoClick:(id)sender {
    
}


-(NSString*)separStr:(NSString*)str{
    NSArray *arr =  [str componentsSeparatedByString:@":"];
    NSString *s = [NSString stringWithFormat:@"%@小时%@分",arr[0],arr[1]];
    return s;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSString*)changeStrMD:(NSString*)str{
    NSArray *arr = [str componentsSeparatedByString:@"-"];
    NSString *ss = [NSString stringWithFormat:@"%@月-%@日",arr[0],arr[1]];
    return ss;
    
}

-(NSString*)addStr:(NSString*)str{
    NSString *s1 = [str substringFromIndex:2];
    NSString *s2 = [str substringToIndex:2];
    NSString *s3 = [NSString stringWithFormat:@"%@月 - %@日",s2,s1];
    return s3;
}

@end
