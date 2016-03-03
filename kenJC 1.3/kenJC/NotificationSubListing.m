//
//  NotificationListing.m
//  kenJC
//
//  Created by fiplmacmini2 on 12/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "NotificationSubListing.h"
#import "NotificationListingCell.h"
#import "EventListing.h"
#import "ContactListing.h"
#import "MoreListing.h"
#import "EventListingCell.h"
#import "EventListing2.h"

@interface NotificationSubListing ()

@end

@implementation NotificationSubListing
@synthesize TableList,strtype;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TableList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    ArrayNotificationList = [[NSMutableArray alloc]init];
    
    ArrayImages = [[NSMutableArray alloc]initWithObjects:@"date_full_bg.png",@"date_full_bg1.png",@"date_full_bg2.png",@"date_full_bg3.png",@"date_full_bg4.png",nil];
    
    TableList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(GetNotificationListAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
 }

BACK

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)GetNotificationListAction
{
     NSDictionary *dict=@{@"action":@"getnotifications",@"memId":[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"]],@"ntfType":self.strtype};
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    
    if ([self.strtype isEqualToString:@"New Event"])
    {
        for (int i=0; i<[arry count]; i++)
        {
            if ([[[arry objectAtIndex:i]valueForKey:@"evtAddress"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtImage"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtInfo"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtLatitude"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtLongitude"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtName"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtStartDate"]length]!=0)
            {
                [ArrayNotificationList addObject:[arry objectAtIndex:i]];
            }
        }
    }
    else if ([self.strtype isEqualToString:@"Event Reminder"])
    {
        for (int i=0; i<[arry count]; i++)
        {
//            if ([[[arry objectAtIndex:i]valueForKey:@"evtAddress"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtImage"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtInfo"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtLatitude"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtLongitude"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtName"]length]!=0 && [[[arry objectAtIndex:i]valueForKey:@"evtStartDate"]length]!=0)
//            {
                [ArrayNotificationList addObject:[arry objectAtIndex:i]];
           // }
        }
    }
    else
    {
        [ArrayNotificationList addObjectsFromArray:arry];
    }
    
    if (ArrayNotificationList.count==0)
    {
        [Global displayTost:@"No Records Found."];
    }
   
    colorindex = 0;
    [TableList reloadData];
    
    LOADINGHIDE
}
#pragma mark - Tableview Delegate Methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.strtype isEqualToString:@"New Event"] ||[self.strtype isEqualToString:@"Event Reminder"] )
    {
        return 95;
    }
    else
    {
        return 53;
    }
    return 95;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ArrayNotificationList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if ([self.strtype isEqualToString:@"New Event"] || [self.strtype isEqualToString:@"Event Reminder"])
    {
        static NSString *CellIdentifier = @"EventListingCell";
        EventListingCell *cell = (EventListingCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"EventListingCell" owner:self options:nil] objectAtIndex:0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.LblEventName setText:[NSString stringWithFormat:@"%@",[[ArrayNotificationList objectAtIndex:indexPath.row]valueForKey:@"evtName"]]];
        
        [cell.LblEventName setNumberOfLines:0];
        [cell.LblEventName setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSString *tempstring = [[ArrayNotificationList objectAtIndex:indexPath.row]valueForKey:@"evtInfo"];
        
        tempstring = [tempstring stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        
        [cell.LblEventDetails setText:[NSString stringWithFormat:@"%@",[tempstring stripHtml]]];
        
        [cell.LblEventDetails setNumberOfLines:0];
        [cell.LblEventDetails setLineBreakMode:NSLineBreakByWordWrapping];
        [cell.LblEventDetails setTextColor:[UIColor darkGrayColor]];
        
        [cell.imgviewTime setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[ArrayImages objectAtIndex:colorindex]]]];
        
        if (colorindex==0)
        {
            colorindex++;
        }
        else if (colorindex%4==0)
        {
            colorindex = 0;
        }
        else
        {
            colorindex++;
        }
        
        if ([self.strtype isEqualToString:@"Event Reminder"] && [[[ArrayNotificationList objectAtIndex:indexPath.row]valueForKey:@"evtAddress"]length]==0)
        {
            [cell.btnLocation setHidden:YES];
        }
        else
            
        {
           [cell.btnLocation setHidden:NO];
        }
        
        [cell.LblAddress setText:[NSString stringWithFormat:@"%@",[[ArrayNotificationList objectAtIndex:indexPath.row]valueForKey:@"evtAddress"]]];
        
        [cell.imgViewCell setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@&w=%d&h=%d&zc=1",IMAGEURLSIZE,[[ArrayNotificationList objectAtIndex:indexPath.row]valueForKey:@"evtImage"],100*2,95*2]] placeholderImage:nil];
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
        NSDate *now = [dateFormatter1 dateFromString:[[ArrayNotificationList objectAtIndex:indexPath.row]valueForKey:@"evtStartDate"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        NSLog(@"%@",[dateFormatter stringFromDate:now]);
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"HH:mm:ss"];
        NSDate *now2 = [dateFormatter2 dateFromString:[[ArrayNotificationList objectAtIndex:indexPath.row]valueForKey:@"evtStartTime"]];
        NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
        [dateFormatter3 setDateFormat:@"hh:mm a"];
        NSLog(@"%@",[dateFormatter3 stringFromDate:now2]);
        
        NSDateFormatter *dateFormatter4 = [[NSDateFormatter alloc] init];
        [dateFormatter4 setDateFormat:@"yyyy-MMMM-dd"];
        NSLog(@"%@",[dateFormatter4 stringFromDate:now]);
        
        NSArray *ary = [[dateFormatter4 stringFromDate:now] componentsSeparatedByString:@"-"];
        
        [cell.LblTime setText:[NSString stringWithFormat:@"%@\n%@",([dateFormatter stringFromDate:now].length>0)?[dateFormatter stringFromDate:now]:@"",([dateFormatter3 stringFromDate:now2].length>0)?[dateFormatter3 stringFromDate:now2]:@""]];
        
        [cell.LblDate setText:[NSString stringWithFormat:@"%@",([[ary objectAtIndex:2]length]>0)?[ary objectAtIndex:2]:@""]];
        [cell.LblMonth setText:[NSString stringWithFormat:@"%@",([[ary objectAtIndex:1]length]>0)?[ary objectAtIndex:1]:@""]];
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"EventListing2";
        EventListing2 *cell = (EventListing2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"EventListing2" owner:self options:nil] objectAtIndex:0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.LblEventName setText:[NSString stringWithFormat:@"%@",[[ArrayNotificationList objectAtIndex:indexPath.row]valueForKey:@"ntfType"]]];
        
        [cell.LblEventDetails setText:[NSString stringWithFormat:@"%@",[[ArrayNotificationList objectAtIndex:indexPath.row]valueForKey:@"ntfmsgText"]]];
        
        [cell.LblEventName setNumberOfLines:0];
        [cell.LblEventName setLineBreakMode:NSLineBreakByWordWrapping];
        
        return cell;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (IBAction)BtnContact:(id)sender
{
    NSArray *controllerArray = self.navigationController.viewControllers;
    //will get all the controllers added to UINavigationController.
    
    for (id controller in controllerArray)
    {
        // iterate through the array and check for your controller
        if ([controller isKindOfClass:[ContactListing class]])
        {
            //do your stuff here
            [self.navigationController popToViewController:controller animated:NO];
            return;
        }
    }
    
    ContactListing *eventobj  = [[ContactListing alloc]initWithNibName:@"ContactListing" bundle:nil];
    [self.navigationController pushViewController:eventobj animated:NO];
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
- (IBAction)BtnMore:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        NSArray *controllerArray = self.navigationController.viewControllers;
        
        for (id controller in controllerArray)
        {
            if ([controller isKindOfClass:[MoreListing class]])
            {
                [self.navigationController popToViewController:controller animated:NO];
                return;
            }
        }
        
        MoreListing *obj = [[MoreListing alloc] initWithNibName:@"MoreListing" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:NO];
    }
    else
    {
        ViewController *obj = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:YES];
    }
}

@end
