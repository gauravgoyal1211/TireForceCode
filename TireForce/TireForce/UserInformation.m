

//
//  UserInformation.m
//  TireForce
//
//  Created by CANOPUS5 on 13/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation
+(instancetype)sharedInstance
{
       static UserInformation *obj;
    if(!obj){
        obj = [[UserInformation alloc] init];
    }
    return obj;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _token=@"Cms@SF1324DSAfBaFaFH";
    }
    return self;
}


@end
