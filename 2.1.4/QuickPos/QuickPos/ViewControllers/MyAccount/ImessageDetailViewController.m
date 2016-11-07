//
//  ImessageDetailViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/11/3.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ImessageDetailViewController.h"

@interface ImessageDetailViewController ()


@property (weak, nonatomic) IBOutlet UILabel *ImessageTitleLabel;


@property (weak, nonatomic) IBOutlet UILabel *ImessageDataLabel;

@property (weak, nonatomic) IBOutlet UILabel *ImessageDetailLabel;



@end

@implementation ImessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息详情";
    
    self.ImessageTitleLabel.text = self.titleStr;
    self.ImessageDataLabel.text = self.DataStr;
    self.ImessageDetailLabel.text = self.DetailStr;
    
     self.ImessageDetailLabel.numberOfLines = 0;
     [self.ImessageDetailLabel sizeToFit];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
