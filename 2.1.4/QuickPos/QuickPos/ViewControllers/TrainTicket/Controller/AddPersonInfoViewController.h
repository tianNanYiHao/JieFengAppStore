//
//  AddPersonInfoViewController.h
//  QuickPos
//
//  Created by Lff on 16/10/12.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AddPersonBlock)(NSString *name , NSString *perSonID);

@interface AddPersonInfoViewController : UIViewController
@property (nonatomic,strong)AddPersonBlock block;

-(void)comeBackBlock:(AddPersonBlock)blocK;


@end
