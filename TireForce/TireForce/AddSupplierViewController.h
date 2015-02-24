//
//  AddSupplierViewController.h
//  TireForce
//
//  Created by CANOPUS5 on 23/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@protocol AddSupplierDelegate <NSObject>
@required
- (void)needToUpdate;
@end

@interface AddSupplierViewController : BaseViewController
{
    // Delegate to respond back
    id <AddSupplierDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
@property NSDictionary *dictForSupplierAvailable;
@end
