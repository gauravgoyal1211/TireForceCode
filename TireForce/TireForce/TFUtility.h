//
//  TFUtility.h
//  TireForce
//
//  Created by CANOPUS5 on 12/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TFUtility : NSObject
+(id)sharedInstance;
-(void)setLeftPadding:(UITextField *)textField imageName:(NSString *)image width:(int)width;
@end
