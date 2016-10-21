//
//  TrickTicketListCell.m
//  QuickPos
//
//  Created by Lff on 16/10/11.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TrickTicketListCell.h"
#import "TrickListInfoModel.h"

@implementation TrickTicketListCell

//@synthesize train_code;
//@synthesize from_station_name;
//@synthesize to_station_name;
//@synthesize start_time;
//@synthesize arrive_time;
//@synthesize run_time;
//@synthesize yw_price;
//@synthesize ydz_num;
//@synthesize edz_num;
//@synthesize swz_num;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(TrickListInfoModel *)model{
    _model = model;
    
    _train_code1.text = _model.train_code;
    _from_station_name1.text = _model.from_station_name;
    _to_station_name1.text = _model.to_station_name;
    _start_time1.text = _model.start_time;
    _arrive_time1.text = _model.arrive_time;
    _run_time1.text = [self separStr:_model.run_time];
    _yw_price1.text = _model.yw_price;
    _ydz_num1.text = _model.ydz_num;
    _edz_num1.text = _model.edz_num;
    _swz_num1.text = _model.swz_num;
}
-(NSString*)separStr:(NSString*)str{
  NSArray *arr =  [str componentsSeparatedByString:@":"];
    NSString *s = [NSString stringWithFormat:@"%@小时%@分",arr[0],arr[1]];
    return s;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
