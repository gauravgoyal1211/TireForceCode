//
//  AppSettingDetailViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 14/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "AppSettingDetailViewController.h"

@interface AppSettingDetailViewController ()

@end

@implementation AppSettingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"Detail";
    int val=(int)_buttonIndex;
    if(val==5)
    {
        [_labelDetail setText:@"This mode allows your consumers searching for all tires available on TireForce's database (50,000+). This option is good to show endless options of tires and alternatives without considering any other factors such as inventory, pricing, how to source that products, etc. It's likely that you would have to up sell or down sell your lead into a similar tire based on your availability."];
    }else if(val==6)
    {
        [_labelDetail setText:@"This mode works exactly as the one above, but it will also allow your consumers creating packages of tire/wheel together at the same time. Enable this option to allow consumers search among 20,000+ wheels available on TireForce's database. It's likely that you would have to up sell or down sell your lead into a similar tire and/or wheel package based on your availability."];
    } else if(val==7)
    {
        [_labelDetail setText:@"This mode will help you narrow the virtual inventory of 50,000 tires down to whatever it's available through your own suppliers. When enabling this mode, the system will require you to add a Data Connection, which is the username and password for the Canadian Tire Distributor you work with. As well, you would have to set up your price markup so that the system know how to transform cost price into retail price for your consumers. The main advantage of this option is showing real inventory with real"];
    }else if(val==8)
    {
        [_labelDetail setText:@"This option allows your consumer to place an order online. Your consumer will be prompted to enter a valid pay method and the TireForce gateway system will process the credit card transaction on your behalf. Proceed are to be deposited on your bank account or transferred into your Paypal account. The procurement process is not automated, once you receive an order its your responsibility to procure the item(s) from the vendor of preference."];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
