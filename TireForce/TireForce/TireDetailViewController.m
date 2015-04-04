//
//  TireDetailViewController.m
//  TireForce
//
//  Created by KESHAV on 30/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "TireDetailViewController.h"
#import "TireDetailHeader.h"
#import "HUDManager.h"
#import "WebServiceHandler.h"
#import "UserInformation.h"

@interface TireDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    TireDetailHeader *headerView;
    
    NSMutableArray *tireDetails;
    NSDictionary *responseForTireDetails;
    
}

@property (strong, nonatomic) IBOutlet UICollectionView *tireDetailCollectionView;

@end

@implementation TireDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateHeaderSize];
    
    [self callWebserviceForTireDetails];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tireDetailCollectionView reloadData];
}

#pragma UICollectionView DataSource methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  tireDetails.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailsItemsCellIdentifier" forIndexPath:indexPath];
    
    UILabel *descriptionLable = (UILabel*) [[cell.contentView viewWithTag:100] viewWithTag:101];
    
    NSDictionary *tireInfo = tireDetails[indexPath.row];
    NSString *key = [[tireInfo allKeys] firstObject];
    [descriptionLable setText:[NSString stringWithFormat:@"%@: %@",key,tireInfo[key]]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        
        UIImage *tireImage =[UIImage imageNamed:@"Tire Force_icon 1024x1024"];
        
        [headerView.tireImageView1 loadImageByURL:responseForTireDetails[@"ImageURL"] placeholderImage:tireImage];
        [headerView.tireImageView2 loadImageByURL:responseForTireDetails[@"ThumbnailURL"] placeholderImage:tireImage];
        [headerView.tireImageView3 loadImageByURL:responseForTireDetails[@"ThumbnailURL"] placeholderImage:tireImage];
        [headerView.tireImageView4 loadImageByURL:responseForTireDetails[@"ThumbnailURL"] placeholderImage:tireImage];
        
        reusableview = headerView;
    }
    
    return reusableview;
}

#pragma UICollectionView FlowLayout Delegate methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat side = collectionView.bounds.size.width - 50;
    return (CGSize){ side, 50.0f };
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 25, 10, 25);
}


/* Notifies when view rotation begins */

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    // here we need to invalidate the layout
    [_tireDetailCollectionView.collectionViewLayout invalidateLayout];
    
    [self updateHeaderSize];
}

/* Notifies when view rotation ends */

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [self.tireDetailCollectionView performBatchUpdates:^{
        [self updateHeaderSize];
    } completion:nil];
}

/* updates the header size according to device in ratio */

-(void)updateHeaderSize
{
    CGFloat size ;
    
    const BOOL iOS7_1OrLower = floor(NSFoundationVersionNumber) <=  NSFoundationVersionNumber_iOS_7_1;
    
    if (iOS7_1OrLower)
    {
        // this is for ios7.1 or lower version
        if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
            size = CGRectGetHeight([[UIScreen mainScreen] bounds])*0.7;
        } else {
            size = CGRectGetWidth([[UIScreen mainScreen] bounds])*0.7;
        }
    }
    else
    {
        // this is for ios 8.0 or later version
        size = CGRectGetWidth([[UIScreen mainScreen] bounds])*0.7;
    }
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)_tireDetailCollectionView.collectionViewLayout;
    [flowLayout setHeaderReferenceSize:CGSizeMake(size, size)];
}

#pragma mark- Webservice Calling Methods
#pragma mark-

-(void)callWebserviceForTireDetails
{
    NSDictionary *paramForTireDetails= @{
                                         @"userid":[UserInformation sharedInstance].userId,
                                         @"token":[UserInformation sharedInstance].token,
                                         @"Makeid":_selectedSearchResultDict[@"TireLibMakeId"],
                                         @"pcode":_selectedSearchResultDict[@"Item"]
                                         };
    
    [HUDManager showHUDWithText:PleaseWait];
    
    [ [WebServiceHandler webServiceHandler] GetTireDetails:paramForTireDetails completionHandlerSuccess:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (responseObject)
            {
                responseForTireDetails = responseObject;
                NSLog(@"response = %@",responseObject);
                NSLog(@"2756020 = %@",_selectedSearchResultDict
                      );
                //prepare the data to display in collection view
                tireDetails = [NSMutableArray new];
                [tireDetails addObject:@{@"Item":_selectedSearchResultDict[@"Item"]}];
                [tireDetails addObject:@{@"Description":_selectedSearchResultDict[@"Description"]}];
                
                [tireDetails addObject:@{@"Model":_selectedSearchResultDict[@"Model"]}];
                [tireDetails addObject:@{@"Size":_selectedSearchResultDict[@"Size"]}];
                [tireDetails addObject:@{@"Make":responseObject[@"Make"]}];
                
                [tireDetails addObject:@{@"Availability":_selectedSearchResultDict[@"Availability"]}];
                
                NSString *price = [NSString stringWithFormat:@"$%@",_selectedSearchResultDict[@"Price"]];
                NSString *retail = [NSString stringWithFormat:@"$%@",_selectedSearchResultDict[@"Retail"]];
                
                [tireDetails addObject:@{@"Price":price}];
                [tireDetails addObject:@{@"Retail":retail}];
                
                [self.tireDetailCollectionView reloadData];
            }
            else
            {
                [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please contact to administrator." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            }
            
            [HUDManager hideHUD];
        });
    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please contact to administrator." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [HUDManager hideHUD];
        });
    }];
}

@end
