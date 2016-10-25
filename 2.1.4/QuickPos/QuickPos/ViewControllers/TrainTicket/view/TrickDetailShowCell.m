//
//  TrickDetailShowCell.m
//  QuickPos
//
//  Created by Lff on 16/10/24.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TrickDetailShowCell.h"
#import "TrickListInfoModel.h"

@implementation TrickDetailShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)yudingBtnClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(trickDetailShowBtnClickYuDing:)]) {
        [_delegate trickDetailShowBtnClickYuDing:_yudingBtn.tag];
    }
    
}




@end
