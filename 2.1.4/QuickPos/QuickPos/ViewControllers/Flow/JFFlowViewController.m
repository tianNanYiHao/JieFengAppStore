//
//  JFFlowViewController.m
//  QuickPos
//
//  Created by Lff on 16/11/24.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "JFFlowViewController.h"
#import "JFFloewCollectionViewCell.h"


@interface JFFlowViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSArray *_array;
    NSArray *_array2;
    
    
    
}
@end

@implementation JFFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title  = @"流量充值";
    
    [self createCollection];
    
}

- (void)createCollection{
    
    _array = @[@"30M",@"50",@"100M",@"200",@"500",@"1G"];
    _array2 = @[@"售价10元",@"售价20元",@"售价30元",@"售价50元",@"售价100元",@"售价200元"];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, NEWWIDTH, NEWHEIGHT-50) collectionViewLayout:layout];
    [_collectionView registerNib:[UINib nibWithNibName:@"JFFloewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JFFloewCollectionViewCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    
}

#pragma mark - colletcionDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat f =  107/65;
    return CGSizeMake((NEWWIDTH-40)/3, 65*f);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JFFloewCollectionViewCell *cell = (JFFloewCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"JFFloewCollectionViewCell" forIndexPath:indexPath];
    cell.labM.text = _array[indexPath.row];
    cell.labMoney.text = _array2[indexPath.row];
    return cell;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 15, 5, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"00000000");

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
