//
//  TransferViewController.h
//  QuickPos
//
//  Created by 张倡榕 on 15/3/6.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TransferViewController : UIViewController
@property (nonatomic,retain)BankCardItem *bankCardItem;
@property (weak, nonatomic) IBOutlet UILabel *notes;
@property (retain, nonatomic) NSDictionary *item;

@end
