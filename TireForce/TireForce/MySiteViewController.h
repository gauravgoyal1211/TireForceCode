//
//  MySiteViewController.h
//  TireForce
//
//  Created by CANOPUS5 on 20/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface MySiteViewController : BaseViewController<UIWebViewDelegate,UIPopoverPresentationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
