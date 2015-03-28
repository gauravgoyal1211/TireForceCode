//
//  SearchViewController.h
//  TireForce
//
//  Created by CANOPUS4 on 11/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SearchViewController : BaseViewController
- (IBAction)onSearch:(id)sender;
- (IBAction)onHideKB:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewSearchViewController;

@property (weak, nonatomic) IBOutlet UIButton *ButtonSearch;


@end
