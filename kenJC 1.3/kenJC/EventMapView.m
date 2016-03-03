//
//  EventMapView.m
//  kenJC
//
//  Created by Apple on 20/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "EventMapView.h"

@interface EventMapView ()
{
    CLLocationManager *locationManager;
}
@end

@implementation EventMapView
@synthesize mapAry;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     NSLog(@"%@",self.mapAry);
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"HH:mm:ss"];
    NSDate *now2 = [dateFormatter2 dateFromString:[[self.mapAry objectAtIndex:0]valueForKey:@"evtStartTime"]];
     NSDate *now3 = [dateFormatter2 dateFromString:[[self.mapAry objectAtIndex:0]valueForKey:@"evtEndTime"]];
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"hh:mm a"];
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *now = [dateFormatter1 dateFromString:[[self.mapAry objectAtIndex:0] valueForKey:@"evtStartDate"]];
    NSDateFormatter *dateFormatter4 = [[NSDateFormatter alloc] init];
    [dateFormatter4 setDateFormat:@"dd-MMMM-yyyy"];
   
    
    NSLog(@"%@",[dateFormatter3 stringFromDate:now2]);
    NSLog(@"%@",[dateFormatter3 stringFromDate:now3]);
    
   /* NSDateFormatter *df1 = [[NSDateFormatter alloc]init];
    
    [df1 setDateFormat:@"HH:mm:ss"];
    
    NSDate *dttm = [df1 dateFromString:[[self.mapAry objectAtIndex:0]valueForKey:@"evtStartTime"]];
    
    NSDate *dttm2 = [df1 dateFromString:[[self.mapAry objectAtIndex:0]valueForKey:@"evtEndTime"]];
    
    NSDateFormatter *df2 = [[NSDateFormatter alloc]init];
    
    [df1 setDateFormat:@"hh:mm a"];
    
    NSString *strtm = [df2 stringFromDate:dttm];
     NSString *strtm2 = [df2 stringFromDate:dttm2];*/
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc]init];
    [Dict setObject:[[self.mapAry objectAtIndex:0]valueForKey:@"evtLatitude"] forKey:@"Lat"];
    [Dict setObject:[[self.mapAry objectAtIndex:0] valueForKey:@"evtLongitude"] forKey:@"Lon"];
    [Dict setObject:[[self.mapAry objectAtIndex:0] valueForKey:@"evtName"] forKey:@"name"];
    [Dict setObject:[dateFormatter4 stringFromDate:now] forKey:@"stdate"];
    [Dict setObject:[NSString stringWithFormat:@"%@",[dateFormatter3 stringFromDate:now3]] forKey:@"enddate"];

    self.mapAry = [[NSMutableArray alloc]init];
    [self.mapAry addObject:Dict];
   
    
    if ([self.mapAry count]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray * annoationsPeople = [self parseJSONCities];
            NSLog(@"annoation %@",annoationsPeople);
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self.mapView addAnnotations:annoationsPeople];
                [self setCenterLatituteLongitute:annoationsPeople];
            });
        });
    }
}

BACK

-(void)setCenterLatituteLongitute :(NSArray *)arrayOfAnnotation
{
    self.mapView.frame = CGRectMake(self.mapView.frame.origin.x,self.mapView.frame.origin.y,self.mapView.frame.size.width,self.mapView.frame.size.height);
    MKCoordinateRegion region;
    CLLocationDegrees maxLat = -90;
    CLLocationDegrees maxLon = -180;
    CLLocationDegrees minLat = 90;
    CLLocationDegrees minLon = 180;
    
    for (int i =0 ; i< [arrayOfAnnotation count]; i++)
    {
        JFMapAnnotation *annotationView = (JFMapAnnotation *)[arrayOfAnnotation objectAtIndex:i];
        
        NSString *gpslat=[NSString stringWithFormat:@"%f",annotationView.coordinate.latitude];
        NSString *gpslon=[NSString stringWithFormat:@"%f",annotationView.coordinate.longitude];
        
        float currentLat=[gpslat floatValue];
        float currentLong=[gpslon floatValue];
        
        if (currentLat==0.0 || currentLong==0.0) {
            continue;
        }
        
        if(currentLat > maxLat)
            maxLat = currentLat;
        if(currentLat < minLat)
            minLat = currentLat;
        if(currentLong > maxLon)
            maxLon = currentLong;
        if(currentLong < minLon)
            minLon = currentLong;
    }
    
    region.center.latitude     = (maxLat + minLat) / 2;
    region.center.longitude    = (maxLon + minLon) / 2;
    if ((maxLat - minLat) == 0) {
        region.span.latitudeDelta  = 0.005;
        region.span.longitudeDelta = 0.005;
    }else{
        NSLog(@"%f",maxLat - minLat + 0.005);
        NSLog(@"%f",maxLon - minLon + 0.005);
        region.span.latitudeDelta  = maxLat - minLat + 0.025;
        region.span.longitudeDelta = maxLon - minLon + 0.025;
    }
    if((maxLat - minLat + 0.005)!=-179.995000 && (maxLon - minLon + 0.005)!=-359.995000)
        [self.mapView setRegion:region animated:YES];
    
   
    
    
    // else
    // [self.mapView setRegion: animated:YES];
    
    
    /* MKCoordinateRegion myRegion;
     
     //Center
     CLLocationCoordinate2D center;
     center.latitude=locationManager.location.coordinate.latitude;
     center.longitude=locationManager.location.coordinate.longitude;
     
     //Span
     MKCoordinateSpan span;
     span.latitudeDelta=0.3f;
     span.longitudeDelta=0.3f;
     //Set Region
     myRegion.center=center;
     myRegion.span=span;
     [self.mapView setRegion:myRegion animated:YES];*/
}

- (NSMutableArray *)parseJSONCities{
    
    NSMutableArray *retval = [[NSMutableArray alloc]init];
    
    long i=0;
    
    
    for (JFMapAnnotation *record in self.mapAry) {
        
        
        i++;
        JFMapAnnotation *temp = [[JFMapAnnotation alloc]init];
 
       // [temp setTitle:[record valueForKey:@"name"]];
        
        [temp setTitle:[NSString stringWithFormat:@"%@",[record valueForKey:@"name"]]];
        
          NSString *str=[NSString stringWithFormat:@"Start Date:%@\nStart Time:%@",[record valueForKey:@"stdate"],[record valueForKey:@"enddate"]];
        
       // NSString *str=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[record valueForKey:@"jobSuburb"],[[record valueForKey:@"jobSuburb"]length]==0?@"":@", ",[record valueForKey:@"jobState"],[[record valueForKey:@"jobState"]length]==0?@"":@", ",[record valueForKey:@"jobCountry"],[[record valueForKey:@"jobCountry"]length]==0?@"":@", ",[record valueForKey:@"jobPin"],[[record valueForKey:@"jobPin"]length]==0?@"":@", "];
        
//          if([str length]>2)
//          str=[str substringToIndex:[str length]-2];
        
        
         //NSString *strAddressFormated = [NSString stringWithFormat:@"%@",[record valueForKey:@"empAddress"]];
          [temp setSubtitle:str];
        
        [temp setMaptag:i];
        
        if (![[record valueForKey:@"Lat"]isEqualToString:@""] && ![[record valueForKey:@"Lon"]isEqualToString:@""])
        {
            
            [temp setCoordinate:CLLocationCoordinate2DMake([[record valueForKey:@"Lat"]floatValue], [[record valueForKey:@"Lon"]floatValue])];
        }
        
        
        [retval addObject:temp];
        
        
    }    return retval;
}

- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation
{
    NSString *identifier;
    MKAnnotationView *AnnotationView;
    
    if ([annotation isKindOfClass:[JFMapAnnotation class]])
    {
        static NSString *MapAnnotation = @"com.invasivecode.pin";
        AnnotationView  = [self.mapView dequeueReusableAnnotationViewWithIdentifier:MapAnnotation];
        
        if (AnnotationView == nil) {
            AnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:MapAnnotation];
        }
      //  GPS-icon3.png
        //map_pin.png
        AnnotationView.image = [UIImage imageNamed:@"map_icon1.png"];
    }
    else
    {
        CalloutAnnotation *calloutAnnotation = (CalloutAnnotation *)annotation;
        
        // Callout annotation.
        identifier = [NSString stringWithFormat:@"%@",calloutAnnotation.title];
        
        if([identifier isEqualToString:@"Current Location"])
            return AnnotationView;
        
        AnnotationView = (CalloutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (AnnotationView == nil) {
            AnnotationView = [[CalloutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        ((CalloutAnnotationView *)AnnotationView).title = calloutAnnotation.title;
        ((CalloutAnnotationView *)AnnotationView).subtitle = calloutAnnotation.subtitle;
        ((CalloutAnnotationView *)AnnotationView).imageview.image=[UIImage imageNamed:@"map_popup.png"];
        ((CalloutAnnotationView *)AnnotationView).delegate = self;
        
        [AnnotationView setNeedsDisplay];
    }
    AnnotationView.annotation = annotation;
    return AnnotationView;
}


int mapViewTag;
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[JFMapAnnotation class]]) {
        JFMapAnnotation *pinAnnotation = ((JFMapAnnotation *)view.annotation);
        NSString *tagtag = [NSString stringWithFormat:@"%i",[pinAnnotation maptag]];
        mapViewTag = [tagtag intValue];
        
        CalloutAnnotation *calloutAnnotation = [[CalloutAnnotation alloc] init];
        calloutAnnotation.title      = pinAnnotation.title;
        calloutAnnotation.coordinate = pinAnnotation.coordinate;
        calloutAnnotation.subtitle   = pinAnnotation.subtitle;
        //        view.image = [UIImage imageNamed:@"user_img.png"];
        pinAnnotation.calloutAnnotation = calloutAnnotation;
        
        
        NSLog(@"Click on that and emrid %d",[tagtag intValue]);
        
        [mapView addAnnotation:calloutAnnotation];
        [mapView setCenterCoordinate:calloutAnnotation.coordinate animated:YES];
    }
}
- (void)mapView:(MKMapView *)mapView
didDeselectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[JFMapAnnotation class]]) {
        // Deselected the pin annotation.
        JFMapAnnotation *pinAnnotation = ((JFMapAnnotation *)view.annotation);
        [mapView removeAnnotation:pinAnnotation.calloutAnnotation];
    }
}

#pragma mark - CalloutAnnotationViewDelegate
- (void)calloutButtonClicked:(NSString *)title
{
    [self nextbutton:nil];
}

-(void)nextbutton:(id)sender
{
    NSLog(@"%d",mapViewTag);
    
    
    //    CampusCategory *camp = [self.storyboard instantiateViewControllerWithIdentifier:@"CampusCategory"];
    //    camp.DictInfo2 = [self.mapAry objectAtIndex:mapViewTag-1];
    //
    //    [self.navigationController pushViewController:camp animated:YES];
    
    //    EmployeeProfile.m
    
    
    //    if(ispeoplemenu)
    //    {
    //        JobProfile *jp=[[JobProfile alloc]initWithNibName:@"JobProfile" bundle:nil];
    //        jp.jobDict=[arrActive objectAtIndex:mapViewTag-1];
    //        [self.navigationController pushViewController:jp animated:YES];
    //
    //    }else
    //    {
    //        SeekPeopleProfileViewController *jp=[[SeekPeopleProfileViewController alloc]initWithNibName:@"SeekPeopleProfileViewController" bundle:nil];
    //        jp.jobDict=[arrPeople objectAtIndex:mapViewTag-1];
    //        [self.navigationController pushViewController:jp animated:YES];
    //    }
    //
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
