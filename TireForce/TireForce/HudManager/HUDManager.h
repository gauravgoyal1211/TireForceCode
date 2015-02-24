//
//  ThemeManager.h
//  LifeBio
//
//  Created by Iftekhar Mac Pro on 9/12/13.
//  Copyright (c) 2013 Canopus. All rights reserved.
//

#import <Foundation/Foundation.h>

//extern NSString* const PleaseWait;

#define PleaseWait NSLocalizedString(@"Please Wait", nil)

@interface HUDManager : NSObject

+(void)showHUDWithText:(NSString*)text;

+(void)hideHUD;

+(void)hideHUDWithDelay:(NSInteger)delay;

@end
