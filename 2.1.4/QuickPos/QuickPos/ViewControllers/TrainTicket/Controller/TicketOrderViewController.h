//
//  TicketOrderViewController.h
//  QuickPos
//
//  Created by Lff on 16/10/12.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketOrderViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *addfromlab;//起点
@property (weak, nonatomic) IBOutlet UILabel *addtoLab;//终点
@property (weak, nonatomic) IBOutlet UILabel *tiamFromLab;//起点时间
@property (weak, nonatomic) IBOutlet UILabel *timaToLab;//终点时间
@property (weak, nonatomic) IBOutlet UILabel *TicketLab;//车次
@property (weak, nonatomic) IBOutlet UILabel *dayFromLab;//起点日期
@property (weak, nonatomic) IBOutlet UILabel *dayToLab;//终点日期
@property (weak, nonatomic) IBOutlet UILabel *trickTimeLab;//旅行时间

@end
