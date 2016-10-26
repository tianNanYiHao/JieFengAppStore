//
//  AddPersonInfoViewController.m
//  QuickPos
//
//  Created by Lff on 16/10/12.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "AddPersonInfoViewController.h"
#import "RadioButton.h"
#define textABC @"123456789QWERTYUIOPLKJHGFDSAZXCVBNMqwertyuiopasdfghjklmnbvcxz"

@interface AddPersonInfoViewController ()<UITextFieldDelegate>
{
    NSInteger indexKind;
    
}
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *personIDText;
@property (weak, nonatomic) IBOutlet RadioButton *btn1;
@property (weak, nonatomic) IBOutlet RadioButton *btn2;
@property (weak, nonatomic) IBOutlet RadioButton *btn3;
@property (weak, nonatomic) IBOutlet RadioButton *btn4;

@end

@implementation AddPersonInfoViewController
- (IBAction)chooseTicketKind:(RadioButton*)sender {
    if (sender.tag == 1) {
        indexKind = _btn1.tag;
    }
    if (sender.tag == 2) {
        indexKind = _btn1.tag;
    }
    if (sender.tag == 3) {
        indexKind = _btn1.tag;
    }
    if (sender.tag == 4) {
        indexKind = _btn1.tag;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"添加乘车人";
    _nameText.keyboardType = UIKeyboardTypeDefault;
    _nameText.delegate = self;
    _nameText.tag = 1001;
    _personIDText.keyboardType = UIKeyboardTypeDefault;
    
    _btn1.groupButtons = @[_btn1,_btn2,_btn3,_btn4];
    _btn1.selected = YES;
    indexKind = _btn1.tag;
    
    
    
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
