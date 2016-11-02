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

@property (nonatomic,strong) NSString *addfrom;
@property (nonatomic,strong) NSString *addto;
@property (nonatomic,strong) NSString *timefrom;
@property (nonatomic,strong) NSString *timeto;
@property (nonatomic,strong) NSString *ticketKind;
@property (nonatomic,strong) NSString *dayFrom;
@property (nonatomic,strong) NSString *dayTo;
@property (nonatomic,strong) NSString *trickTime;


@property (nonatomic,strong) NSArray *ticketPriceArr;
@property (nonatomic,strong) NSString *ticketInfo; //票务信息str
@property (nonatomic,strong) NSMutableArray *ticekMoneyArr; //坐席数据
@property (nonatomic,assign) NSInteger indexRow;





@property (weak, nonatomic) IBOutlet UILabel *ticketInfoLab;//票务信息
@property (weak, nonatomic) IBOutlet UIImageView *addPersonBtn; //添加    imageView
@property (weak, nonatomic) IBOutlet UIButton *addPersonbtn;//添加    btn



@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;//手机号码
@property (weak, nonatomic) IBOutlet UIButton *chooseTicketTimeBtn;//抢票截止时间按钮


@property (weak, nonatomic) IBOutlet UILabel *moneyAll;//总额
@property (weak, nonatomic) IBOutlet UILabel *personAll;//总人数




@end
