//
//  TickerOrderSureViewController.h
//  QuickPos
//
//  Created by Lff on 16/10/18.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TickerOrderSureViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *addfromlab;//起点
@property (weak, nonatomic) IBOutlet UILabel *addtoLab;//终点
@property (weak, nonatomic) IBOutlet UILabel *tiamFromLab;//起点时间
@property (weak, nonatomic) IBOutlet UILabel *timaToLab;//终点时间
@property (weak, nonatomic) IBOutlet UILabel *TicketLab;//车次
@property (weak, nonatomic) IBOutlet UILabel *dayFromLab;//起点日期
@property (weak, nonatomic) IBOutlet UILabel *dayToLab;//终点日期
@property (weak, nonatomic) IBOutlet UILabel *trickTimeLab;//旅行时间

@property (nonatomic,strong) NSString *addfrom;
@property (nonatomic,strong) NSString *addto;
@property (nonatomic,strong) NSString *timefrom;
@property (nonatomic,strong) NSString *timeto;
@property (nonatomic,strong) NSString *ticketKind;
@property (nonatomic,strong) NSString *dayFrom;
@property (nonatomic,strong) NSString *dayTo;
@property (nonatomic,strong) NSString *trickTime;

@property (nonatomic,strong) NSMutableArray *personArray;
@property (nonatomic,strong) NSArray *orderInfoArray;

@property (nonatomic,strong) NSString *personTickKind;
@property (nonatomic,strong) NSString *persionTickMoney;



@end
