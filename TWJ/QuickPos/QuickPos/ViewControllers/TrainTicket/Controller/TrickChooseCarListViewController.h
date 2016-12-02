//
//  TrickChooseCarListViewController.h
//  QuickPos
//
//  Created by Lff on 16/10/10.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrickChooseCarListViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *upDayBtn;
@property (weak, nonatomic) IBOutlet UIButton *downDayBtn;
@property (weak, nonatomic) IBOutlet UILabel *showDatLab;

@property (nonatomic,strong) NSString * showDayStr;
@property (nonatomic,strong) NSString * Yer;
@property (nonatomic,strong) NSString * lastDay;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSString *fromCode;
@property (nonatomic,strong) NSString *toCode;



@end
