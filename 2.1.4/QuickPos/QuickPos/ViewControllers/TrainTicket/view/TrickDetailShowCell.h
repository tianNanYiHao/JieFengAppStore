//
//  TrickDetailShowCell.h
//  QuickPos
//
//  Created by Lff on 16/10/24.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrickDetailShowCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *chearLab;//座位类型

@property (weak, nonatomic) IBOutlet UILabel *moneyOne;
@property (weak, nonatomic) IBOutlet UILabel *ticketCountOne;
@property (weak, nonatomic) IBOutlet UIButton *yudingBtn;
@end