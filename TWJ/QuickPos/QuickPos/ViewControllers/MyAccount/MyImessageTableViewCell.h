//
//  MyImessageTableViewCell.h
//  QuickPos
//
//  Created by feng Jie on 16/11/3.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ImessageImageView;//消息列表图片

@property (weak, nonatomic) IBOutlet UILabel *ImessageLabel;//消息title

@property (weak, nonatomic) IBOutlet UILabel *DateLabel;//消息日期

@property (weak, nonatomic) IBOutlet UILabel *ImessageDetailLabel;//消息详情



@end
