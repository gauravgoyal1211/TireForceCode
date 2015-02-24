//
//  TFUtility.m
//  TireForce
//
//  Created by CANOPUS5 on 12/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "TFUtility.h"

@implementation TFUtility
+(id)sharedInstance{
    TFUtility *obj;
    if(!obj){
        obj = [[TFUtility alloc] init];
    }
    return obj;
}
-(void)setLeftPadding:(UITextField *)textField imageName:(NSString *)image width:(int)width
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, textField.frame.size.height)];
    UIImageView *leftImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, paddingView.frame.size.width/2, paddingView.frame.size.width/2)];
    leftImage.center=paddingView.center;
    leftImage.image=[UIImage imageNamed:image];
    leftImage.contentMode=UIViewContentModeScaleAspectFit;
    [paddingView addSubview:leftImage];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

@end
