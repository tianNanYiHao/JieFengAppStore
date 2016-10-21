//
//  TrickTicketListCell.h
//  QuickPos
//
//  Created by Lff on 16/10/11.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TrickListInfoModel;

@interface TrickTicketListCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *train_code1; //车次
@property (weak, nonatomic) IBOutlet UILabel *from_station_name1; //始发站
@property (weak, nonatomic) IBOutlet UILabel *to_station_name1;//终点站
@property (weak, nonatomic) IBOutlet UILabel *start_time1; //出发时刻

@property (weak, nonatomic) IBOutlet UILabel *arrive_time1; //到达时刻

@property (weak, nonatomic) IBOutlet UILabel *run_time1; //历时

@property (weak, nonatomic) IBOutlet UILabel *yw_price1; //(硬座票价 最低票价)
@property (weak, nonatomic) IBOutlet UILabel *ydz_num1; //一等座票数
@property (weak, nonatomic) IBOutlet UILabel *edz_num1;//二等座票数
@property (weak, nonatomic) IBOutlet UILabel *swz_num1;//商务座票数

@property (nonatomic,strong) TrickListInfoModel *model;


@end
