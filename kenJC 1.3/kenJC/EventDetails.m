//
//  EventDetails.m
//  kenJC
//
//  Created by fiplmacmini2 on 13/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "EventDetails.h"
#import "GlobalViewController.h"
#import <EventKit/EventKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Twitter/Twitter.h>

@interface EventDetails ()

@end

@implementation EventDetails
@synthesize ArrayDetail,strname;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",self.ArrayDetail);
    
    [ViewMain setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    
    LblEventName.text = [self.ArrayDetail valueForKey:@"evtName"];
    LblAddress.text = [self.ArrayDetail valueForKey:@"evtAddress"];
    
    NSString *tempstring = [self.ArrayDetail valueForKey:@"evtInfo"];
    
    tempstring = [tempstring stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    
    TxtDetails.text = [[NSString stringWithFormat:@"%@",tempstring]stripHtml];
    
    NSString *strtag = [self.ArrayDetail valueForKey:@"evtTags"];
    
    if ([strtag length] > 0) {
        
        if ([strtag hasSuffix:@" "])
        {
            NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"SELF endswith %@", @" "];
            
            // Run the predicate
            // match == YES if the predicate is successful
            BOOL match = [myPredicate evaluateWithObject:strtag];
            
            // Do what you want
            if (match)
                strtag = [strtag substringToIndex:[strtag length] - 1];
        }
        if ([strtag hasSuffix:@","])
        {
            NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"SELF endswith %@", @","];
            
            // Run the predicate
            // match == YES if the predicate is successful
            BOOL match = [myPredicate evaluateWithObject:strtag];
            
            // Do what you want
            if (match)
                strtag = [strtag substringToIndex:[strtag length] - 1];
        }
        
    }
    else {
        //no characters to delete... attempting to do so will result in a crash
    }
    
    LblTag.text = strtag;
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *now = [dateFormatter1 dateFromString:[self.ArrayDetail valueForKey:@"evtStartDate"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSLog(@"%@",[dateFormatter stringFromDate:now]);
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"HH:mm:ss"];
    NSDate *now2 = [dateFormatter2 dateFromString:[self.ArrayDetail valueForKey:@"evtStartTime"]];
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"hh:mm a"];
    NSLog(@"%@",[dateFormatter3 stringFromDate:now2]);
    
    
    NSDateFormatter *dateFormatter4 = [[NSDateFormatter alloc] init];
    [dateFormatter4 setDateFormat:@"dd-MMMM-yyyy"];
    NSLog(@"%@",[dateFormatter4 stringFromDate:now]);
     
   // LblTag.text = [NSString stringWithFormat:@"%@",[self.ArrayDetail valueForKey:@"evtTags"]];
    
    LblDate.text = [NSString stringWithFormat:@"%@%@%@ %@",[dateFormatter stringFromDate:now],@",",[dateFormatter4 stringFromDate:now],[dateFormatter3 stringFromDate:now2]];
    
    
//    [ImgEvent setImageWithURLRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@&w=640&h=310&zc=2",IMAGEURLSIZE,[self.ArrayDetail valueForKey:@"evtImage"]]]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        
//    }];
   // [ImgEvent setImageWithURL:[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@&w=640&h=310&zc=2",IMAGEURLSIZE,[self.ArrayDetail valueForKey:@"evtImage"]]] placeholderImage:nil];
    
    
    [ImgEvent setImageWithURL:[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@&w=640&zc=2",IMAGEURLSIZE,[self.ArrayDetail valueForKey:@"evtImage"]]] placeholderImage:nil];
    
    // [ImgEvent setImageWithURL:[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@&w=640&h=310&zc=2",IMAGEURLSIZE,[self.ArrayDetail valueForKey:@"evtImage"]]] placeholderImage:nil];
    
    
    if ([[self.ArrayDetail valueForKey:@"alreadyregistered"]isEqualToString:@""])
    {
       // isregistered = YES;
        StrBtnSelected = @"";
        [Btn1 setTitle:@"Yes" forState:UIControlStateNormal];
        [Btn1 setBackgroundImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
        [Btn2 setTitle:@"May Be" forState:UIControlStateNormal];
        [Btn2 setBackgroundImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
    }
    else  if ([[self.ArrayDetail valueForKey:@"alreadyregistered"]isEqualToString:@"Yes"])
    {
        isregistered = YES;
        StrBtnSelected = @"Yes";
        [Btn1 setTitle:@"Yes" forState:UIControlStateNormal];
        [Btn1 setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        [Btn2 setTitle:@"May Be" forState:UIControlStateNormal];
        [Btn2 setBackgroundImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
    }
    else  if ([[self.ArrayDetail valueForKey:@"alreadyregistered"]isEqualToString:@"May Be"])
    {
        //isregistered = NO;
        ismaybe = YES;
        StrBtnSelected = @"May Be";
        [Btn1 setTitle:@"Yes" forState:UIControlStateNormal];
        [Btn1 setBackgroundImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
        [Btn2 setTitle:@"May Be" forState:UIControlStateNormal];
        [Btn2 setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    }
    
    [ScrlEventDetail setContentSize:CGSizeMake(320, 471)];
    
  /*  NSDate* currentDate2 = [NSDate date];
    NSDateFormatter *_formatter2 = [[NSDateFormatter alloc] init];
    [_formatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
        
    NSString *time1 = [_formatter2 stringFromDate:currentDate2];
        
    NSString *time2 = [NSString stringWithFormat:@"%@ %@",[self.ArrayDetail valueForKey:@"evtStartDate"],[self.ArrayDetail valueForKey:@"evtStartTime"]];

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    NSDate *date1= [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
        
    NSComparisonResult result = [date1 compare:date2];
    if(result == NSOrderedDescending)
    {
        NSLog(@"date1 is later than date2");
        [ScrlEventDetail setFrame:CGRectMake(0, 52, self.view.frame.size.width, self.view.frame.size.height-52)];
        [ViewBottom setHidden:YES];
        [ViewBottom removeFromSuperview];
        pastevent = YES;
    }
    else if(result == NSOrderedAscending)
    {
        NSLog(@"date2 is later than date1");
        pastevent = NO;
    }
    else
    {
        pastevent = NO;
        NSLog(@"date1 is equal to date2");
    }*/
}

-(IBAction)BtnBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(IBAction)BtnYesAction:(id)sender
{
    if (isregistered)
    {
        [Global displayTost:@"Already Registered for Event."];
    }
    else if(![[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        ViewController *viewobj = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [self.navigationController pushViewController:viewobj animated:YES];
    }
    else
    {
        LOADINGSHOW
        StrBtnSelected = @"Yes";
        [self performSelector:@selector(AttendEventAction) withObject:nil afterDelay:0.1f];
    }
}
-(void)AttendEventAction
{
    NSString *str=[NSString stringWithFormat:@"[{\"eadEvtIdi\":\"%@\",\"eadMemId\":\"%ld\",\"eadAttendeeStatus\":\"%@\"}]",[self.ArrayDetail valueForKey:@"evtId"],(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"],StrBtnSelected];
    
    NSDictionary *dict=@{@"action":@"AttendEvent",@"json":str};
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    
    NSLog(@"%@",arry);
    
    if ([[[arry objectAtIndex:0]valueForKey:@"status"]boolValue])
    {
         if ([StrBtnSelected isEqualToString:@"Yes"])
        {
            [Global displayTost:@"Successfuly registered for this event."];
            
            isregistered = YES;
            ismaybe = NO;
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:self.ArrayDetail];
            
            [dict setObject:@"Yes" forKey:@"alreadyregistered"];
            [[self delegate]radiurate:dict replceindex:[self.strname integerValue]];

            StrBtnSelected = @"Yes";
            [Btn1 setTitle:@"Yes" forState:UIControlStateNormal];
            [Btn1 setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
            [Btn2 setTitle:@"May Be" forState:UIControlStateNormal];
            [Btn2 setBackgroundImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
        }
        else  if ([StrBtnSelected isEqualToString:@"May Be"])
        {
            [Global displayTost:@"You will attend event"];
            
            ismaybe = YES;
            isregistered = NO;
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:self.ArrayDetail];
            
            [dict setObject:@"May Be" forKey:@"alreadyregistered"];
            [[self delegate]radiurate:dict replceindex:[self.strname integerValue]];

            StrBtnSelected = @"May Be";
            [Btn1 setTitle:@"Yes" forState:UIControlStateNormal];
            [Btn1 setBackgroundImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
            [Btn2 setTitle:@"May Be" forState:UIControlStateNormal];
            [Btn2 setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        }
         NSLog(@"%@",self.ArrayDetail);
    }
    else
    {
        [Global displayTost:@"Try Again.."];
    }
    
    LOADINGHIDE
}
-(IBAction)BtnMayBeAction:(id)sender
{
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        ViewController *viewobj = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [self.navigationController pushViewController:viewobj animated:YES];
    }
    else if (ismaybe)
    {
        [Global displayTost:@"Already Registered for Event."];
    }
    else
    {
        LOADINGSHOW
         StrBtnSelected = @"May Be";
        [self performSelector:@selector(AttendEventAction) withObject:nil afterDelay:0.1f];
    }
}
-(IBAction)BtnBtnMapAction:(id)sender
{
    EventMapView *DetailObj = [[EventMapView alloc]initWithNibName:@"EventMapView" bundle:nil];
    DetailObj.mapAry = [[NSMutableArray alloc]init];
    [DetailObj.mapAry addObject:ArrayDetail];
    [self.navigationController pushViewController:DetailObj animated:YES];
}
-(IBAction)BtnAddToCalenderAction:(id)sender
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* wakeTime = [df dateFromString:[NSString stringWithFormat:@"%@ %@",[self.ArrayDetail valueForKey:@"evtStartDate"],[self.ArrayDetail valueForKey:@"evtStartTime"]]];
    
    NSDate* endD = [df dateFromString:[NSString stringWithFormat:@"%@ %@",[self.ArrayDetail valueForKey:@"evtEndDate"],[self.ArrayDetail valueForKey:@"evtEndTime"]]];
    
    NSDateComponents *components= [[NSDateComponents alloc] init];
    [components setDay:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *dateIncremented= [calendar dateByAddingComponents:components toDate:endD options:0];
    
    NSString *stringFromDate = [df stringFromDate:dateIncremented];
    NSLog(@"%@", stringFromDate);
    NSDate *datee2 = [df dateFromString:stringFromDate];
    
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:wakeTime
                                                                 endDate:datee2
                                                               calendars:nil];
    NSArray *eventsArray = [eventStore eventsMatchingPredicate:predicate];
    
    if([eventsArray count]!=0)
    {
        for (EKEvent *eventToCheck in eventsArray)
        {
            if ([eventToCheck.title isEqualToString:[NSString stringWithFormat:@"%@",LblEventName.text]])
            {
                already = YES;
                NSLog(@"already  event");
               // [Global displayTost:@"Event already addded to calender."];
                ALREADY
            }
        }
    }
    
    if (already)
    {
        
    }
    else if (pastevent)
    {
        NSLog(@"past event");
        PASTDATE
       // [Global displayTost:@"Event already addded to calender."];
    }
    else
    {
         NSLog(@"add  event");
        // [Global displayTost:@"Event successfully addded to calender."];
        ADDCALENDER
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            EKEvent *event = [EKEvent eventWithEventStore:eventStore];
            EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:-30];
            event.alarms = [NSArray arrayWithObject:alarm];
            event.title = [self.ArrayDetail valueForKey:@"evtName"];
            
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setTimeZone:[NSTimeZone systemTimeZone]];
            [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate* wakeTime = [df dateFromString:[NSString stringWithFormat:@"%@ %@",[self.ArrayDetail valueForKey:@"evtStartDate"],[self.ArrayDetail valueForKey:@"evtStartTime"]]];
            
            NSDate* endD = [df dateFromString:[NSString stringWithFormat:@"%@ %@",[self.ArrayDetail valueForKey:@"evtEndDate"],[self.ArrayDetail valueForKey:@"evtEndTime"]]];
            NSString *str = [df stringFromDate:wakeTime];
            NSString *strE = [df stringFromDate:endD];
            event.startDate = [df dateFromString:str];
            
            NSLog(@"str date %@ end %@",str,strE);
            
            event.endDate =[df dateFromString:strE];
            event.notes = @"Ken JC";
            
            [event setCalendar:[eventStore defaultCalendarForNewEvents]];
            
            NSError *err;
            [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
    }];
    }
    
  
//    if (pastevent)
//    {
//       // [Global displayTost:@"Your schedule added successfully."];
//    }
//    else
//    {
//        EKEventStore *eventStore = [[EKEventStore alloc] init];
//        
//        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//            EKEvent *event = [EKEvent eventWithEventStore:eventStore];
//            EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:-30];
//            event.alarms = [NSArray arrayWithObject:alarm];
//            event.title = [self.ArrayDetail valueForKey:@"evtName"];
//            
//            NSDateFormatter* df = [[NSDateFormatter alloc]init];
//            [df setTimeZone:[NSTimeZone systemTimeZone]];
//            [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            NSDate* wakeTime = [df dateFromString:[NSString stringWithFormat:@"%@ %@",[self.ArrayDetail valueForKey:@"evtStartDate"],[self.ArrayDetail valueForKey:@"evtStartTime"]]];
//            
//            NSDate* endD = [df dateFromString:[NSString stringWithFormat:@"%@ %@",[self.ArrayDetail valueForKey:@"evtEndDate"],[self.ArrayDetail valueForKey:@"evtEndTime"]]];
//            
//            NSDateComponents *components= [[NSDateComponents alloc] init];
//            [components setDay:1];
//            NSCalendar *calendar = [NSCalendar currentCalendar];
//            NSDate *dateIncremented= [calendar dateByAddingComponents:components toDate:endD options:0];
//            
//            NSString *stringFromDate = [df stringFromDate:dateIncremented];
//            NSLog(@"%@", stringFromDate);
//            NSDate *datee2 = [df dateFromString:stringFromDate];
//            
//           NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:wakeTime
//                                                                         endDate:datee2
//                                                                       calendars:nil];
//            NSArray *eventsArray = [eventStore eventsMatchingPredicate:predicate];
//            
//            if([eventsArray count]!=0)
//            {
//                for (EKEvent *eventToCheck in eventsArray)
//                {
//                    if ([eventToCheck.title isEqualToString:[NSString stringWithFormat:@"%@",LblEventName.text]])
//                    {
//                        NSString *strmsg = @"Event already addded to calender.";
//                        [self performSelector:@selector(EventMessageDisplay:) withObject:strmsg afterDelay:0.1f];
//                       // [self EventMessageDisplay:@"Event already addded to calender."];
//
//                       // [Global displayTost:@"Event already added to calender."];
//                        return;
//                      /*  NSLog(@"%@",eventToCheck.eventIdentifier);
//                        
//                        NSString *strEventId;
//                        strEventId = [NSString stringWithFormat:@"%@",eventToCheck.eventIdentifier];
//                        EKEvent* event3 = [eventStore eventWithIdentifier:strEventId];
//                        if (event3 != nil)
//                        {
//                            NSError* error = nil;
//                            [eventStore removeEvent:event3 span:EKSpanThisEvent error:&error];
//                        }
//                        else
//                        {
//                            NSLog(@"else");
//                        }*/
//                    }
//                    
//                    NSString *str = [df stringFromDate:wakeTime];
//                    NSString *strE = [df stringFromDate:endD];
//                    event.startDate = [df dateFromString:str];
//                    
//                    NSLog(@"str date %@ end %@",str,strE);
//                    
//                    event.endDate =[df dateFromString:strE];
//                    event.notes = @"Ken JC";
//                    
//                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
//                    
//                    NSError *err;
//                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
//                    [self EventMessageDisplay:@"Event successfully addded to calender."];
//                   //[Global displayTost:@"Your schedule added successfully."];
//                }
//            }
//            else
//            {
//                NSString *str = [df stringFromDate:wakeTime];
//                NSString *strE = [df stringFromDate:endD];
//                event.startDate = [df dateFromString:str];
//
//                NSLog(@"str date %@ end %@",str,strE);
//   
//                event.endDate =[df dateFromString:strE];
//                event.notes = @"Ken JC";
//                
//                [event setCalendar:[eventStore defaultCalendarForNewEvents]];
//                
//                NSError *err;
//                [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
//                
//                [self EventMessageDisplay:@"Event successfully addded to calender."];
//              // [Global displayTost:@"Your schedule added successfully."];
//            }
//        }];
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - FB Share Action
-(IBAction)Fb:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NewFbPostMethod) withObject:nil afterDelay:0.1f];
    }
    else
    {
        NOINTERNET
        LOADINGHIDE
    }
}
-(void)NewFbPostMethod
{
    NSString *strdescription,*strurl,*strcharityname,*strcaption;

    strdescription = [NSString stringWithFormat:@"Event Name: %@ <br> Event Detail: %@ <br> Event Place: %@ <br> Event Startdate:%@ %@ <br> Event Enddate:%@ %@",[self.ArrayDetail valueForKey:@"evtName"],[self.ArrayDetail valueForKey:@"evtInfo"],[self.ArrayDetail valueForKey:@"evtAddress"],[self.ArrayDetail valueForKey:@"evtStartDate"],[self.ArrayDetail valueForKey:@"evtStartTime"],[self.ArrayDetail valueForKey:@"evtEndDate"],[self.ArrayDetail valueForKey:@"evtEndTime"]];
    
    strurl = [NSString stringWithFormat:@"%@%@",IMAGEURLSIZE,[self.ArrayDetail valueForKey:@"evtImage"]];
   // strurl = [NSString stringWithFormat:@"%@",@"http://kenjc.org/"];
    
    strcharityname = [NSString stringWithFormat:@"%@",@"Ken Jewish Community"];
    
    strcaption = [NSString stringWithFormat:@"%@",@"Ken JC App"];
    
    //    NSString *strdescription = [[NSString stringWithFormat:@"%@",[self.ProductDict valueForKey:@"itmQuickOverview"]]stripHtml];
    //
    //    NSString *strurl = [NSString stringWithFormat:@"%@%@",IMAGEURLSIZE,[self.ProductDict valueForKey:@"defimages"]];
    //
    //    NSString *strcharityname = [NSString stringWithFormat:@"%@",[self.ProductDict valueForKey:@"itmName"]];
    //    NSString *strcaption = [NSString stringWithFormat:@"Price: $%@",[self.ProductDict valueForKey:@"itmPrice"]];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   strcharityname, @"name",
                                   strcaption, @"caption",
                                   strdescription, @"description",
                                   strurl, @"link",
                                   @"", @"picture",
                                   nil];
    
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  if (error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      LOADINGHIDE
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      if (result == FBWebDialogResultDialogNotCompleted) {
                                                          // User cancelled.
                                                          NSLog(@"User cancelled.");
                                                          LOADINGHIDE
                                                      } else {
                                                          // Handle the publish feed callback
                                                          NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                          
                                                          if (![urlParams valueForKey:@"post_id"]) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                              LOADINGHIDE
                                                              
                                                          } else {
                                                              // User clicked the Share button
                                                              LOADINGHIDE
                                                              iToast  *iT = [iToast makeText:@"Your post has been submited successfully."];
                                                              [iT setGravity:iToastGravityCenter];
                                                              [iT setDuration:iToastDurationNormal];
                                                              [iT show];
                                                              
                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                              NSLog(@"result %@", result);
                                                          }
                                                      }
                                                  }
                                              }];
}

// A function for parsing URL parameters.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

#pragma mark - Twitter Share Action
-(IBAction)TwitterAction:(id)sender
{
    NSString *pr_id = [NSString stringWithFormat:@"Event Name: %@\nEvent Place: %@",[self.ArrayDetail valueForKey:@"evtName"],[self.ArrayDetail valueForKey:@"evtAddress"]];
   
    
    
    // Create the view controller
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    //    if([self.strfrom isEqualToString:@"Fromblog"])
    //    {
    //    }
    //    else
    //    {
    //        [twitter addImage:self.imgproduct];
    //    }
    
    // Optional: set an image, url and initial text
    
    //[twitter addURL:[NSURL URLWithString:@"http://goo.gl/Tu7jDX"]];
    [twitter setInitialText:pr_id];
    
    [twitter addImage:ImgEvent.image];
    
   // [twitter addImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@&w=640&h=310&zc=2",IMAGEURLSIZE,[self.ArrayDetail valueForKey:@"evtImage"]]]]]];
    
    // Show the controller
    [self presentViewController:twitter animated:NO completion:nil];
    
    [ViewMain removeFromSuperview];
    
    LOADINGHIDE
    // Called when the tweet dialog has been closed
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result)
    {
        NSString *msg=nil;
        
        if (result == TWTweetComposeViewControllerResultCancelled)
            msg = @"Tweet compostion was canceled.";
        else if (result == TWTweetComposeViewControllerResultDone)
            msg = @"Tweet composition completed.";
        
        [Global displayTost:msg];
        
        // Dismiss the controller
        [self dismissViewControllerAnimated:NO completion:nil];
    };
}

-(IBAction)BtnEmailAction:(id)sender
{
    // Email Subject
     NSString *emailTitle = @"Regarding Ken Jewish Community";
    
    NSString *messageBody = [NSString stringWithFormat:@"Event Name: %@ <br> Event Detail: %@ <br> Event Place: %@ <br> Event Startdate:%@ %@ <br> Event Enddate:%@ %@",[self.ArrayDetail valueForKey:@"evtName"],[[self.ArrayDetail valueForKey:@"evtInfo"]stripHtml],[self.ArrayDetail valueForKey:@"evtAddress"],[self.ArrayDetail valueForKey:@"evtStartDate"],[self.ArrayDetail valueForKey:@"evtStartTime"],[self.ArrayDetail valueForKey:@"evtEndDate"],[self.ArrayDetail valueForKey:@"evtEndTime"]];
    
    NSString *StrEmail = [NSString stringWithFormat:@"%@",@"Kenjc"];
    
    NSArray *toRecipents = [NSArray arrayWithObject:StrEmail];
    
    NSData *jpegData = UIImageJPEGRepresentation(ImgEvent.image, 1);
    
    NSString *fileName = @"jw";
    fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
    
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
    [ViewMain removeFromSuperview];
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

#pragma mark - Whatsp App Share Action
-(IBAction)WhatsApp:(id)sender
{
    NSString *string = [[NSString stringWithFormat:@"whatsapp://send?text=Event Name: %@ \n Event Detail: %@ \n Event Place: %@ \n Event Startdate:%@ %@ \n Event Enddate:%@ %@",[self.ArrayDetail valueForKey:@"evtName"],[self.ArrayDetail valueForKey:@"evtInfo"],[self.ArrayDetail valueForKey:@"evtAddress"],[self.ArrayDetail valueForKey:@"evtStartDate"],[self.ArrayDetail valueForKey:@"evtStartTime"],[self.ArrayDetail valueForKey:@"evtEndDate"],[self.ArrayDetail valueForKey:@"evtEndTime"]]stripHtml];
    
    
//    NSString *string = [NSString stringWithFormat:@"whatsapp://send?text=Ken Jewish Community."];
    
    NSString *escapedSearchText = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"URL%@",escapedSearchText);
    
    NSURL *whatsappURL = [NSURL URLWithString:escapedSearchText];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL])
    {
        [ViewMain removeFromSuperview];
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
    else
    {
        [Global displayTost:@"Sorry, WhatsApp is not installed in your device."];
    }
}

- (IBAction)btnSMSClicked:(id)sender
{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
    if (messageClass != nil) {
        // Check whether the current device is configured for sending SMS messages
        
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
        }
        else {
            [Global displayTost:@"Device not configured to send SMS."];
        }
    }
}

-(void)displaySMSComposerSheet
{
    [ViewMain removeFromSuperview];
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;
	//picker.recipients = [NSArray arrayWithObject:@""];
    if([MFMessageComposeViewController canSendText]) {
        [self.navigationItem setTitle:@"Track Me"];
        picker.body = [[NSString stringWithFormat:@"Event Name: %@\nEvent Detail: %@\nEvent Place: %@\nEvent Startdate:%@ %@\nEvent Enddate:%@ %@",[self.ArrayDetail valueForKey:@"evtName"],[self.ArrayDetail valueForKey:@"evtInfo"],[self.ArrayDetail valueForKey:@"evtAddress"],[self.ArrayDetail valueForKey:@"evtStartDate"],[self.ArrayDetail valueForKey:@"evtStartTime"],[self.ArrayDetail valueForKey:@"evtEndDate"],[self.ArrayDetail valueForKey:@"evtEndTime"]]stripHtml];
        
        //        NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"Icon.png"]);
        //        [picker addAttachmentData:imageData mimeType:@"image/png" fileName:@"image"];
        [self presentViewController:picker animated:YES completion:Nil];
    } else {
        [Global displayTost:@"Device not configured to send SMS."];
    }
}
#pragma mark Dismiss Mail/SMS view controller

// Dismisses the message composition interface when users tap Cancel or Send. Proceeds to update the
// feedback message field with the result of the operation.
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    NSString *message;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MessageComposeResultCancelled:
            message = [NSString stringWithFormat:@"SMS sending canceled"] ;
            //[MyUtility showAlert:@"SMS sending canceled" okbuttontext:@"OK"];
			break;
		case MessageComposeResultSent:
            message = [NSString stringWithFormat:@"SMS sent"] ;
            // [MyUtility showAlert:@"SMS sent" okbuttontext:@"Ok"];
			break;
		case MessageComposeResultFailed:
            message = [NSString stringWithFormat:@"SMS sending failed"] ;
            //[MyUtility showAlert:@"SMS sending failed" okbuttontext:@"OK"];
			break;
		default:
            message = [NSString stringWithFormat:@"SMS not sent"] ;
            // [MyUtility showAlert:@"SMS not sent" okbuttontext:@"OK"];
			break;
	}
    
    [Global displayTost:message];
    [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark - Share View Cancel Action
-(IBAction)BtnCancelAction:(id)sender
{
    [ViewMain removeFromSuperview];
}
-(IBAction)BtnOpenShareViewAction:(id)sender
{
    [ViewMain setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    ViewSub.center = ViewMain.center;
    [self.view addSubview:ViewMain];
}

@end
