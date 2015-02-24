//
//  RXSideMenuVC.m
//  RoxleApp
//
//  Created by Arjun Hastir on 09/01/15.
//  Copyright (c) 2015 Mobiloitte. All rights reserved.
//

#import "SideMenuViewController.h"
#import "UIViewController+JASidePanel.h"
#import "SideMenuCell.h"
#import "DashboardViewCOntroller.h"
#import "AppSettingViewController.h"
#import "PricemarkUpViewController.h"
#import "DataConnectorsViewController.h"
#define windowWidth   [UIScreen mainScreen].bounds.size.width

@interface SideMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic)NSMutableArray *menuItemArray;
@property (strong, nonatomic)NSMutableArray *menuItemImageArray;

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuItemArray = [[NSMutableArray alloc] initWithObjects:@"DashBoard",@"App Setting",@"Data Connectors",@"Price Markup", nil];
    
    self.menuItemImageArray = [[NSMutableArray alloc] initWithObjects:@"ArrowIcon",@"ArrowIcon",@"ArrowIcon",@"ArrowIcon", nil];
    self.menuTableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma IBAction Methods

- (IBAction)profileBtnAction:(id)sender {
//    UINavigationController *centerNavigation = (UINavigationController *)self.sidePanelController.centerPanel;
//    [centerNavigation popToRootViewControllerAnimated:NO];
//    ProfileNewViewController *rXProfileVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"profileView"];
//    centerNavigation =  [[UINavigationController alloc]initWithRootViewController:rXProfileVC];
//    [self.sidePanelController setCenterPanel:centerNavigation];
    
}
#pragma mark - UITableView Delegate and DataSource method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"rXSideMenuCell";
    SideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if(indexPath.section == 0){
         if(indexPath.row == 0){
           cell.iconImageView.frame=CGRectMake(cell.iconImageView.frame.origin.x, cell.iconImageView.frame.origin.y, cell.iconImageView.frame.size.width, cell.iconImageView.frame.size.height);
             cell.iconImageView.backgroundColor=[UIColor clearColor];
         }
        
    cell.iconImageView.image = [UIImage imageNamed:[self.menuItemImageArray objectAtIndex:indexPath.row]];
    cell.iconLabel.text = [self.menuItemArray objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cell.iconLabel.text = @"DEMO";
                break;
            case 1:
                cell.iconLabel.text = @"HELP";
                break;
                
            default:
                break;
        }
    }
    [self.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section ? 58 : 64;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    UIImageView *imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LoginHeaderLogo"]];
    [imgView setFrame:CGRectMake(90, 15, 120, 35)];
    [view setBackgroundColor:[UIColor clearColor]];
    [view addSubview:imgView];
    self.navigationItem.titleView=view;
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UINavigationController *centerNavigation = (UINavigationController *)self.sidePanelController.centerPanel;
    [centerNavigation popToRootViewControllerAnimated:NO];
    if(indexPath.section == 0){
  switch (indexPath.row) {
      case 0:{
          DashboardViewCOntroller *dash =  [self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"];
          centerNavigation =  [[UINavigationController alloc]initWithRootViewController:dash];
          [self.sidePanelController setCenterPanel:centerNavigation];

      }
            break;
      case 1:{
         AppSettingViewController *rXOrderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"appSetting"];
         centerNavigation = [[UINavigationController alloc]initWithRootViewController:rXOrderVC];
         [self.sidePanelController setCenterPanel:centerNavigation];
     }
         break;
       case 2:{
           DataConnectorsViewController *rXPaymentVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"editDataConnector"];
          centerNavigation =  [[UINavigationController alloc]initWithRootViewController:rXPaymentVC];
          [self.sidePanelController setCenterPanel:centerNavigation];

   }
           break;
       case 3:{
          PricemarkUpViewController *rXSettingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"priceMarkUp"];
          centerNavigation = [[UINavigationController alloc]initWithRootViewController:rXSettingVC];
          [self.sidePanelController setCenterPanel:centerNavigation];
       }
           break;
       
       default:
           break;
       }
    }
}
@end
