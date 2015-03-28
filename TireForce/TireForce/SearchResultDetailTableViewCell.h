//
//  SearchResultDetailTableViewCell.h
//  TireForce
//
//  Created by CANOPUS4 on 12/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Model;
@property (weak, nonatomic) IBOutlet UILabel *Size;
@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UILabel *Availability;
@property (weak, nonatomic) IBOutlet UILabel *Manufacture;

@property (weak, nonatomic) IBOutlet UIButton *btnForOnCheck;

@end
