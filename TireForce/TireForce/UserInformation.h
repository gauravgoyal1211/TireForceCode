//
//  UserInformation.h
//  TireForce
//
//  Created by CANOPUS5 on 13/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject

+(instancetype)sharedInstance;

@property (/*strong,*/nonatomic) NSString *userName;
@property (/*strong,*/nonatomic) NSString *password;
@property (/*strong,*/nonatomic) NSString *userId;
@property (/*strong,*/nonatomic) NSString *EmailId;
@property(nonatomic)NSString *token;

@end
