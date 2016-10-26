//
//  AddPersonInfoViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/12.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "AddPersonInfoViewController.h"
#define textABC @"123456789QWERTYUIOPLKJHGFDSAZXCVBNMqwertyuiopasdfghjklmnbvcxz"

@interface AddPersonInfoViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *personIDText;

@end

@implementation AddPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"添加乘车人";
    _nameText.keyboardType = UIKeyboardTypeDefault;
    _nameText.delegate = self;
    _nameText.tag = 1001;
    _personIDText.keyboardType = UIKeyboardTypeDefault;

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *charer = [NSCharacterSet characterSetWithCharactersInString:textABC];
    NSString *filed  = [[string componentsSeparatedByCharactersInSet:charer] componentsJoinedByString:@""];
    if (textField.tag == 1001) {
        if ([filed isEqualToString:string]) {
            return YES;
        }
        return NO;
    }
    return nil;
}
-(void)comeBackBlock:(AddPersonBlock)blocK
{
    _block = blocK;
}
//完成按钮
- (IBAction)commitClick:(id)sender {
    if (_nameText.text.length == 0) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入乘客姓名"];
    }else if (_personIDText.text.length == 0){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入乘客身份证"];
    }else{
        _block(_nameText.text,_personIDText.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
   
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
