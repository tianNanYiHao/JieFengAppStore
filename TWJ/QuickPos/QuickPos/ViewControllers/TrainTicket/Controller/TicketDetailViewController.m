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
#import "TrickDetailShowCell.h"
@interface TicketDetailViewController ()<UITableViewDelegate,UITableViewDataSource,TrickDetailShowCellDelegate>
{
    UITableView *_tirckDetailTableview;
    NSMutableArray *_ticketKindArray;
    
    
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
//注入
-(void)info{
    _chooseV1.hidden = YES;
    _chooseV2.hidden = YES;
    _chooseV3.hidden = YES;
    
    
    
    _dayInfoLab.text = _showDayStr;
    _addfromlab.text = _detaiIinfoModel.from_station_name;
    _addtoLab.text = _detaiIinfoModel.to_station_name;
    _tiamFromLab.text = _detaiIinfoModel.start_time;
    _timaToLab.text = _detaiIinfoModel.arrive_time;
    _TicketLab.text = _detaiIinfoModel.train_code;
    _dayFromLab.text = [self addStr:[_detaiIinfoModel.train_start_date substringFromIndex:4]];
    _dayToLab.text = [self addStr:[NSString stringWithFormat:@"%ld",(long)([[_detaiIinfoModel.train_start_date substringFromIndex:4]integerValue]+[_detaiIinfoModel.arrive_days integerValue])]];
    _trickTimeLab.text = [self separStr:_detaiIinfoModel.run_time];
    
    
    //判断车票类型+构建数据源
    _ticketKindArray = [NSMutableArray arrayWithCapacity:0];
    _ticketKindArray =  [_detaiIinfoModel ticketKindWitNum];

    _tirckDetailTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NEWWIDTH, _ticketKindArray.count*50)];
    _tirckDetailTableview.delegate = self;
    _tirckDetailTableview.dataSource = self;
    [_tirckDetailTableview registerNib:[UINib nibWithNibName:@"TrickDetailShowCell" bundle:nil] forCellReuseIdentifier:@"TrickDetailShow"];
    _tirckDetailTableview.scrollEnabled = NO;
    [self.view addSubview:_tirckDetailTableview];
    
    [_tirckDetailTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_chooseV1.mas_left);
        make.width.mas_offset(NEWWIDTH);
        make.top.mas_equalTo(_infoView.maxY+20);
        make.height.mas_offset([_ticketKindArray[0] count]*50);
    }];
    
}



#pragma mark - btnAll
////前一天
//- (IBAction)befroDayClick:(id)sender {
//}
////后一天
//- (IBAction)afterDayClick:(id)sender {
//}



#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_ticketKindArray[0] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SS = @"TrickDetailShow";
    
    TrickDetailShowCell *cell = [tableView dequeueReusableCellWithIdentifier:SS forIndexPath:indexPath];
    
    NSArray *namearr =  _ticketKindArray[0];
    NSArray *numarr =  _ticketKindArray[1];
    NSArray *pricearr =  _ticketKindArray[2];
    
    cell.chearLab.text = namearr[indexPath.row];
    cell.moneyOne.text = pricearr[indexPath.row];
    cell.ticketCountOne.text =[NSString stringWithFormat:@"%@ 张",numarr[indexPath.row]];
    cell.yudingBtn.tag = indexPath.row+1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}
#pragma mark - tirckDetaiShowCellDelegate
-(void)trickDetailShowBtnClickYuDing:(NSInteger)index{
    NSInteger indexRow = index-1;
    NSArray *namearr =  _ticketKindArray[0];
    NSArray *pricearr =  _ticketKindArray[2];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i<namearr.count;  i++  ) {
        NSString *s = [NSString new];
        s = [NSString stringWithFormat:@"%@ ¥%@",namearr[i],pricearr[i]];
        [arrM addObject:s];
    }
    
    
    
    TicketOrderViewController *order = [[TicketOrderViewController alloc] initWithNibName:@"TicketOrderViewController" bundle:nil];
    
    order.addfrom =  _addfromlab.text;
    order.addto = _addtoLab.text;
    order.timefrom = _tiamFromLab.text;
    order.timeto = _timaToLab.text;
    order.ticketKind = _TicketLab.text;
    order.dayFrom = _dayFromLab.text;
    order.dayTo = _dayToLab.text;
    order.trickTime = _trickTimeLab.text;
    order.ticketPriceArr = _ticketKindArray[2];
    order.ticketInfo = [NSString stringWithFormat:@"%@ ¥%@",namearr[indexRow],pricearr[indexRow]];
    order.indexRow = indexRow;
    order.ticekMoneyArr = arrM;
    [self.navigationController pushViewController:order animated:YES];
    
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
