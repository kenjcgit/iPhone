//
//  ContactListing.m
//  kenJC
//
//  Created by fiplmacmini2 on 12/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "ContactListing.h"
#import "ContactListingCell.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "JFMapAnnotation.h"
#import "CalloutAnnotationView.h"
#import <MapKit/MapKit.h>

@interface ContactListing ()
{
    CLLocationManager *locationManager;
}
@end

@implementation ContactListing

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSMutableDictionary *Dict = [[NSMutableDictionary alloc]init];
//    [Dict setObject:@"37.786996" forKey:@"Lat"];
//    [Dict setObject:@"-122.419281" forKey:@"Lon"];
//    [Dict setObject:@"test1" forKey:@"name"];
//    
//    
//     NSMutableDictionary *Dict2 = [[NSMutableDictionary alloc]init];
//    [Dict2 setObject:@"37.810000" forKey:@"Lat"];
//    [Dict2 setObject:@"-122.477989" forKey:@"Lon"];
//    [Dict2 setObject:@"test2" forKey:@"name"];
//    
//    NSMutableDictionary *Dict3 = [[NSMutableDictionary alloc]init];
//    [Dict3 setObject:@"37.760000" forKey:@"Lat"];
//    [Dict3 setObject:@"-122.477989" forKey:@"Lon"];
//    [Dict3 setObject:@"test3" forKey:@"name"];
    
   
    [Btncount setTitle:[NSString stringWithFormat:@"%ld",(long)THIS.notificationcount] forState:UIControlStateNormal];
    
    ContactArray = [[NSMutableArray alloc]init];
    
    TblContacts.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(ContactJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [Btncount setTitle:[NSString stringWithFormat:@"%@",([[NSUserDefaults standardUserDefaults]integerForKey:@"notificationcount"])?[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"notificationcount"]]:@"0"] forState:UIControlStateNormal];
}
- (IBAction)BtnEvent:(id)sender
{
    NSArray *controllerArray = self.navigationController.viewControllers;
    //will get all the controllers added to UINavigationController.
    
    for (id controller in controllerArray)
    {
        // iterate through the array and check for your controller
        if ([controller isKindOfClass:[EventListing class]])
        {
            //do your stuff here
            [self.navigationController popToViewController:controller animated:NO];
            return;
        }
    }
    
    EventListing *eventobj  = [[EventListing alloc]initWithNibName:@"EventListing" bundle:nil];
    [self.navigationController pushViewController:eventobj animated:NO];
}
- (IBAction)BtnNotification:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        NSArray *controllerArray = self.navigationController.viewControllers;
        //will get all the controllers added to UINavigationController.
        
        for (id controller in controllerArray)
        {
            // iterate through the array and check for your controller
            if ([controller isKindOfClass:[NotificationListing class]])
            {
                //do your stuff here
                [self.navigationController popToViewController:controller animated:NO];
                return;
            }
        }
        
        NotificationListing *eventobj  = [[NotificationListing alloc]initWithNibName:@"NotificationListing" bundle:nil];
        [self.navigationController pushViewController:eventobj animated:NO];
    }
    else
    {
        ViewController *obj = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:YES];
    }
}
- (IBAction)BtnMore:(id)sender
{
//    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
//    {
        NSArray *controllerArray = self.navigationController.viewControllers;
        //will get all the controllers added to UINavigationController.
        
        for (id controller in controllerArray)
        {
            // iterate through the array and check for your controller
            if ([controller isKindOfClass:[MoreListing class]])
            {
                //do your stuff here
                [self.navigationController popToViewController:controller animated:NO];
                return;
            }
        }
        
        MoreListing *obj = [[MoreListing alloc] initWithNibName:@"MoreListing" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:NO];
//    }
//    else
//    {
//        ViewController *obj = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//        
//        [[self navigationController] pushViewController:obj animated:YES];
//    }

}
-(void)ContactJsonAction
{
    NSDictionary *dict=@{@"action":@"GetContacts"};
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    
    [ContactArray addObjectsFromArray:arry];
    
    NSLog(@"%@",ContactArray);
    
     _mapAry = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[ContactArray count]; i++)
    {
         NSMutableDictionary *Dict = [[NSMutableDictionary alloc]init];
        if ([[[ContactArray objectAtIndex:i]valueForKey:@"cnLatitude"]isEqualToString:@""])
        {
            Dict = [self getLocationFromAddressString:[[ContactArray objectAtIndex:i]valueForKey:@"cnAddress"]];
            [Dict setObject:[[ContactArray objectAtIndex:i]valueForKey:@"cnName"] forKey:@"name"];
        }
        else
        {
            [Dict setObject:[[ContactArray objectAtIndex:i]valueForKey:@"cnLatitude"] forKey:@"Lat"];
            [Dict setObject:[[ContactArray objectAtIndex:i]valueForKey:@"cnLongitude"] forKey:@"Lon"];
            [Dict setObject:[[ContactArray objectAtIndex:i]valueForKey:@"cnName"] forKey:@"name"];
        }
        
        [_mapAry addObject:Dict];
        
        NSLog(@"%@",_mapAry);
    }
    
    NSLog(@"%@",_mapAry);
    
    
    if ([_mapAry count]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray * annoationsPeople = [self parseJSONCities];
            NSLog(@"annoation %@",annoationsPeople);
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self.mapView addAnnotations:annoationsPeople];
               // [self setCenterLatituteLongitute:annoationsPeople];
                [self zoomToFitMapAnnotations:self.mapView];
            });
        });
    }

    
    [TblContacts reloadData];

    LOADINGHIDE
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 85;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ContactArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactListingCell";
    
    ContactListingCell *cell = (ContactListingCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactListingCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell.LblContact setText:[NSString stringWithFormat:@"%@",[[ContactArray objectAtIndex:indexPath.row]valueForKey:@"cnName"]]];
    
//    [cell.LblContact setNumberOfLines:0];
//    [cell.LblContact setLineBreakMode:NSLineBreakByWordWrapping];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.LblPhone setText:[NSString stringWithFormat:@"%@",[[[ContactArray objectAtIndex:indexPath.row]valueForKey:@"cnPhone"]stripHtml]]];
    
    [cell.LblEmal setText:[NSString stringWithFormat:@"%@",[[ContactArray objectAtIndex:indexPath.row]valueForKey:@"cnEmail"]]];
    
    [cell.BtnEmail setTag:indexPath.row+5000];
    [cell.BtnPhone setTag:indexPath.row+6000];
    
    [cell.BtnEmail addTarget:self action:@selector(BtnEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.BtnPhone addTarget:self action:@selector(BtnCallAction:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(void)BtnEmailAction:(id)sender
{
    // Email Subject
    NSString *emailTitle = @"Ken JC";
    // Email Content
   // NSString *messageBody = @"<h1>Learning iOS Programming!</h1>"; // Change the message body to HTML
    // To address
   
    NSString *messageBody = [NSString stringWithFormat:@"%@",[[ContactArray objectAtIndex:[sender tag]-5000]valueForKey:@"cnName"]];
    
    NSString *StrEmail = [NSString stringWithFormat:@"%@",[[ContactArray objectAtIndex:[sender tag]-5000]valueForKey:@"cnEmail"]];
    
    NSArray *toRecipents = [NSArray arrayWithObject:StrEmail];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            [Global displayTost:@"Mail cancelled"];
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            [Global displayTost:@"Mail saved"];
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            [Global displayTost:@"Mail sent"];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)BtnCallAction:(id)sender
{
    
  //  NSString *phNo = @"+919876543210";
     NSString *phNo = [NSString stringWithFormat:@"%@%@",@"+",[[ContactArray objectAtIndex:[sender tag]-6000] valueForKey:@"cnPhone"]];
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *warning =[[UIAlertView alloc] initWithTitle:@"Note" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [warning show];
    }
    
   /* NSString *strname = [ContactArray objectAtIndex:[sender tag]-6000];
    
    UIDevice *device = [UIDevice currentDevice];
    
    NSString *cellNameStr = [NSString stringWithFormat:@"%@",strname];
    
    if ([[device model] isEqualToString:@"iPhone"] ) {
        
        NSString *phoneNumber = [@"telprompt:+" stringByAppendingString:cellNameStr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        
    } else {
        
        UIAlertView *warning =[[UIAlertView alloc] initWithTitle:@"Note" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [warning show];
    }*/
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)zoomToFitMapAnnotations:(MKMapView *)mapView
{
    if ([self.mapView.annotations count] == 0) return;
    
    int i = 0;
    MKMapPoint points[[self.mapView.annotations count]];
    
    //build array of annotation points
    for (id<MKAnnotation> annotation in [self.mapView annotations])
        points[i++] = MKMapPointForCoordinate(annotation.coordinate);
    
    MKPolygon *poly = [MKPolygon polygonWithPoints:points count:i];
    
    [self.mapView setRegion:MKCoordinateRegionForMapRect([poly boundingMapRect]) animated:YES];
    
    
   /* if ([mapView.annotations count] == 0) return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(id<MKAnnotation> annotation in mapView.annotations) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    
    // Add a little extra space on the sides
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];*/
}

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
    
    
    for (JFMapAnnotation *record in _mapAry) {
        
        i++;
        JFMapAnnotation *temp = [[JFMapAnnotation alloc]init];
        [temp setTitle:[record valueForKey:@"name"]];
        
        //  NSString *str=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[record valueForKey:@"jobSuburb"],[[record valueForKey:@"jobSuburb"]length]==0?@"":@", ",[record valueForKey:@"jobState"],[[record valueForKey:@"jobState"]length]==0?@"":@", ",[record valueForKey:@"jobCountry"],[[record valueForKey:@"jobCountry"]length]==0?@"":@", ",[record valueForKey:@"jobPin"],[[record valueForKey:@"jobPin"]length]==0?@"":@", "];
        
        //  if([str length]>2)
        //  str=[str substringToIndex:[str length]-2];
        
        
        // NSString *strAddressFormated = [NSString stringWithFormat:@"%@",[record valueForKey:@"empAddress"]];
        //  [temp setSubtitle:str];
        
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
//    camp.DictInfo2 = [_mapAry objectAtIndex:mapViewTag-1];
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

#pragma mark - Get Lat Long From Address
-(NSMutableDictionary *) getLocationFromAddressString: (NSString*) addressStr
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[NSString stringWithFormat:@"%f",center.latitude] forKey:@""];
     [dict setObject:[NSString stringWithFormat:@"%f",center.longitude] forKey:@""];
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    return dict;
}


@end
