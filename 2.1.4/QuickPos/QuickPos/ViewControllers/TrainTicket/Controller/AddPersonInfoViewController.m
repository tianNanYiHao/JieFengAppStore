//
//  AddPersonInfoViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/12.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "AddPersonInfoViewController.h"

@interface AddPersonInfoViewController ()

@end

@implementation AddPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"添加乘车人";
    
    
}

-(void)comeBackBlock:(AddPersonBlock)blocK
{
    _block = blocK;
    
}
//完成按钮
- (IBAction)commitClick:(id)sender {
    
    _block(@"李四",@"320981199001051487");
    [self.navigationController popViewControllerAnimated:YES];
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
