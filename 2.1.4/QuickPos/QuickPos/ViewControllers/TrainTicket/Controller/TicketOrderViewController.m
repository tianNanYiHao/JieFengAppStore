//
//  TicketOrderViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/12.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TicketOrderViewController.h"
#import "AddPersonInfoViewController.h"
#import "TickerOrderSureViewController.h"

@interface TicketOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_personInfoArr;
    UITableView *_tableview;
    UIScrollView *_scrollViewBG;
    UITableView * personTableView;
    
    
}
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3A4;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *upview;

@end

@implementation TicketOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"订单填写";
    [self infoIN];
    
    _personInfoArr = [[NSMutableArray alloc]init];
    self.view.backgroundColor =  [Common hexStringToColor:@"e4e4e4"];
    _view3A4.backgroundColor =  [Common hexStringToColor:@"e4e4e4"];

    [self createScrollView];
    
    
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
    _ticketInfoLab.text = _ticketInfo;
    

}

-(void)createScrollView{
    
    _scrollViewBG = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    _scrollViewBG.backgroundColor = [Common hexStringToColor:@"e4e4e4"];
    [self.view addSubview:_scrollViewBG];
    _scrollViewBG.scrollEnabled = YES;
    _scrollViewBG.contentSize = CGSizeMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height-104);
    
    
    [_scrollViewBG addSubview:_infoView];
    [_scrollViewBG addSubview:_view1];
    [_scrollViewBG addSubview:_view2];
    [_scrollViewBG addSubview:_view3A4];

    [_scrollViewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_offset(self.view.frame.size.width);
        make.height.mas_offset([UIApplication sharedApplication].keyWindow.frame.size.height-114);
        
    }];
}
#pragma mark - btnClick
//点击选可售票
- (IBAction)chooseTicketClick:(id)sender {
    PSTAlertController *psta = [PSTAlertController alertControllerWithTitle:nil message:@"请选择您的坐席信息" preferredStyle:PSTAlertControllerStyleActionSheet];
    for (int i= 0; i<_ticekMoneyArr.count; i++) {
        [psta addAction:[PSTAlertAction actionWithTitle:_ticekMoneyArr[i] handler:^(PSTAlertAction * _Nonnull action) {
            _ticketInfoLab.text = _ticekMoneyArr[i];
           [self getMoneyAllPersonAll];
        }]];
    }
    [psta showWithSender:nil controller:self animated:YES completion:NULL];
    
}
//点击选择抢票截止时间
- (IBAction)chooseTicketTimeClick:(id)sender {
}
//提交订单
- (IBAction)upOrderClick:(id)sender {
    TickerOrderSureViewController *sure = [[TickerOrderSureViewController alloc] initWithNibName:@"TickerOrderSureViewController" bundle:nil];
    [self.navigationController pushViewController:sure animated:YES];
    
    
}
//添加乘客信息
- (IBAction)addPersonClick:(id)sender {
    
    AddPersonInfoViewController *perinfo = [[AddPersonInfoViewController alloc] initWithNibName:@"AddPersonInfoViewController" bundle:nil];
    [perinfo comeBackBlock:^(NSString *name, NSString *perSonID) {
        NSDictionary * dict = [NSDictionary new];
         dict =  @{@"name":name,@"perSonID":perSonID};
        [_personInfoArr addObject:dict];
        if (personTableView) {
            [personTableView removeFromSuperview];
        }
        [self getMoneyAllPersonAll];
        personTableView = [[UITableView alloc] init];
        personTableView.delegate = self;
        personTableView.dataSource = self;
        personTableView.frame = CGRectMake(0, _view2.maxY+1, _view2.width, _personInfoArr.count*69);
        [_scrollViewBG addSubview:personTableView];

        [personTableView reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            _scrollViewBG.contentSize = CGSizeMake(0, _scrollViewBG.contentSize.height+69);
            _view3A4.y  = _view3A4.y+69;
        }];
        }];
    
    [self.navigationController pushViewController:perinfo animated:YES];
}
-(void)getMoneyAllPersonAll{
    NSString *s = [_ticketInfoLab.text componentsSeparatedByString:@"¥"][1];
    float f = [s floatValue];
    _moneyAll.text = [NSString stringWithFormat:@"¥ %.1f", f *_personInfoArr.count];
    _personAll.text = [NSString stringWithFormat:@"%ld 人",(long)_personInfoArr.count];
}
#pragma  mark - tabledelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _personInfoArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ind = @"ididid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ind];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ind];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = [_personInfoArr[indexPath.row] objectForKey:@"name"] ;
    cell.detailTextLabel.text = [_personInfoArr[indexPath.row] objectForKey:@"perSonID"] ;
    cell.detailTextLabel.font  = [UIFont systemFontOfSize:12];
    return cell;

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_personInfoArr removeObjectAtIndex:indexPath.row];
        [self getMoneyAllPersonAll];
        [personTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [personTableView reloadData];
        
        [UIView animateWithDuration:0.2 animations:^{
            _scrollViewBG.contentSize = CGSizeMake(0, _scrollViewBG.contentSize.height-69);
            _view3A4.y  = _view3A4.y-69;
            personTableView.height -= 69;
        }];
            _addPersonBtn.hidden = NO;
            _addPersonbtn.hidden = NO;
    }
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_personInfoArr.count == 5) {
        _addPersonBtn.hidden = YES;
        _addPersonbtn.hidden = YES;
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
