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


@property (weak, nonatomic) IBOutlet UILabel *train_code; //车次
@property (weak, nonatomic) IBOutlet UILabel *from_station_name; //始发站
@property (weak, nonatomic) IBOutlet UILabel *to_station_name;//终点站
@property (weak, nonatomic) IBOutlet UILabel *start_time; //出发时刻

@property (weak, nonatomic) IBOutlet UILabel *arrive_time; //到达时刻

@property (weak, nonatomic) IBOutlet UILabel *run_time; //历时

@property (weak, nonatomic) IBOutlet UILabel *yw_price; //(硬座票价 最低票价)
@property (weak, nonatomic) IBOutlet UILabel *ydz_num; //一等座票数
@property (weak, nonatomic) IBOutlet UILabel *edz_num;//二等座票数
@property (weak, nonatomic) IBOutlet UILabel *swz_num;//商务座票数

@property (nonatomic,strong) TrickListInfoModel *model;


@end
