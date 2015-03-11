
//
//  EditDataConnnectorCell.m
//  TireForce
//
//  Created by CANOPUS5 on 16/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "DataConnnectorCell.h"
@implementation DataConnnectorCell

- (void)awakeFromNib {
    // Initialization code
    [[_buttonToActiveState layer] setMasksToBounds:YES];
    [[_buttonToActiveState layer] setCornerRadius:4.0];
    [[_buttonToActiveState layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[_buttonToActiveState layer] setBorderWidth:1.0];
    
    [[_ButtonSave layer] setMasksToBounds:YES];
    [[_ButtonSave layer] setCornerRadius:4.0];
    
    [[_buttonTest layer] setMasksToBounds:YES];
    [[_buttonTest layer] setCornerRadius:4.0];



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end
