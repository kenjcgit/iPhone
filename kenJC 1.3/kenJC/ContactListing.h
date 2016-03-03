//
//  ContactListing.h
//  kenJC
//
//  Created by fiplmacmini2 on 12/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"
#import <MapKit/MapKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "JFMapAnnotation.h"
#import "CalloutAnnotationView.h"

@interface ContactListing : UIViewController<MFMailComposeViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CLLocationManagerDelegate,MKMapViewDelegate,CalloutAnnotationViewDelegate>
{
    IBOutlet UITableView *TblContacts;
    NSMutableArray *ContactArray;
    IBOutlet UIButton *Btncount;
}
- (IBAction)BtnEvent:(id)sender;
- (IBAction)BtnNotification:(id)sender;
- (IBAction)BtnMore:(id)sender;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property(nonatomic,retain)NSMutableArray *mapAry;
@end
