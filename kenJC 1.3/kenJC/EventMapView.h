//
//  EventMapView.h
//  kenJC
//
//  Created by Apple on 20/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"
#import <MapKit/MapKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "JFMapAnnotation.h"
#import "CalloutAnnotationView.h"

@interface EventMapView : UIViewController<MFMailComposeViewControllerDelegate,UISearchBarDelegate,CLLocationManagerDelegate,MKMapViewDelegate,CalloutAnnotationViewDelegate>
{
    
}
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property(nonatomic,retain)NSMutableArray *mapAry;

@end
