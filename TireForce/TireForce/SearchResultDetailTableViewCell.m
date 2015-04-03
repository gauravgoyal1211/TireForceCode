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

}

-(void)getFontAccordingTodevice:(UILabel*)lable
{
    UIFont *font;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        font = [UIFont fontWithName:lable.font.fontName size:16.0f];
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
