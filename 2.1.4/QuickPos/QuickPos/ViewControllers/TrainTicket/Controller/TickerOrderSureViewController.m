//
//  TickerOrderSureViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/18.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TickerOrderSureViewController.h"

@interface TickerOrderSureViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableiveW;

@end

@implementation TickerOrderSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"订单确认";
    
    
    
    

}


//确认支付
- (IBAction)surePayClick:(id)sender {
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
