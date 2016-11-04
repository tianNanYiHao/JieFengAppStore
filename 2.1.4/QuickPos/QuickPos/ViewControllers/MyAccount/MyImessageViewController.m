//
//  MyImessageViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/11/3.
//  Copyright © 2016年 张倡榕. All rights reserved.
//
#import "MyImessageViewController.h"
#import "MyImessageTableViewCell.h"
#import "Common.h"
#import "MJRefresh.h"
#import "BoRefreshHeader.h"
#import "BoRefreshAutoStateFooter.h"
#import "ImessageDetailViewController.h"

@interface MyImessageViewController ()<UITableViewDelegate,UITableViewDataSource,ResponseData>
{
    NSMutableArray *ImessageArray;//消息列表数据源
    
    NSUserDefaults *userDefaults;//储存
    
    NSString *firstMsgId;//第一条ID
    
    NSString *lastMsgId;//最后条ID
    
    NSString *oldMsgId;//旧ID
    
    int loadType; // 0 = 初始  1 = 加载新   2 = 加载旧
    
    Request *request;
    
    NSTimer *timer;//延迟显示
    
//    NSString *data;
}

@property (weak, nonatomic) IBOutlet UITableView *ImessageTabelView;

@property (strong, nonatomic) IBOutlet UIView *ImessageView;

@end

@implementation MyImessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    
    [self creatImessageTableView];//tableView
    [self downloadData];//加载数据
    ImessageArray = [NSMutableArray array];
    request = [[Request alloc]initWithDelegate:self];
    [request msgList:@"0" andLastMsgID:@"0" andRequestType:@"02"];
    self.ImessageTabelView.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(Dropdown)];
    self.ImessageTabelView.footer = [BoRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(Updown)];
}

- (void)creatImessageTableView
{
    self.ImessageTabelView.delegate = self;
    self.ImessageTabelView.dataSource = self;
    [self.view addSubview:self.ImessageTabelView];

}
- (void)downloadData
{
    loadType = 0;
    [request msgList:@"0" andLastMsgID:@"0" andRequestType:@"02"];
}
//下拉刷新
- (void)Dropdown{
    
    loadType = 1;
    if (firstMsgId == nil) {
        [request msgList:@"0" andLastMsgID:@"0" andRequestType:@"02"];
    }else
    {
        [request msgList:firstMsgId andLastMsgID:@"0" andRequestType:@"02"];
    }
}
//上拉加载
- (void)Updown
{
    loadType = 2;
    if (lastMsgId == nil) {
        [request msgList:@"0" andLastMsgID:@"0" andRequestType:@"02"];
    }else
    {
        [request msgList:@"0" andLastMsgID:lastMsgId andRequestType:@"02"];
    }
}
- (void)promptData:(BOOL)hiddenValue{
    UIImageView *smallBell = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-52)/2,150,52,69)];
    smallBell.image = [UIImage imageNamed:@"no_message"];
    [self.ImessageTabelView addSubview:smallBell];
    //    smallBell.hidden = YES;
    smallBell.hidden = hiddenValue;
    UILabel *smallLanguage = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(smallBell.frame)+24,SCREEN_WIDTH,15)];
    smallLanguage.font = [UIFont systemFontOfSize:15];
    smallLanguage.text = @"你还没有消息哦！";
    smallLanguage.textColor = RGB(153, 153, 153);;
    smallLanguage.textAlignment = NSTextAlignmentCenter;
    [self.ImessageTabelView addSubview:smallLanguage];
    //    smallLanguage.hidden = YES;
    smallLanguage.hidden = hiddenValue;
}
- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
    //列表数组
    NSArray *msgArr = [[dict objectForKey:@"data"] objectForKey:@"msgList"];
    //无记录返回取值
    NSDictionary *resultDic = [[dict objectForKey:@"data"] objectForKey:@"result"];
    if([resultDic[@"resultCode"] isEqual:@"8895"]){
        timer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(showMBP) userInfo:nil repeats:NO];
        [self promptData:NO];
    }else if([dict[@"respCode"] isEqual:@"0000"]){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.ImessageTabelView.scrollEnabled = YES;
        [self promptData:YES];
        //初始返回
        if(loadType == 0){
        [ImessageArray addObjectsFromArray:msgArr];
        }
        //下拉
        else if (loadType == 1)
        {
            int index = 0;
            for (NSDictionary *DI in msgArr) {
                [ImessageArray insertObject:DI atIndex:index];
                index++;
                [self.ImessageTabelView.header endRefreshing];
            }
            [self.ImessageTabelView.header endRefreshing];
        }
        //上拉
        else if (loadType == 2)
        {
            [ImessageArray addObjectsFromArray:msgArr];
            [self.ImessageTabelView.footer endRefreshing];
            lastMsgId = [[ImessageArray lastObject] objectForKey:@"msgID"];
        }
        if (ImessageArray.count != 0) {
            firstMsgId = [[ImessageArray firstObject] objectForKey:@"msgID"];
            lastMsgId = [[ImessageArray lastObject] objectForKey:@"msgID"];
            [userDefaults setObject:firstMsgId forKey:oldMsgId];
        }
        [self.ImessageTabelView.footer endRefreshing];
        [self.ImessageTabelView reloadData];
    }
}
#pragma mark ------ UITableViewDelegate ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ImessageArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyImessageTableViewCell";
    MyImessageTableViewCell *ImessageCell = (MyImessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
     NSDictionary *dic = ImessageArray[indexPath.row];
    if (ImessageCell == nil) {
        ImessageCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else
    {
        if([dic[@"msgTitle"] isEqual:@""]){
            ImessageCell.ImessageLabel.text = L(@"NoTitle");
        }else{
            ImessageCell.ImessageLabel.text = dic[@"msgTitle"];
        }
        if([dic[@"msgDetial"] isEqual:@""]){
            ImessageCell.ImessageDetailLabel.text = L(@"NoTitle");
        }else{
            ImessageCell.ImessageDetailLabel.text = dic[@"msgDetial"];
        }
        //修改时间的现实格式
        NSMutableString *dateStr = [[NSMutableString alloc]initWithString:dic[@"sendTime"]];
        [dateStr insertString:@"-" atIndex:4];
        [dateStr insertString:@"-" atIndex:7];
        [dateStr insertString:@"-" atIndex:10];
        [dateStr insertString:@":" atIndex:13];
        NSString *date = [dateStr substringToIndex:16];
        ImessageCell.DateLabel.text = date;
        [self.ImessageTabelView addSubview:ImessageCell];
    }
    return ImessageCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ImessageDetailViewController *ImessageDetailVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ImessageDetailViewController"];
    
    NSDictionary *dict = ImessageArray[indexPath.row];
    ImessageDetailVc.titleStr = dict[@"msgTitle"];
    ImessageDetailVc.DetailStr = dict[@"msgDetial"];
    
    NSMutableString *dateStr = [[NSMutableString alloc]initWithString:dict[@"sendTime"]];
    [dateStr insertString:@"-" atIndex:4];
    [dateStr insertString:@"-" atIndex:7];
    [dateStr insertString:@"-" atIndex:10];
    [dateStr insertString:@":" atIndex:13];
    NSString *date = [dateStr substringToIndex:16];
    ImessageDetailVc.DataStr = date;

    [self.navigationController pushViewController:ImessageDetailVc animated:YES];
    
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
