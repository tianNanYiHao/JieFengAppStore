//
//  TrickInfoModel.m
//  QuickPos
//
//  Created by Lff on 16/10/20.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TrickListInfoModel.h"

@implementation TrickListInfoModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(NSMutableArray*)ticketKindWitNum{
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arrNameM = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arrNumM = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arrpriceM = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *arrrNum = @[_tdz_num,_swz_num,_ydz_num,_edz_num,_gjrw_num,_rw_num,_yw_num,_rz_num,_yz_num,_wz_num,_qtxb_num];
    NSArray *arrrPrice = @[_tdz_price,_swz_price,_ydz_price,_edz_price,_gjrw_price,_rw_price,_yw_price,_rz_price,_yz_price,_wz_price,_qtxb_price];
    NSArray *arrrName =  @[@"特等座",@"商务座",@"一等座",@"二等座",@"高级软卧",@"软卧",@"硬卧",@"软座",@"硬座",@"无座",@"其他席别"];
    
    for (int i = 0; i<arrrNum.count; i++) {
        if (![arrrNum[i] isEqualToString:@"--"]) {
                [arrNameM addObject:arrrName[i]];
                [arrNumM addObject:arrrNum[i]];
                [arrpriceM addObject:arrrPrice[i]];
        }
    }
    [arrM addObject:arrNameM];
    [arrM addObject:arrNumM];
    [arrM addObject:arrpriceM];
    return arrM;
}
@end
