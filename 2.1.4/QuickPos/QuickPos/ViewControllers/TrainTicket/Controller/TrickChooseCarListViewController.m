//
//  TrickChooseCarListViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/10.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TrickChooseCarListViewController.h"
#import "TrickTicketListCell.h"


@interface TrickChooseCarListViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    
}
@property (weak, nonatomic) IBOutlet UIButton *beforeDayBtn; //前一天
@property (weak, nonatomic) IBOutlet UIButton *afterDayBtn;//后一天btn
@property (weak, nonatomic) IBOutlet UILabel *dayInfolab;//日期Lab
@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end

@implementation TrickChooseCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"选择车次";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"TrickTicketListCell" bundle:nil] forCellReuseIdentifier:@"TrickTicketListCell"];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10 ;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 5;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"TrickTicketListCell";
    TrickTicketListCell *cell  = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    return cell;
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
