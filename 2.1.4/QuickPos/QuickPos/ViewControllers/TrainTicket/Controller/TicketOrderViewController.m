//
//  TicketOrderViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/12.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TicketOrderViewController.h"
#import "AddPersonInfoViewController.h"


@interface TicketOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_personInfoArr;
    UITableView *_tableview;
    UIScrollView *_scrollViewBG;
    
    
}
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *upview;

@end

@implementation TicketOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"订单填写";
    _personInfoArr = [[NSMutableArray alloc]init];

    [self createScrollView];
    
    
}
-(void)createScrollView{
    
    _scrollViewBG = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    _scrollViewBG.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_scrollViewBG];
    _scrollViewBG.scrollEnabled = YES;
    _scrollViewBG.contentSize = CGSizeMake(0, self.view.frame.size.height+10);
    
    [_scrollViewBG addSubview:_infoView];
    [_scrollViewBG addSubview:_view1];
    [_scrollViewBG addSubview:_view2];
    [_scrollViewBG addSubview:_view3];
    [_scrollViewBG addSubview:_view4];
    [_scrollViewBG addSubview:_upview];

    
    [_scrollViewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_offset(self.view.frame.size.width);
        make.height.mas_offset(self.view.frame.size.height);
    }];
}
#pragma mark - btnClick
//点击选可售票
- (IBAction)chooseTicketClick:(id)sender {
    PSTAlertController *psta = [PSTAlertController alertControllerWithTitle:nil message:@"请选择您的坐席信息" preferredStyle:PSTAlertControllerStyleActionSheet];
    NSArray *arr  = @[@"二等座¥250",@"一等座¥553",@"商务座¥990"];
    for (int i= 0; i<arr.count; i++) {
        [psta addAction:[PSTAlertAction actionWithTitle:arr[i] handler:^(PSTAlertAction * _Nonnull action) {
            _ticketInfoLab.text = arr[i];
        }]];
    }
    [psta showWithSender:nil controller:self animated:YES completion:NULL];
    
}
//点击选择抢票截止时间
- (IBAction)chooseTicketTimeClick:(id)sender {
}
//提交订单
- (IBAction)upOrderClick:(id)sender {
}
//添加乘客信息
- (IBAction)addPersonClick:(id)sender {
    AddPersonInfoViewController *perinfo = [[AddPersonInfoViewController alloc] initWithNibName:@"AddPersonInfoViewController" bundle:nil];
    [perinfo comeBackBlock:^(NSString *name, NSString *perSonID) {
        NSLog(@"%@ = %@",name,perSonID);
        [_personInfoArr addObject:name];
    }];
    [self.navigationController pushViewController:perinfo animated:YES];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_personInfoArr.count>5) {
        [Common showMsgBox:nil msg:@"仅限添加5位乘车人信息" parentCtrl:self];
        _addPersonBtn.hidden = YES;
        _addPersonbtn.hidden = YES;
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
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
