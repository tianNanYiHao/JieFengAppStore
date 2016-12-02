//
//  TicketDetailViewController.h
//  QuickPos
//
//  Created by Lff on 16/10/11.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TrickListInfoModel;
@interface TicketDetailViewController : UIViewController

@property (nonatomic,strong) NSString *showDayStr;
@property (nonatomic,strong) TrickListInfoModel *detaiIinfoModel;
@property (weak, nonatomic) IBOutlet UIView *infoView;

@property (weak, nonatomic) IBOutlet UIView *chooseV1;
@property (weak, nonatomic) IBOutlet UIView *chooseV2;
@property (weak, nonatomic) IBOutlet UIView *chooseV3;

@end
