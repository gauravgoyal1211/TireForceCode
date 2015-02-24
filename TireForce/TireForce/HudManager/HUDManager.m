//
//  ThemeManager.m
//  LifeBio
//
//  Created by Iftekhar Mac Pro on 9/12/13.
//  Copyright (c) 2013 Canopus. All rights reserved.
//

#import "HUDManager.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

//NSString* const PleaseWait = [NSString stringWithFormat:NSLocalizedString(@"", nil)];

static MBProgressHUD *aHUD;

@implementation HUDManager

+(void)showHUDWithText:(NSString*)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//        UIWindow *window = [[AppDelegate delegate] window];
        
        if (aHUD == nil)
            aHUD = [[MBProgressHUD alloc] initWithWindow:window];
        
        [aHUD setRemoveFromSuperViewOnHide:YES];
        [aHUD setLabelText:text];
        [window addSubview:aHUD];
        [aHUD show:YES];
    });
}

+(void)hideHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [aHUD hide:YES];
    });

}

+(void)hideHUDWithDelay:(NSInteger)delay
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [aHUD hide:YES afterDelay:delay];
    });

}
@end

