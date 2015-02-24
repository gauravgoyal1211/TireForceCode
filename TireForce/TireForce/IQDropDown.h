//
//  IQDropDown.h
//  Harp Home Service
//
//  Created by hp on 19/10/13.
//  Copyright (c) 2013 Canopus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum IQDropDownMode
{
    IQdropDownModePickerView,
    IQdropDownModeDatePicker,
    IQdropDownModeTimePicker
}IQdropDownMode;

/*Do not modify it's delegate*/
@interface IQDropDown : UITextField

@property (nonatomic,strong) UIDatePicker    *datePicker;
@property(nonatomic, assign) IQdropDownMode dropDownMode;

//For IQdropDownModePickerView
@property(nonatomic, strong) NSArray *itemList;

//For IQdropDownModeDatePicker
- (void)setDate:(NSDate *)date animated:(BOOL)animated;

-(void)setitemListatIndex:(NSArray *)itemList index:(int)indexnumber;
@property(nonatomic) UIDatePickerMode datePickerMode;             // default is UIDatePickerModeDate

@property(nonatomic, strong) NSString *selectedItem;


@end
