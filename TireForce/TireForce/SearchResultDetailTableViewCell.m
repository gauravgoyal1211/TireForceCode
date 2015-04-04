//
//  SearchResultDetailTableViewCell.m
//  TireForce
//
//  Created by CANOPUS4 on 12/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "SearchResultDetailTableViewCell.h"

@implementation SearchResultDetailTableViewCell

- (void)awakeFromNib
{
    // Initialization code

    [self getFontAccordingTodevice:_Model];
    [self getFontAccordingTodevice:_Price];
    [self getFontAccordingTodevice:_Availability];
    [self getFontAccordingTodevice:_Manufacture];
    
    // UPDATE CONSTRAINT IF IT IS RUNNING ON IPAD
    for(NSLayoutConstraint *constraint in _Price.constraints)
    {
        if((constraint.firstItem == _Price) && (constraint.firstAttribute == NSLayoutAttributeWidth) )
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                constraint.constant = 130;
            [_Price setNeedsUpdateConstraints];
            [UIView animateWithDuration:0.0 animations:^{
                [_Price layoutIfNeeded];
            }];
            
            break;
        }
    }
}

-(void)getFontAccordingTodevice:(UILabel*)lable
{
    UIFont *font;

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        font = [UIFont fontWithName:lable.font.fontName size:14.0f];
    else
        font = [UIFont fontWithName:lable.font.fontName size:12.f];

    [lable setFont:font];
    
    [lable layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
