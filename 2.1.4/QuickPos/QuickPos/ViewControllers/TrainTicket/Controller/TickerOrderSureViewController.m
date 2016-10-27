//
//  TickerOrderSureViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/18.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TickerOrderSureViewController.h"
#import "TrickPersonInfoCell.h"
#import "TrickOrderCell.h"


@interface TickerOrderSureViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableiveW;

@end

@implementation TickerOrderSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"订单确认";
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
    [self infoIN];
    [self tableviewAdd];
    
}
-(void)infoIN{
    _addfromlab.text = _addfrom;
    _addtoLab.text = _addto;
    _tiamFromLab.text = _timefrom;
    _timaToLab.text = _timeto;
    _TicketLab.text = _ticketKind;
    _dayFromLab.text = _dayFrom;
    _dayToLab.text = _dayTo;
    _trickTimeLab.text = _trickTime;
}
-(void)tableviewAdd{
    _tableiveW.delegate = self;
    _tableiveW.dataSource = self;
    _tableiveW.backgroundColor = [Common hexStringToColor:@"e4e4e4"];
    [_tableiveW registerNib:[UINib nibWithNibName:@"TrickPersonInfoCell" bundle:nil] forCellReuseIdentifier:@"TrickPersonInfoCell"];
    [_tableiveW registerNib:[UINib nibWithNibName:@"TrickOrderCell" bundle:nil] forCellReuseIdentifier:@"TrickOrderCell"];
    
}

#pragma mark - tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _personArray.count;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 1;
    }
    return 0;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [UIView new];
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NEWWIDTH, 30)];
    [v setBackgroundColor:[Common hexStringToColor:@"e4e4e4"]];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15,0,v.width,v.height)];
    [labelTitle setBackgroundColor:[Common hexStringToColor:@"e4e4e4"]];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.font = [UIFont systemFontOfSize:12];
    labelTitle.textColor = [UIColor darkGrayColor];
    if (section == 0) {
        labelTitle.text = @"乘车人";
    }else if (section == 1){
         labelTitle.text = @"订单信息";
    }
    [v addSubview:labelTitle];
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 69;
    }else if (indexPath.section == 1){
        return 50;
    }else if (indexPath.section == 2){
        return 50;
    }
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *iddPerson = @"TrickPersonInfoCell";
        TrickPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:iddPerson forIndexPath:indexPath];
        
        cell.personNameLab.text = [_personArray[indexPath.row] objectForKey:@"name"];
        cell.persionIDDLab.text = [NSString stringWithFormat:@"身份证:%@", [_personArray[indexPath.row] objectForKey:@"perSonID"]];
        cell.personTicketKind.text = _personTickKind;
        cell.personMoneyLab.text = _persionTickMoney;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        static NSString *iddOrder = @"TrickOrderCell";
        TrickOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:iddOrder forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
             cell.orderTitleLab.text = @"订单号";
             cell.orderInfoLab.text = @"20160508784516";
        }
        if (indexPath.row == 1) {
             cell.orderTitleLab.text = @"联系人";
             cell.orderInfoLab.text = @"张大大";
        }
        if (indexPath.row == 2) {
             cell.orderTitleLab.text = @"手机号";
             cell.orderInfoLab.text = @"180187181847";
        }
        return cell;
        
    }else if (indexPath.section == 2){
        static NSString *iddOrder = @"TrickOrderCell";
        TrickOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:iddOrder forIndexPath:indexPath];
        cell.orderTitleLab.text = @"支付金额";
        cell.orderInfoLab.text = @"¥ 500";
        cell.orderInfoLab.textColor = [UIColor redColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
    
}





//确认支付
- (IBAction)surePayClick:(id)sender {
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
