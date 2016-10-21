//
//  TrickChooseCarListViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/10.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TrickChooseCarListViewController.h"
#import "TrickTicketListCell.h"
#import "TicketDetailViewController.h"
#import "TrickListInfoModel.h"
@interface TrickChooseCarListViewController ()<UITableViewDelegate,UITableViewDataSource,ResponseData>
{
    NSInteger day;
    NSInteger mon;
    Request *_req;
    NSInteger _lasetDayInt;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TrickChooseCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"选择车次";
    [self isToday];
    
    
    
    
}
-(void)isToday{
    _lasetDayInt = [_lastDay integerValue];
    _req  = [[Request alloc] initWithDelegate:self];
    [self changeStrMDInt:_showDayStr];
    _showDatLab.text = [self changeStrMD: _showDayStr];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"TrickTicketListCell" bundle:nil] forCellReuseIdentifier:@"TrickTicketListCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
//前一天
- (IBAction)upDayClick:(id)sender {
    if (day == _lasetDayInt) {
        day = 31;
    }else{
        day -=1;
    }
    _showDatLab.text = [NSString stringWithFormat:@"%ld月-%@日",(long)mon,[NSString stringWithFormat:@"%ld",(long)day]];
    NSString *s = [NSString stringWithFormat:@"%@-%ld-%ld",_Yer,(long)mon,(long)day];
    NSString *ss =[NSString stringWithFormat:@"%@%ld%ld",_Yer,(long)mon,(long)day];
    [_req checkTrainInfoBusfromStation:_fromCode toStation:_toCode transDate:ss trainDate:s];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"车次查询中..."];

}

//后一天
- (IBAction)downDayClick:(id)sender {
    if (day == 31) {
        day = _lasetDayInt;
    }else{
        day +=1;
    }
  _showDatLab.text = [NSString stringWithFormat:@"%ld月-%@日",(long)mon,[NSString stringWithFormat:@"%ld",(long)day]];
    NSString *s = [NSString stringWithFormat:@"%@-%ld-%ld",_Yer,(long)mon,(long)day];
    NSString *ss =[NSString stringWithFormat:@"%@%ld%ld",_Yer,(long)mon,(long)day];
    [_req checkTrainInfoBusfromStation:_fromCode toStation:_toCode transDate:ss trainDate:s];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"车次查询中..."];
}

-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (type == REQUSET_XZTK1003) {
        if (_dataArray.count>0) {
            [_dataArray removeAllObjects];
        }
        if ([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"]isEqualToString:@"000000"]) {
            NSArray *arr = [[dict objectForKey:@"REP_BODY"] objectForKey:@"data"];
            for (NSDictionary *dictt in arr) {
                TrickListInfoModel *model = [[TrickListInfoModel alloc] init];
                [model setValuesForKeysWithDictionary:dictt];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        else{
            [_dataArray removeAllObjects];
            [_tableView reloadData];
            [Common showMsgBox:nil msg:[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_RSPMSG"] parentCtrl:self];
        }
    }

}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count ;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"TrickTicketListCell";
    TrickTicketListCell *cell  = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TicketDetailViewController *ticketDetail = [[TicketDetailViewController alloc] initWithNibName:@"TicketDetailViewController" bundle:nil];
    ticketDetail.navigationItem.title = [_dataArray[indexPath.row] train_code];
    ticketDetail.showDayStr =  _showDatLab.text;
    ticketDetail.detaiIinfoModel = _dataArray[indexPath.row];
    [self.navigationController pushViewController:ticketDetail animated:YES];
    
    
    
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

-(NSString*)changeStrMD:(NSString*)str{
    NSArray *arr = [str componentsSeparatedByString:@"-"];
    NSString *ss = [NSString stringWithFormat:@"%@月-%@日",arr[0],arr[1]];
    return ss;
    
}
-(void)changeStrMDInt:(NSString*)str{
    NSArray *arr = [str componentsSeparatedByString:@"-"];
    day =  [arr[1] integerValue];
    mon = [arr[0] integerValue];
}

@end
