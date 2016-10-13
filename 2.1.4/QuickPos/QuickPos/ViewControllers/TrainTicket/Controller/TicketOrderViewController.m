//
//  TicketOrderViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/12.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TicketOrderViewController.h"
#import "AddPersonInfoViewController.h"

@interface TicketOrderViewController ()
{
    NSMutableArray *_personInfoArr;
    
}
@end

@implementation TicketOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"订单填写";
    
    _personInfoArr = [[NSMutableArray alloc]init];
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
