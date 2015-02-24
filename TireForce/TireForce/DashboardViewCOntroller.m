//
//  DashboardViewCOntroller.m
//  TireForce
//
//  Created by CANOPUS5 on 13/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "DashboardViewCOntroller.h"
#import "DashboardTableViewCell.h"
#import "TireQueriesViewController.h"
#import "LeadGenrationViewController.h"
#import "AppDelegate.h"
@interface DashboardViewCOntroller ()

@end

@implementation DashboardViewCOntroller

- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.automaticallyAdjustsScrollViewInsets = NO;
     self.title=@"Home";
   
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logoutAction:)];
    
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- -TableViewDelegateDatasource-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

     static NSString *identifier=@"home";
    
   
    DashboardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[DashboardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(indexPath.row==0) cell.labelName.text=@"Tire Queries";
    else if(indexPath.row==1) cell.labelName.text=@"Leads Generated";
        
    return cell;

}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    // Force your tableview margins (this may be a bad idea)
//    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableview setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableview setLayoutMargins:UIEdgeInsetsZero];
//    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        TireQueriesViewController *tire =  [self.storyboard instantiateViewControllerWithIdentifier:@"tirequeries"];
        [self.navigationController pushViewController:tire animated:YES];
    }else
    {
        LeadGenrationViewController *lead =  [self.storyboard instantiateViewControllerWithIdentifier:@"leadgenrated"];
        [self.navigationController pushViewController:lead animated:YES];

    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark- -ButtonsAction
-(void)logoutAction:(UIButton *)button
{
    AppDelegate *delegate=[[UIApplication sharedApplication] delegate];
    UINavigationController *navigation;
    navigation=(UINavigationController *)delegate.window.rootViewController;
    [navigation popToRootViewControllerAnimated:YES];
}

@end
