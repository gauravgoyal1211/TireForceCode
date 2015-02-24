//
//  MySiteViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 20/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//
#import "MySiteViewController.h"
@interface MySiteViewController ()
@end
@implementation MySiteViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://www.tireforce.com/gotire-calgary-east/"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    [_webView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _webView.alpha=0.0;
    [UIView animateWithDuration:0.5 animations:^() {
        [_webView setHidden:NO];
        _webView.alpha = 1.0;
        [_activityIndicator stopAnimating];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
