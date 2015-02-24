//
//  IQDropDown.m
//  Harp Home Service
//
//  Created by hp on 19/10/13.
//  Copyright (c) 2013 Canopus. All rights reserved.
//

#import "IQDropDown.h"

@interface IQDropDown ()<UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation IQDropDown
{
    UIImageView     *imageViewDropDown;
    UIPickerView    *pickerView;
    
    UIDatePicker    *timePicker;
    
    NSDateFormatter *dropDownDateFormatter;
    NSDateFormatter *dropDownTimeFormatter;
}
@synthesize datePicker;
-(void)initialize
{
    [self setContentVerticalAlignment:      UIControlContentVerticalAlignmentCenter];
    [self setContentHorizontalAlignment:    UIControlContentHorizontalAlignmentCenter];
    
    
    imageViewDropDown = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
    [imageViewDropDown setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin)];
    [imageViewDropDown setImage:[UIImage imageNamed:@"dropdown_right"]];
    
    [self addSubview:imageViewDropDown];
    
    self.rightView=imageViewDropDown;
    self.rightViewMode=UITextFieldViewModeAlways;
    
    dropDownDateFormatter = [[NSDateFormatter alloc] init];
    [dropDownDateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dropDownDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dropDownDateFormatter setDateFormat:@"yyyy/MM/dd"];
   
    dropDownTimeFormatter= [[NSDateFormatter alloc] init];
    [dropDownTimeFormatter setDateFormat:@"HH:mm:ss"];
    
    
    pickerView = [[UIPickerView alloc] init];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setDelegate:self];
    [pickerView setDataSource:self];
    
    datePicker = [[UIDatePicker alloc] init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    timePicker = [[UIDatePicker alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"da_DK"];
    [timePicker setLocale:locale];
    [timePicker setDatePickerMode:UIDatePickerModeTime];
    [timePicker addTarget:self action:@selector(timeChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self setDropDownMode:IQdropDownModePickerView];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackground:[[UIImage imageNamed:@"text_bg.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
}

//-(void)setText:(NSString *)text
//{
//    if ([text length] == 0)
//    {
//        NSLog(@"Fasaa In DropDownClass");
//    }
//
//    [super setText:text];
//}
//
//-(NSString *)text
//{
//    NSString *text = [super text];
//    
//    if ([text length] == 0)
//    {
//        NSLog(@"Shayad Fasaa");
//    }
//    
//    return text;
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled=YES;
        [self initialize];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
    
}


-(void)setDropDownMode:(IQdropDownMode)dropDownMode
{
    _dropDownMode = dropDownMode;
    
    switch (_dropDownMode)
    {
        case IQdropDownModePickerView:
            self.inputView = pickerView;
            [imageViewDropDown setHidden:NO];
            break;
            
        case IQdropDownModeDatePicker:
            self.inputView = datePicker;
            [imageViewDropDown setHidden:YES];
            break;
            
        case IQdropDownModeTimePicker:
            self.inputView = timePicker;
            [imageViewDropDown setHidden:YES];
            break;
            
        default:
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _itemList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_itemList objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self setSelectedItem:[_itemList objectAtIndex:row]];
}

-(void)dateChanged:(UIDatePicker*)dPicker
{
    
    [self setSelectedItem:[dropDownDateFormatter stringFromDate:dPicker.date]];
}

-(void)timeChanged:(UIDatePicker*)dPicker
{
    [self setSelectedItem:[dropDownTimeFormatter stringFromDate:dPicker.date]];
}

-(void)setItemList:(NSArray *)itemList
{
    _itemList = itemList;
    
    //    if ([_itemList count] > 0)
    //    {
    //        [self setText:[_itemList objectAtIndex:0]];
    //    }
    
    [pickerView reloadAllComponents];
}
-(void)setitemListatIndex:(NSArray *)itemList index:(int)indexnumber
{
    _itemList = itemList;
    
    if ([_itemList count] > 0)
    {
        [self setText:[_itemList objectAtIndex:indexnumber]];
    }
    
    [pickerView reloadAllComponents];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated
{
        [dropDownDateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *finalString = [dropDownDateFormatter stringFromDate:date];
    [self setSelectedItem:finalString];
}

-(void)setSelectedItem:(NSString *)selectedItem
{
    switch (_dropDownMode)
    {
        case IQdropDownModePickerView:
            if ([_itemList containsObject:selectedItem])
            {
                _selectedItem = selectedItem;
                [self setText:selectedItem];
                [pickerView selectRow:[_itemList indexOfObject:selectedItem] inComponent:0 animated:YES];
            }
            break;
            
        case IQdropDownModeDatePicker:
        {
            NSDate *date = [dropDownDateFormatter dateFromString:selectedItem];
            if (date)
            {
                _selectedItem = selectedItem;
                [self setText:selectedItem];
                [datePicker setDate:date animated:YES];
            }
            else
            {
                NSLog(@"Invalid date or date format:%@",selectedItem);
            }
        }
            break;
        case IQdropDownModeTimePicker:
        {
            _selectedItem = selectedItem;
            [self setText:selectedItem];
        }
            break;
    }
}

-(void)setDatePickerMode:(UIDatePickerMode)datePickerMode
{
    if (_dropDownMode == IQdropDownModeDatePicker)
    {
        _datePickerMode = datePickerMode;
        [datePicker setDatePickerMode:datePickerMode];
        
        switch (datePickerMode) {
            case UIDatePickerModeCountDownTimer:
                [dropDownDateFormatter setDateStyle:NSDateFormatterNoStyle];
                [dropDownDateFormatter setTimeStyle:NSDateFormatterNoStyle];
                break;
            case UIDatePickerModeDate:
                [dropDownDateFormatter setDateStyle:NSDateFormatterShortStyle];
                [dropDownDateFormatter setTimeStyle:NSDateFormatterNoStyle];
                break;
            case UIDatePickerModeTime:
                [dropDownDateFormatter setDateStyle:NSDateFormatterNoStyle];
                [dropDownDateFormatter setTimeStyle:NSDateFormatterShortStyle];
                break;
            case UIDatePickerModeDateAndTime:
                [dropDownDateFormatter setDateStyle:NSDateFormatterShortStyle];
                [dropDownDateFormatter setTimeStyle:NSDateFormatterShortStyle];
                break;
        }
    }
}

@end
