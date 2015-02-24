//
//  AppSettingTableViewCell.h
//  TireForce
//
//  Created by CANOPUS5 on 14/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppSettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *buttonInformation;
@property (weak, nonatomic) IBOutlet UISwitch *switchForSetting;

@end
