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
    _personInfoArr = [[NSMutableArray alloc]init];
    self.view.backgroundColor =  [Common hexStringToColor:@"e4e4e4"];
    _view3A4.backgroundColor =  [Common hexStringToColor:@"e4e4e4"];
    
    [self createScrollView];
    
    
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
        NSLog(@"===>>> %lu",(unsigned long)_personInfoArr.count);
        
        [UIView animateWithDuration:0.5 animations:^{
            _scrollViewBG.contentSize = CGSizeMake(0, _scrollViewBG.contentSize.height+50);
            _view3A4.y  = _view3A4.y+50;
        }];
         [self createPerSonInfosize:50*(_personInfoArr.count-1)+_view2.y+_view2.height];
        }];
    
    [self.navigationController pushViewController:perinfo animated:YES];
}

-(void)createPerSonInfosize:(NSInteger)size{
    UIView *listView = [[UIView alloc] initWithFrame:CGRectMake(0, size, self.view.frame.size.width, 50)];
    listView.backgroundColor = [UIColor whiteColor];
    [_scrollViewBG addSubview:listView];
    
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"间隔线1"]];
    line.frame = CGRectMake(15, 1, self.view.frame.size.width, 1);
    [listView addSubview:line];
    
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
