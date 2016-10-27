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

@interface AddPersonInfoViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger indexKind;
    UIPickerView *_pickerView;
    NSArray *arr;
    NSArray *arrCode;
    
}
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *personIDText;
@property (weak, nonatomic) IBOutlet UILabel *perSonIDKindLab;
@property (nonatomic,strong) NSString *perSonKindStr;
@property (nonatomic,strong) NSString *perSonTickeNameStr;
@property (weak, nonatomic) IBOutlet RadioButton *btn1;
@property (weak, nonatomic) IBOutlet RadioButton *btn2;
@property (weak, nonatomic) IBOutlet RadioButton *btn3;
@property (weak, nonatomic) IBOutlet RadioButton *btn4;

@end

@implementation AddPersonInfoViewController
- (IBAction)chooseTicketKind:(RadioButton*)sender {
    if (sender.tag == 1) {
        indexKind = _btn1.tag;
        _perSonTickeNameStr = _btn1.titleLabel.text;
    }
    if (sender.tag == 2) {
        indexKind = _btn1.tag;
        _perSonTickeNameStr = _btn1.titleLabel.text;
    }
    if (sender.tag == 3) {
        indexKind = _btn1.tag;
        _perSonTickeNameStr = _btn1.titleLabel.text;
    }
    if (sender.tag == 4) {
        indexKind = _btn1.tag;
        _perSonTickeNameStr = _btn1.titleLabel.text;
    }
    
}
- (IBAction)chooseIDKindClick:(id)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        _pickerView.alpha = 1;
    }];
    
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
    [self createPickerView];
    
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

-(void)createPickerView{
    arr = @[@"二代身份证",@"一代身份证",@"港澳通行证",@"台湾通行证",@"护照"];
    arrCode =  @[@"1",@"2",@"C",@"G",@"B"];
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, NEWWIDTH, NEWHEIGHT/3)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_pickerView];
    _pickerView.alpha = 0;

}





//完成按钮
- (IBAction)commitClick:(id)sender {
    if (_nameText.text.length == 0) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入乘客姓名"];
    }
    else if ([_perSonIDKindLab.text isEqualToString:@"请选择证件类型"]){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请选择证件类型"];
    }
    else if (_personIDText.text.length == 0){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入乘客身份证"];
    }
    else if ((_btn1.selected == NO)&&(_btn2.selected == NO)&&(_btn3.selected == NO)&&(_btn4.selected == NO)){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请选择车票种类"];
    }
    else{
        NSDictionary *dict = @{
                               @"passenger_name":_nameText.text,
                               @"passenger_id_type_code":_perSonKindStr,
                               @"passenger_id_type_name":_perSonIDKindLab.text,
                               @"passenger_id_no":_personIDText.text,
                               @"passenger_type_name":_perSonTickeNameStr,
                               @"passenger_type":[NSString stringWithFormat:@"%ld",(long)indexKind],
                               @"isUserSelf":@"N"
                               };
        
        _block(_nameText.text,_personIDText.text,dict);
        [self.navigationController popViewControllerAnimated:YES];
    }
   
}



#pragma mark - pickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 5;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    

    return arr[row];
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [UIView animateWithDuration:0.2 animations:^{
        _pickerView.alpha = 0;
        _perSonIDKindLab.text = arr[row];
        _perSonKindStr = arrCode[row];
    
    }];
    
    
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
